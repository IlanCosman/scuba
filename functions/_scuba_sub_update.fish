function _scuba_sub_update
    if test -z "$argv"
        set argv $_scuba_plugins
    end

    for arg in $argv
        printf '%s\n' "Updating $arg..."

        if not contains $arg $_scuba_plugins
            printf '%s' (set_color --bold red) "error: " (set_color normal) "target not found: $arg" \n
            continue
        end

        set -l argSplit (string split --right --max=1 '@' $arg)

        set -l argEscaped (string escape --style=var $arg)
        set -l location /tmp/scuba/$argEscaped

        rm -rf $location

        if test -e $arg
            cp -r $arg $location
        else if git clone --quiet https://github.com/$argSplit[1] $location && git -c advice.detachedHead=false -C $location checkout --quiet $argSplit[2]
        else
            printf '%s' (set_color --bold red) "error: " (set_color normal) "target not found: $arg" \n
            continue
        end

        set -l shaName _scuba_"$argEscaped"_sha
        set -l commitsSinceSha (git -C $location rev-list --count $$shaName..HEAD)

        if test "$commitsSinceSha" -gt 0
            printf '%s\n' "Need to update! $commitsSinceSha commits since last update."
            set -a updateList $arg
        else
            printf '%s\n' "$arg is up to date."
        end
    end

    if set -l updateListCount (count $updateList)
        printf '%s\n' "Plugins ($updateListCount):" $updateList

        if _scuba_user_confirm_default_yes "Proceed with update?"
            scuba install $updateList
        end
    end
end