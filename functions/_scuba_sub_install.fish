function _scuba_sub_install
    if test -z "$argv"
        return
    end

    set -l arg (string lower $argv[1])
    if test -e $arg
        set arg (realpath $arg)
    end

    set -l argEscaped (string escape --style=var $arg)
    set -l location /tmp/scuba/$argEscaped

    if not set -l argSplit (string split '@' $arg)
        set argSplit[2] HEAD
    end

    if contains $arg $_scuba_plugins
        set updating true
    else if contains $argSplit[1] (string split '@' $_scuba_plugins)
        printf '%s' (set_color --bold red) "error: " (set_color normal) "another version of this plugin is already installed: $arg" \n
        exec fish --init-command="set -g fish_greeting; _scuba_sub_install $argv[2..-1]"
    end

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

    if not contains $arg $_scuba_plugins
        set -Ua _scuba_plugins $arg
    end

    if string match --quiet --regex "\.fish\$" $location/* # If there are any top level fish files
        cp $location/*.fish $location/functions # copy them into location's function directory
    end

    cp -r $location/{completions,conf.d,functions} $__fish_config_dir

    set -U _scuba_"$argEscaped"_files (string replace $location '' $location/{completions,conf.d,functions}/**)
    set -l fileVarName _scuba_"$argEscaped"_files

    printf '%s' (set_color --italics --bold brblue) "$arg installed!" (set_color normal) \n

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