function _scuba_sub_list -a regex
    string match --entire --regex "$regex" $_scuba_plugins
end