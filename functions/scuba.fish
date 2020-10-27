function scuba
    argparse --stop-nonopt 'v/version' 'h/help' -- $argv

    if set -q _flag_version
        printf '%s\n' 'scuba, version 1.0.0'
    else if set -q _flag_help
        _scuba_help
    else if functions --query _scuba_sub_$argv[1]
        _scuba_sub_$argv[1] $argv[2..-1]
    else
        _scuba_help
        return 1
    end
end

function _scuba_help
    set -l cmd (set_color $fish_color_command)
    set -l param (set_color $fish_color_param)
    set -l b (set_color --bold)
    set -l n (set_color normal)

    printf '%s\n' \
        "Usage:$cmd scuba$n [options]$param subcommand$n" \
        "" \
        "Options:" \
        "  -v or --version  print scuba version" \
        "  -h or --help     print this help message" \
        "" \
        "Subcommands:" \
        $b"  install$n <plugins...>  install plugins" \
        $b"  remove$n <plugins...>   remove installed plugins" \
        $b"  update$n <plugins...>   update installed plugins" \
        $b"  list$n                  list installed plugins matching regex"
end