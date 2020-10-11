function _scuba_sub_install
    if test -z "$argv"
        return
    end

    if test -e $argv[1]
        set arg (realpath $argv[1])
    else
        set arg (string lower $argv[1])
    end

    if not set -l argSplit (string split '@' $arg)
        set argSplit[2] HEAD
    end

    if contains $arg $_scuba_plugins
        set updating true
    else if contains $argSplit[1] (string split '@' $_scuba_plugins)
        printf '%s' (set_color --bold red) "error: " (set_color normal) "another version of this plugin is already installed: $arg" \n
        exec fish --init-command="set -g fish_greeting; _scuba_sub_install $argv[2..-1]"
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
        exec fish --init-command="set -g fish_greeting; _scuba_sub_install $argv[2..-1]"
    end

    set -l fileVarName _scuba_"$argEscaped"_files

    if test -n "$updating"
        # Use -R to remove any custom directories
        # Ignore errors as some files may have been in previously removed directories
        rm -R $__fish_config_dir/$$fileVarName 2>/dev/null
        printf '%s' (set_color --italics --bold brblue) "$arg updated!" (set_color normal) \n
    else
        set -Ua _scuba_plugins $arg
        printf '%s' (set_color --italics --bold brblue) "$arg installed!" (set_color normal) \n
    end

    if string match --quiet --regex "\.fish\$" $location/* # If there are any top level fish files
        cp $location/*.fish $location/functions # copy them into location's function directory
    end
    cp -R $location/{completions,conf.d,functions} $__fish_config_dir

    set -U _scuba_"$argEscaped"_files (string replace $location '' $location/{completions,conf.d,functions}/**)

    exec fish --init-command="set -g fish_greeting
    if test -n \"$updating\"
        for file in (basename -s .fish $$fileVarName)
            emit \$file'_update'
        end
    end
    for file in (basename -s .fish $$fileVarName)
        emit \$file'_install'
    end
    _scuba_sub_install $argv[2..-1]"
end