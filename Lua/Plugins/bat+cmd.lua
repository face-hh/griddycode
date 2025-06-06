function main()
    set_extension("bat")
    set_extension("cmd")

    local commands = {
        "echo", "set", "if", "else", "exist", "not", "goto", "call", "pause", "exit", "start",
        "cd", "dir", "del", "copy", "move", "type", "mkdir", "rmdir", "pushd", "popd",
        "for", "in", "do", "choice", "setlocal", "endlocal", "shift", "title", "color", "cls",
        "ver", "time", "date", "chcp", "break", "path", "xcopy", "robocopy", "assoc", "ftype",
        "find", "findstr", "comp", "more", "msg", "timeout", "whoami", "tasklist", "taskkill",
        "wmic", "net", "reg", "sc", "powershell", "pwsh"
    }

    -- Highlight all keywords
    for _, cmd in ipairs(commands) do
        highlight(cmd, color(180, 220, 255))
    end

    -- Common control flow constructs
    highlight("if", color(255, 180, 120))
    highlight("else", color(255, 180, 120))
    highlight("exist", color(255, 200, 100))
    highlight("not", color(255, 200, 100))
    highlight("defined", color(255, 200, 100))

    -- Operators and grouping
    local operators = { "==", "||", "&&", ">", "<", "2>", ">>", "|", "^" }
    for _, op in ipairs(operators) do
        highlight(op, color(255, 255, 150))
    end

    -- Highlighting patterns
    highlight_pattern("rem .*", color(100, 255, 100))     -- REM comments
    highlight_pattern("::.*", color(100, 255, 120))       -- :: comments
    highlight_pattern("@echo%s+%a+", color(255, 200, 100))-- @echo on/off
    highlight_pattern("%%.-%%", color(255, 150, 150))     -- %VAR%
    highlight_pattern("%%%w", color(255, 150, 150))       -- %1, %2
    highlight_pattern(":%w+", color(200, 150, 255))       -- :label
    highlight_pattern("\".-\"", color(180, 220, 255))     -- quoted strings
    highlight_pattern("call%s+:%w+", color(200, 200, 255))-- call :label

    -- For loops
    highlight_pattern("for%s+%%.%s+in%s+%b()%s+do", color(255, 200, 255))

    -- Autocomplete
    function complete()
        for _, word in ipairs(commands) do
            autocomplete(word)
        end

        local vars = {
            "%USERNAME%", "%APPDATA%", "%TEMP%", "%WINDIR%", "%CD%", "%ERRORLEVEL%",
            "%RANDOM%", "%COMPUTERNAME%", "%PROGRAMFILES%", "%SYSTEMROOT%", "%DATE%",
            "%TIME%", "%*", "%~dp0"
        }

        for i = 1, 9 do
            table.insert(vars, "%" .. i .. "%")
        end

        local flow_words = {
            "if", "else", "exist", "not", "defined", "equ", "neq", "lss", "leq", "gtr", "geq"
        }

        for _, v in ipairs(vars) do autocomplete(v) end
        for _, v in ipairs(flow_words) do autocomplete(v) end
    end

    on_complete(complete)
end