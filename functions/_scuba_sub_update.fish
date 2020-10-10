function _scuba_sub_update
    if test -z "$argv"
        set argv $_scuba_plugins
    end

    for arg in (string lower $argv)
        if not contains $arg $_scuba_plugins
            printf '%s' (set_color --bold red) "error: " (set_color normal) "target not found: $arg" \n
            continue
        end

        set -l argSplit (string split '@' $arg)
        set -l argEscaped (string escape --style=var $arg)
        set -l location /tmp/scuba/$argEscaped

        rm -rf $location

        if test -e $argSplit[1]
            cp -r $argSplit[1] $location
        else if git clone --quiet https://github.com/$argSplit[1] $location
        else
            printf '%s' (set_color --bold red) "error: " (set_color normal) "target not found: $argSplit[1]" \n
            continue
        end

        if set -q argSplit[2] && not git -c advice.detachedHead=false -C $location checkout --quiet $argSplit[2]
            printf '%s' (set_color --bold red) "error: " (set_color normal) "target not found: $argSplit[2]" \n
            continue
        end

        set -l shaName _scuba_"$argEscaped"_sha
        set -l commitsSinceSha (git -C $location rev-list --count $$shaName..HEAD)

        if test "$commitsSinceSha" -gt 0
            printf '%s\n' "$arg requires updates. You are $commitsSinceSha commits behind."
            set -a updateList $arg
        else
            printf '%s\n' "$arg is up to date."
        end
    end

    if set -l updateListCount (count $updateList)
        printf '%s\n' "Plugins ($updateListCount):" $updateList

        if _scuba_user_confirm 0 "Proceed with update?"
            _scuba_sub_install --updating $updateList
        end
    end
end