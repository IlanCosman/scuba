function _scuba_sub_remove
    for name in $argv
        if not contains $name $_scuba_plugins
            printf '%s' (set_color --bold red) "error: " (set_color normal) "target not found: $name" \n
            continue
        end

        printf '%s\n' "Removing $name..."

        set -l nameEscaped (string escape --style=var $name)
        set -l fileVarName _scuba_"$nameEscaped"_files

        # Use -r to remove any custom directories
        # Ignore errors, as some files may be contained within directories
        rm -r $__fish_config_dir/$$fileVarName 2>/dev/null

        set -e $fileVarName
        set -e _scuba_plugins[(contains --index $name $_scuba_plugins)]

        set_color --bold blue
        printf '%s\n' "$name removed!"
        set_color normal
    end

    exec fish
end