function _scuba_sub_remove -a name
    set_color normal
    printf '%s\n' "Removing $name..."

    set -l nameEscaped (string escape --style=var $name)
    
    set -l fileVarName _scuba_"$nameEscaped"_files
    rm $__fish_config_dir/$$fileVarName
    set -e $fileVarName

    set_color --bold blue
    printf '%s\n' "$name removed!"
    set_color normal
end 