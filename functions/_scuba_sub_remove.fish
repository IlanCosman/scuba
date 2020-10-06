function _scuba_sub_remove
    for arg in $argv
        printf '%s\n' "Removing $arg..."

        if not contains $arg $_scuba_plugins
            printf '%s' (set_color --bold red) "error: " (set_color normal) "target not found: $arg" \n
            continue
        end

        set -l argEscaped (string escape --style=var $arg)
        set -l fileVararg _scuba_"$argEscaped"_files

        # Use -r to remove any custom directories
        # Ignore errors, as some files may be contained within directories
        rm -r $__fish_config_dir/$$fileVararg 2>/dev/null

        set -e $fileVararg
        set -e _scuba_plugins[(contains --index $arg $_scuba_plugins)]

        set_color --bold blue
        printf '%s\n' "$arg removed!"
        set_color normal
    end

    exec fish --init-command="set -g fish_greeting"
end