complete -c scuba -x -n __fish_use_subcommand -a install -d "Install plugins"
complete -c scuba -x -n __fish_use_subcommand -a remove -d "Remove plugins"
complete -c scuba -x -n __fish_use_subcommand -a list -d "List installed plugins matching regex"
complete -c scuba -x -n __fish_use_subcommand -a --help -d "Print help message"
complete -c scuba -x -n __fish_use_subcommand -a --version -d "Print scuba version"

for plugin in $_scuba_plugins
    complete -c scuba -x -n "__fish_seen_subcommand_from remove" -a $plugin
end