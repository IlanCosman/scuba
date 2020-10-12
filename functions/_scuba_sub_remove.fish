function _scuba_sub_remove
    set -l arg (string lower $argv[1])

    if set -e _scuba_plugins[(contains --index $arg $_scuba_plugins)]
        set -l argEscaped (string escape --style=var $arg)
        set -l fileVarName _scuba_"$argEscaped"_files

        for file in (basename -s .fish $$fileVarName)
            emit "$file"_uninstall
        end

        # Use -R to remove any custom directories
        # Ignore errors as some files may have been in previously removed directories
        rm -R $__fish_config_dir/$$fileVarName 2>/dev/null

        set -e _scuba_"$argEscaped"_files

        printf '%s' (set_color --italics --bold brblue) "$arg removed!" (set_color normal) \n
    else
        printf '%s' (set_color --bold red) "error: " (set_color normal) "target not found: $arg" \n
    end

    exec fish --init-command="set -g fish_greeting
    if test -n \"$argv[2..-1]\"
        _scuba_sub_remove $argv[2..-1]
    end" # Use if test -n so that when removing Scuba you don't get errors
end