function _scuba_sub_list -a regex
    string match --entire --invert "IlanCosman/scuba" $_scuba_plugins |
    string match --entire --regex "$regex"
end