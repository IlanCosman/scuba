function _scuba_sub_install
    for arg in $argv
        if test -e $arg
            set arg (realpath $arg)
        else
            set arg (string lower $arg)

            if not set argSplit (string split '@' $arg)
                set argSplit[2] HEAD
            end
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

        rm -R $__fish_config_dir/$$fileVarName 2>/dev/null # If _scuba_"$argEscaped"_files already exists, remove all those files

        if string match --quiet --regex "\.fish\$" $location/* # If there are any top level fish files
            cp $location/*.fish $location/functions # copy them into location's function directory
        end
        cp -R $location/{completions,conf.d,functions} $__fish_config_dir

        for file in $__fish_config_dir/{conf.d,functions}/*
            source $file 2>/dev/null
        end

        set -U _scuba_"$argEscaped"_files (string replace $location '' $location/{completions,conf.d,functions}/**)

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