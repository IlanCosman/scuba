function scuba
    argparse --stop-nonopt 'v/version' 'h/help' -- $argv
    set -l subcommand $argv[1]

    if set -q _flag_version
        printf '%s\n' "scuba, version 0.1"
        return 0
    else if set -q _flag_help
        _scuba_help
        return 0
    else if functions --query _scuba_sub_$subcommand
        _scuba_sub_$subcommand $argv[2..-1]
    else
        _scuba_help
        return 1
    end
end

function _scuba_help
    printf '%s\n' "Help message"
end