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

        set -l location (mktemp -d)
        set -l locationDirs $location/{completions,conf.d,functions}
        mkdir $locationDirs

        if test -e $arg
            cp -R $arg/* $location
        else if curl --silent https://codeload.github.com/$argSplit[1]/tar.gz/$argSplit[2] |
            tar --extract --gzip --strip-components 1 --directory $location 2>/dev/null
        else
            printf '%s' $_scuba_error "$arg not found" \n
            continue
        end

        cp (string match --entire --regex '\.fish$' $location/*) $location/functions 2>/dev/null

        rm -f $locationDirs/uninstall.fish

        set -l currentFiles (string replace $location '' $locationDirs/*)

        if not contains $arg $_scuba_plugins
            set -l conflictList
            for plugin in $_scuba_plugins
                set -l pluginFileVarName _scuba_(string escape --style=var $plugin)_files
                for file in $currentFiles
                    if contains $file $$pluginFileVarName
                        set -a conflictList $plugin
                        break
                    end
                end
            end
            if test -n "$conflictList"
                printf '%s' $_scuba_warning "$arg conflicts with these plugins:" \n $conflictList\n \n
                switch (read --prompt-str="Install anyway? [y/N] " | string lower)
                    case y ye yes
                    case '*'
                        continue
                end
            end
        end

        set -U _scuba_(string escape --style=var $arg)_files $currentFiles

        cp -R $locationDirs $__fish_config_dir

        for file in $location/{conf.d,functions}/*.fish
            source $file
        end

        if contains $arg $_scuba_plugins
            printf '%s' $_scuba_success "$arg updated" \n
            for file in (string replace --all --regex '(^.*/|\.fish$)' '' $currentFiles)
                emit "$file"_update
            end
        else
            set -Ua _scuba_plugins $arg
            printf '%s' $_scuba_success "$arg installed" \n
            for file in (string replace --all --regex '(^.*/|\.fish$)' '' $currentFiles)
                emit "$file"_install
            end
        end
    end
end