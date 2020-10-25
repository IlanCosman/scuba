function _scuba_sub_install
    for arg in $argv
        fish --command "_scuba_fetch $arg" &
        set -a pidList (jobs --last --pid)
    end
    wait $pidList

    for arg in $argv
        set -l location /tmp/scuba/(string escape --style var $arg)
        set -l locationDirs $location/{completions,conf.d,functions}

        set -l currentFiles (string replace $location '' $locationDirs/*)

        if not contains $arg $_scuba_plugins
            set -l conflictList
            for plugin in $_scuba_plugins
                set -l pluginFileVarName _scuba_(string escape --style var $plugin)_files
                for file in $currentFiles
                    if contains $file $$pluginFileVarName
                        set -a conflictList $plugin
                        break
                    end
                end
            end
            if test -n "$conflictList"
                printf '%s' $_scuba_warning "$arg conflicts with these plugins:" \n $conflictList\n \n
                switch (read --prompt-str "Install anyway? [y/N] " | string lower)
                    case y ye yes
                    case '*'
                        continue
                end
            end
        end

        set -U _scuba_(string escape --style var $arg)_files $currentFiles

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