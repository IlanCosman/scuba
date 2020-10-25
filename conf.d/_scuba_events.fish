function _scuba_install --on-event _scuba_events_install
    set -U _scuba_error (set_color --bold brred)'» error: '(set_color normal)
    set -U _scuba_success (set_color --bold brgreen)'» '(set_color normal)
    set -U _scuba_warning (set_color --bold bryellow)'» warning: '(set_color normal)
end

function _scuba_uninstall --on-event _scuba_events_uninstall
    set -e _scuba_error
    set -e _scuba_success
    set -e _scuba_warning

    for name in (string escape --style var $_scuba_plugins)
        set -e _scuba_"$name"_files
    end
    set -e _scuba_plugins
end