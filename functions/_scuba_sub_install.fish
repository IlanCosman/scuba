function _scuba_sub_install
    for name in $argv
        printf '%s\n' "Installing $name..."

        set -l nameEscaped (string escape --style=var $name)
        set -l location /tmp/scuba/$nameEscaped

        rm -rf $location

        if test -e $name
            cp -r $name $location
        else if git clone --quiet --depth=1 https://github.com/$name $location
        else
            printf '%s' (set_color --bold red) "error: " (set_color normal) "target not found: $name" \n
            continue
        end

        if string match --quiet --regex "\.fish\$" $location/* # If there are any top level fish files
            mkdir -p $location/functions
            cp $location/*.fish $location/functions # copy them into location's function directory
        end
        cp -r $location/{completions,conf.d,functions} $__fish_config_dir 2>/dev/null # Don't error if any of the directories don't exist

        set -U _scuba_"$nameEscaped"_files (string replace $location '' $location/{completions,conf.d,functions}/**)

        if not contains $name $_scuba_plugins
            set -Ua _scuba_plugins $name
        end

        source $location/install.fish 2>/dev/null # Don't error if install.fish doesn't exist

        set_color --bold blue
        printf '%s\n' "$name installed!"
        set_color normal
    end

    exec fish
end