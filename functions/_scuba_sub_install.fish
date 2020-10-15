function _scuba_sub_install
    for arg in $argv
        if test -e $arg
            set arg (realpath $arg)
        else
            set arg (string lower $arg)
        end

        if not set -l argSplit (string split '@' $arg)
            set argSplit[2] HEAD
        end

        if contains $arg $_scuba_plugins
            set updating true
        else if contains "$argSplit[1]" (string split '@' $_scuba_plugins)
            printf '%s' (set_color --bold red) "error: " (set_color normal) "another version of this plugin is already installed: $arg" \n
            continue
        end

        set -l argEscaped (string escape --style=var $arg)
        set -l location /tmp/scuba/$argEscaped

        rm -Rf $location
        mkdir -p $location/{completions,conf.d,functions}

        if test -e $arg
            cp -R $arg/* $location
        else if curl --silent https://codeload.github.com/$argSplit[1]/tar.gz/$argSplit[2] |
            tar --extract --gzip --strip-components 1 --directory $location 2>/dev/null
        else
            printf '%s' (set_color --bold red) "error: " (set_color normal) "target not found: $arg" \n
            continue
        end

        set -l fileVarName _scuba_"$argEscaped"_files

        cp (string match --entire --regex "\.fish\$" $location/*) $location/functions 2>/dev/null
        cp -R $location/{completions,conf.d,functions} $__fish_config_dir

        set -U _scuba_"$argEscaped"_files (string replace $location '' $location/{completions,conf.d,functions}/*)

        for file in (string replace $location '' $location/{conf.d,functions}/*)
            source $__fish_config_dir/$file 2>/dev/null # Ignore errors, we might source some directories
        end

        set -l basenamedFiles (basename -s .fish $$fileVarName)
        if test -n "$updating"
            printf '%s' (set_color --italics --bold brblue) "$arg updated!" (set_color normal) \n
            for file in $basenamedFiles
                emit "$file"_update
            end
        else
            set -Ua _scuba_plugins $arg
            printf '%s' (set_color --italics --bold brblue) "$arg installed!" (set_color normal) \n
        end
        for file in $basenamedFiles
            emit "$file"_install
        end
    end
end