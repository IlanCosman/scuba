function _scuba_sub_update
    test -z "$argv" && set argv $_scuba_plugins
    _scuba_sub_install $argv
end