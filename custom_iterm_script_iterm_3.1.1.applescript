
on alfred_script(q)
    if application "iTerm2" is running or application "iTerm" is running then
        run script "
            on run {q}
                tell application \"iTerm\"
                    activate
                    try
                        select first window
                        set onlywindow to true
                    on error
                        create window with default profile
                        select first window
                        set onlywindow to true
                    end try
                    tell the first window
                        -- if onlywindow is false then
                            create tab with default profile
                        -- end if
                        repeat while not (is at shell prompt of current session)
                            delay 0.05
                         end repeat
                        tell current session to write text q
                    end tell
                end tell
            end run
        " with parameters {q}
    else
        run script "
            on run {q}
                tell application \"iTerm\"
                    activate
                    try
                        select first window
                    on error
                        create window with default profile
                        select first window
                    end try
                    tell the first window
                        tell current session to write text q
                    end tell
                end tell
            end run
        " with parameters {q}
    end if
end alfred_script
