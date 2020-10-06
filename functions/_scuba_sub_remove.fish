function _scuba_sub_remove
    for arg in $argv
        printf '%s\n' "Removing $arg..."

        if not contains $arg $_scuba_plugins
            printf '%s' (set_color --bold red) "error: " (set_color normal) "target not found: $arg" \n
            continue
        end

        set -e _scuba_plugins[(contains --index $arg $_scuba_plugins)]

        set -l argEscaped (string escape --style=var $arg)
        set -l fileVarName _scuba_"$argEscaped"_files
        set -a uninstalledFiles $$fileVarName

        # Use -r to remove any custom directories
        # Ignore errors, as some files may be contained within directories
        rm -r $__fish_config_dir/$$fileVarName 2>/dev/null

        set -e _scuba_"$argEscaped"_files

        set_color --bold blue
        printf '%s\n' "$arg removed!"
        set_color normal
    end

    _scuba_shell_restart "for file in $uninstalledFiles; emit (basename -s .fish \$file)_uninstall; end"
end