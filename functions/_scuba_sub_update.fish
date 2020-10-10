function _scuba_sub_update
    if test -z "$argv"
        set argv $_scuba_plugins
    end
    _scuba_sub_install $argv
end