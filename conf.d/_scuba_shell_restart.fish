function _scuba_shell_restart -a code
    exec fish --init-command="set -g fish_greeting; $code"
end