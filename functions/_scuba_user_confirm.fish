function _scuba_user_confirm -a default question
    if test $default -eq 0
        set options '[Y/n]'
    else
        set options '[y/N]'
    end

    while true
        switch (read --prompt-str="$question $options ")
            case y Y yes Yes
                return 0
            case n N no No
                return 1
            case ''
                return $default
        end
    end
end