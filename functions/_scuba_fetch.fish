function _scuba_fetch -a arg location
    if not set argSplit (string split '@' $arg)
        set argSplit[2] HEAD
    end

    mkdir $location/{completions,conf.d,functions}

    if test -e $arg
        cp -R $arg/* $location
    else if curl --silent https://codeload.github.com/$argSplit[1]/tar.gz/$argSplit[2] |
        tar --extract --gzip --strip-components 1 --directory $location 2>/dev/null
    else
        printf '%s' $_scuba_error "$arg not found" \n
        rm -R $location
        return
    end

    cp (string match --entire --regex '\.fish$' $location/*) $location/functions 2>/dev/null

    rm -f $location/{completions,conf.d,functions}/uninstall.fish
end