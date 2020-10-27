function _scuba_sub_remove
    for arg in $argv
        if test -e $arg
            set arg (realpath $arg)
        else
            set arg (string lower $arg)
        end

        if set -e _scuba_plugins[(contains --index $arg $_scuba_plugins)] 2>/dev/null
            set -l fileVarName _scuba_(string escape --style var $arg)_files

            set -l basenamedFiles (string replace --all --regex '(^.*/|\.fish$)' '' $$fileVarName)
            for file in $basenamedFiles
                emit "$file"_uninstall
            end

            functions -e $basenamedFiles

            command rm -Rf $__fish_config_dir/$$fileVarName

            set -e $fileVarName

            printf '%s' $_scuba_success "$arg removed" \n
        else
            printf '%s' $_scuba_error "$arg not found" \n
        end
    end
end