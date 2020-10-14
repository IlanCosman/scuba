function _scuba_sub_remove
    for arg in $argv
        if set -e _scuba_plugins[(contains --index $arg $_scuba_plugins)]
            set -l argEscaped (string escape --style=var $arg)
            set -l fileVarName _scuba_"$argEscaped"_files
            
            set -l basenamedFiles (basename -s .fish $$fileVarName)
            for file in $basenamedFiles
                emit "$file"_uninstall
            end
            
            functions -e $basenamedFiles
            
            # Use -R to remove any custom directories
            # Ignore errors as some files may have been in previously removed directories
            rm -R $__fish_config_dir/$$fileVarName 2>/dev/null

            set -e _scuba_"$argEscaped"_files

            printf '%s' (set_color --italics --bold brblue) "$arg removed!" (set_color normal) \n
        else
            printf '%s' (set_color --bold red) "error: " (set_color normal) "target not found: $arg" \n
        end
    end
end