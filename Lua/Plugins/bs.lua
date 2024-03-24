highlight("let", "reserved")
highlight("const", "reserved")

highlight("while", "reserved")
highlight("for", "reserved")

highlight("if", "reserved")
highlight("else", "reserved")
highlight("try", "reserved")
highlight("catch", "reserved")

highlight("fn", "reserved")

highlight("false", "binary")
highlight("true", "binary")
highlight("null", "binary")

highlight("+", "operator")
highlight("-", "operator")
highlight("/", "operator")
highlight("*", "operator")
highlight("+=", "operator")
highlight("-=", "operator")
highlight("/=", "operator")
highlight("*=", "operator")
highlight("<", "operator")
highlight(">", "operator")
highlight("==", "operator")
highlight("!=", "operator")

highlight("{", "binary")
highlight("}", "binary")

highlight_region("\"", "\"", "string", true)

add_comment("💀 use Bussin X lil bro")
add_comment("who tf told you to add another \"else if\"")
add_comment("no you can't place a semicolon there")
add_comment("blud is using a typescript esolang 🗣️💯🔥")

function detect_variables(content)
    -- default variables that bs includes
    local variable_names = {
        "error",
        "math",
        "fs"
    }
    local lines = content:gmatch("[^\r\n]+")

    for line in lines do
        if trim(line):find("^let ") or trim(line):find("^const ") then
            local parts = splitstr(line, "=")
            if #parts > 0 then
                local variable_name = trim(splitstr(trim(parts[1]), " ")[2])
                table.insert(variable_names, variable_name)
            end
        end
    end

    return variable_names
end

function detect_functions(content)
    -- default functions that bs includes
    local functionNames = {
        "println",
        "exec",
        "charat",
        "input",
        "strcon",
        "format",
        "time",
        "setTimeout",
        "setInterval",
        "exit",
        "fetch",
        "len"
    }
    local lines = content:gmatch("[^\r\n]+")

    for line in lines do
        if (trim(line):find("^fn ")) and trim(line):find("%(") then
            local functionName = string.match(trim(line):gsub("{", ""), "fn%s+(.-)%s*%(")
            table.insert(functionNames, functionName)
        end
    end

    return functionNames
end
