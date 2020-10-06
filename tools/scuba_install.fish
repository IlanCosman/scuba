function scuba_install
    set -l location /tmp/scuba

    rm -rf $location
    git clone --quiet --depth=1 https://github.com/IlanCosman/scuba $location
    cp -r $location/{completions,conf.d,functions} $__fish_config_dir 2>/dev/null

    fish --init-command="scuba install IlanCosman/scuba"
end