function scuba
    argparse --stop-nonopt 'v/version' 'h/help' -- $argv

    if set -q _flag_version
        printf '%s\n' 'scuba, version 1.0.0'
    else if set -q _flag_help
        printf '%s\n' \
            "Usage: scuba [option] subcommand" \
            "" \
            "Options:" \
            "  -v or --version  print scuba version" \
            "  -h or --help     print this help message" \
            "" \
            "Subcommands:" \
            "  install <plugin(s)>   install plugins" \
            "  remove  <plugin(s)>   remove installed plugins" \
            "  update  [plugin(s)]   update installed plugins" \
            "  list    <regex>       list installed plugins matching regex"
    else if functions --query _scuba_sub_$argv[1]
        _scuba_sub_$argv[1] $argv[2..-1]
    else
        printf '%s' $_scuba_error 'no operation specified (use -h for help)' \n
        return 1
    end
end