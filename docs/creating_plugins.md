# Creating a plugin

## Event system

Scuba has a robust install, update, and uninstall event system. Remember that functions with event handlers must already be greedily loaded. Thus, you should put your event handlers in the `conf.d` directory. Real world examples are the easiest way of understanding this.

### Install

```fish
# File conf.d/blah.fish

function _blah_install --on-event blah_install
    set -U _blah_version 3.0.0
    # set other universal variables...

    echo "Thanks for installing blah!"
end
```

### Update

When updating, the `update` event is emitted, followed by the `install` event.

```fish
# File conf.d/blah.fish

function _blah_update --on-event blah_update
    # Not all users have switched over to version 3.0 yet. We should warn them about breaking changes.
    if string match --entire --regex "^2" $_blah_version # If the version starts with a 2
        echo "Welcome to version 3.0 of blah!"
        echo "Here are some breaking changes you might want to know about:"
        # list breaking changes...
    end
end
```

### Uninstall

```fish
# File conf.d/blah.fish

function _blah_uninstall --on-event blah_uninstall
    set -e _blah_version
    # erase other universal variables...

    echo "Sorry to see you go :("
end
```
