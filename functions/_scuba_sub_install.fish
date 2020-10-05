function _scuba_sub_install -a name
    set_color normal
    printf '%s\n' "Installing $name..."

    set -l nameEscaped (string escape --style=var $name)
    set -l location /tmp/scuba/$nameEscaped

    rm -rf $location

    if test -e $name
        cp -r $name $location
    else
        git clone --quiet --depth=1 https://github.com/$name $location
    end

    # Don't error if any of these directories doesn't exist
    cp -r $location/{completions,conf.d,functions} $__fish_config_dir 2>/dev/null

    source $location/install.fish 2>/dev/null # Don't error if install.fish doesn't exist

    set -U _scuba_"$nameEscaped"_files (string replace $location '' $location/{completions,conf.d,functions}/**)
    set -l fileVarName _scuba_"$nameEscaped"_files
    for file in $$fileVarName
        source $__fish_config_dir/$file
    end

    set_color --bold blue
    printf '%s\n' "$name installed!"
    set_color normal
end