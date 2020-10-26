# Creating a plugin

## Event system

Scuba has a robust install, update, and uninstall event system. Remember that functions with event handlers must already be loaded when their event is emitted. Thus, you should put your event handlers in the `conf.d` directory.

### Install

```fish
# File conf.d/foo_events.fish

function _foo_events_install --on-event foo_events_install
    set -U _foo_events_version 3.0.0
    # set other universal variables...

    echo "Thanks for installing foo_events!"
end
```

### Update

```fish
# File conf.d/foo_events.fish

function _foo_events_update --on-event foo_events_update
    # Not all users have switched over to version 3.0 yet. We should warn them about breaking changes.
    if string match --entire --regex "^2" $_foo_events_version # If the version starts with a 2
        echo "Welcome to version 3.0 of foo_events!"
        echo "Here are some breaking changes you might want to know about:"
        # list breaking changes...
        echo "Please remove and reinstall foo."
    end
end
```

### Uninstall

```fish
# File conf.d/foo_events.fish

function _foo_events_uninstall --on-event foo_events_uninstall
    set -e _foo_events_version
    # erase other universal variables...

    echo "Sorry to see you go :("
end
```
