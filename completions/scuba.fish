complete -c scuba -x -n __fish_use_subcommand -a --help -d "Print help message"
complete -c scuba -x -n __fish_use_subcommand -a --version -d "Print scuba version"
complete -c scuba -x -n __fish_use_subcommand -a bug-report -d "Print info for use in bug reports"
complete -c scuba -x -n __fish_use_subcommand -a install -d "Install plugins"
complete -c scuba -x -n __fish_use_subcommand -a list -d "List installed plugins"
complete -c scuba -x -n __fish_use_subcommand -a remove -d "Remove plugins"
complete -c scuba -x -n __fish_use_subcommand -a update -d "Update plugins"

for plugin in (_scuba_sub_list)
    complete -c scuba -x -n "__fish_seen_subcommand_from remove" -a $plugin
    complete -c scuba -x -n "__fish_seen_subcommand_from update" -a $plugin
end