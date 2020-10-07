function _scuba_user_confirm_default_yes -a question
    while true
        switch (read --prompt-str="$question [Y/n] ")
            case y Y yes Yes ''
                return 0
            case n N no No
                return 1
        end
    end
end