function _scuba_sub_install
    for arg in $argv
        printf '%s\n' "Installing $arg..."

        set -l argSplit (string split --right --max=1 '@' $arg)

        set -l argEscaped (string escape --style=var $arg)
        set -l location /tmp/scuba/$argEscaped

        rm -rf $location

        if test -e $arg
            cp -r $arg $location
        else if git clone https://github.com/$argSplit[1] $location && git -c advice.detachedHead=false -C $location checkout $argSplit[2]
        else
            printf '%s' (set_color --bold red) "error: " (set_color normal) "target not found: $arg" \n
            continue
        end

        if not contains $arg $_scuba_plugins
            set -Ua _scuba_plugins $arg
        end

        if string match --quiet --regex "\.fish\$" $location/* # If there are any top level fish files
            mkdir -p $location/functions
            cp $location/*.fish $location/functions # copy them into location's function directory
        end
        cp -r $location/{completions,conf.d,functions} $__fish_config_dir 2>/dev/null # Don't error if any directory doesn't exist

        set -U _scuba_"$argEscaped"_files (string replace $location '' $location/{completions,conf.d,functions}/**)
        set -l fileVarName _scuba_"$argEscaped"_files
        set -a installedFiles $$fileVarName

        set_color --bold blue
        printf '%s\n' "$arg installed!"
        set_color normal
    end

    exec fish --init-command="set -g fish_greeting; for file in $installedFiles; emit (basename -s .fish \$file)_install; end;"
end