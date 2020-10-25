function _scuba_fetch -a arg
    if test -e $arg
        set arg (realpath $arg)
    else
        set arg (string lower $arg)

        if not set argSplit (string split '@' $arg)
            set argSplit[2] HEAD
        end
    end

    set -l location /tmp/scuba/(string escape --style var $arg)
    set -l locationDirs $location/{completions,conf.d,functions}
    mkdir -p $locationDirs

    if test -e $arg
        cp -R $arg/* $location
    else if curl --silent https://codeload.github.com/$argSplit[1]/tar.gz/$argSplit[2] |
        tar --extract --gzip --strip-components 1 --directory $location 2>/dev/null
    else
        printf '%s' $_scuba_error "$arg not found" \n
    end

    cp (string match --entire --regex '\.fish$' $location/*) $location/functions 2>/dev/null

    rm -f $locationDirs/uninstall.fish
end