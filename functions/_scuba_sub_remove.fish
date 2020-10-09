function _scuba_sub_remove
    if not set -q argv[1] # If argv[1] doesn't exist
        return
    end

    set -l arg (string lower $argv[1])

    printf '%s\n' "Removing $arg..."

    if set -e _scuba_plugins[(contains --index $arg $_scuba_plugins)]
        set -l argEscaped (string escape --style=var $arg)
        set -l fileVarName _scuba_"$argEscaped"_files

        # Use -r to remove any custom directories
        # Ignore errors, as some files may be contained within directories
        rm -r $__fish_config_dir/$$fileVarName 2>/dev/null

        for file in (basename -s .fish $$fileVarName)
            emit "$file"_uninstall
        end

        set -e _scuba_"$argEscaped"_files

        set_color --bold blue
        printf '%s\n' "$arg removed!"
        set_color normal
    else
        printf '%s' (set_color --bold red) "error: " (set_color normal) "target not found: $arg" \n
    end

    exec fish --init-command="set -g fish_greeting; _scuba_sub_remove $argv[2..-1]"
end