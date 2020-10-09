function _scuba_sub_install
    argparse --stop-nonopt 'u-updating' -- $argv

    if not set -q argv[1] # If argv[1] doesn't exist
        return
    end

    set -l arg (string lower $argv[1])
    set -l argEscaped (string escape --style=var $arg)
    set -l location /tmp/scuba/$argEscaped

    printf '%s\n' "Installing $arg..."

    if not set -q _flag_updating
        set -l argSplit (string split --right --max=1 '@' $arg)

        if contains $argSplit[1] $_scuba_plugins_without_version
            printf '%s' (set_color --bold red) "error: " (set_color normal) "another version of this plugin is already installed: $arg" \n
            exec fish --init-command="set -g fish_greeting; _scuba_sub_install $argv[2..-1]"
        end

        rm -rf $location

        if test -e $argSplit[1]
            cp -r $argSplit[1] $location
        else if GIT_TERMINAL_PROMPT=0 git clone https://github.com/$argSplit[1] $location
        else
            printf '%s' (set_color --bold red) "error: " (set_color normal) "target not found: $argSplit[1]" \n
            exec fish --init-command="set -g fish_greeting; _scuba_sub_install $argv[2..-1]"
        end

        if set -q argSplit[2] && not git -c advice.detachedHead=false -C $location checkout $argSplit[2]
            printf '%s' (set_color --bold red) "error: " (set_color normal) "target not found: $argSplit[2]" \n
            exec fish --init-command="set -g fish_greeting; _scuba_sub_install $argv[2..-1]"
        end

        set -Ua _scuba_plugins_without_version $argSplit[1]

        if not contains $arg $_scuba_plugins
            set -Ua _scuba_plugins $arg
        end
    end

    set -U _scuba_"$argEscaped"_sha (git -C $location rev-parse HEAD 2>/dev/null)

    mkdir -p $location/{completions,conf.d,functions}

    if string match --quiet --regex "\.fish\$" $location/* # If there are any top level fish files
        cp $location/*.fish $location/functions # copy them into location's function directory
    end

    cp -r $location/{completions,conf.d,functions} $__fish_config_dir

    set -U _scuba_"$argEscaped"_files (string replace $location '' $location/{completions,conf.d,functions}/**)
    set -l fileVarName _scuba_"$argEscaped"_files

    set_color --bold blue
    printf '%s\n' "$arg installed!"
    set_color normal

    exec fish --init-command="set -g fish_greeting
    if test -n \"$_flag_updating\"
        for file in (basename -s .fish $$fileVarName)
            emit \$file'_update'
        end
    end
    for file in (basename -s .fish $$fileVarName)
        emit \$file'_install'
    end
    _scuba_sub_install $argv[2..-1]"
end