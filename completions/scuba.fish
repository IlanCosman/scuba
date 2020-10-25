complete -c scuba -x -l help
complete -c scuba -x -l version
complete -c scuba -x -n '__fish_use_subcommand' -a install -d 'Install plugins'
complete -c scuba -x -n '__fish_use_subcommand' -a list -d 'List installed plugins matching regex'
complete -c scuba -x -n '__fish_use_subcommand' -a remove -d 'Remove plugins'
complete -c scuba -x -n '__fish_use_subcommand' -a update -d 'Update plugins'

for plugin in $_scuba_plugins
    complete -c scuba -x -n '__fish_seen_subcommand_from remove' -a $plugin
    complete -c scuba -x -n '__fish_seen_subcommand_from update' -a $plugin
end