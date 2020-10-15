function _scuba_sub_remove
    for arg in $argv
        if set -e _scuba_plugins[(contains --index $arg $_scuba_plugins)] 2>/dev/null
            set -l argEscaped (string escape --style=var $arg)
            set -l fileVarName _scuba_"$argEscaped"_files

            set -l basenamedFiles (basename -s .fish $$fileVarName)
            for file in $basenamedFiles
                emit "$file"_uninstall
            end
            
            functions -e $basenamedFiles

            rm -R $__fish_config_dir/$$fileVarName

            set -e _scuba_"$argEscaped"_files

            printf '%s' (set_color --italics --bold brblue) "$arg removed!" (set_color normal) \n
        else
            printf '%s' (set_color --bold red) "error: " (set_color normal) "target not found: $arg" \n
        end
    end
end