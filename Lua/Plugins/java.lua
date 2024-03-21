highlight("int", "reserved")
highlight("string", "reserved")
highlight("bool", "reserved")
highlight("float", "reserved")

highlight("System", "reserved")
highlight("out", "reserved")
highlight("println", "reserved")

highlight("public", "reserved")
highlight("static", "reserved")
highlight("private", "reserved")


highlight("while", "reserved")
highlight("for", "reserved")

highlight("if", "reserved")
highlight("else", "reserved")
highlight("try", "reserved")
highlight("catch", "reserved")

highlight("extends", "reserved")
highlight("void", "reserved")

highlight("in", "reserved")
highlight("of", "reserved")

highlight("import", "reserved")
highlight("finally", "reserved")

highlight("class", "reserved")
highlight("function", "reserved")
highlight("return", "reserved")
highlight("throw", "reserved")
highlight("continue", "reserved")
highlight("break", "reserved")
highlight("yield", "reserved")

highlight("instanceof", "reserved")
highlight("typeof", "reserved")
highlight("switch", "reserved")
highlight("case", "reserved")
highlight("default", "reserved")
highlight("do", "reserved")

highlight("false", "binary")
highlight("true", "binary")
highlight("null", "binary")
highlight("undefined", "binary")

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
highlight("<=", "operator")
highlight(">=", "operator")
highlight("%", "operator")
highlight("==", "operator")
highlight("===", "operator")
highlight("!=", "operator")
highlight("!==", "operator")

highlight("{", "binary")
highlight("}", "binary")
highlight("[", "binary")
highlight("]", "binary")



highlight_region("\"", "\"", "string")
highlight_region("'", "'", "string")
highlight_region("`", "`", "string")
highlight_region("/*", "*/", "comments")
highlight_region("//", "", "comments", true)

--- comments
add_comment("Java mentioned 🗣️🗣️🗣️ 3 + \"3\" = 33 🔥🔥🔥")
add_comment("nah bro fuck js 🗣️🗣️🗣️🗣️🗣️🗣️🗣️🗣️🗣️🗣️‼️‼️💥💥💥🤯")
add_comment("When I thought it couldn’t get any worse he added another require() 💀💀💀")
add_comment("WHAT THE FUCK STOP")
add_comment("this shi 100% breaking")
add_comment("do NOT drink battery acid")
add_comment("Waiter, waiter! One more for loop please!")
add_comment("RAHHHH JAVASCRIPT +!~-x !+((a,b)=>!!a?!a:!b) 🗣️🗣️🔥🔥🔥🔥🔥🔥🔥")
add_comment("a ? b ? a : b ? c : d : b ass script")
add_comment("try {} catch(e) { throw new Error(e) }")
add_comment("mf the typa guy to trigger \"require is not defined\"")
add_comment("im scared")
add_comment("more?.optional?.chaining?.please // LGTM")
add_comment("tip: remove runtime errors by removing null: rm -rf /dev/null")
add_comment("JAVASCRIPTTTTTTTTTTTT LETS FUCKING GOOOO ==== X ?? Y ? GOOOO : X 🗣️🗣️🗣️")
add_comment("wrap it in do {} while(false) 👍👍👍")
add_comment("\"undefined\" is not defined.")
add_comment("make your JS roleplay Java, change that i++ to i--")
add_comment("tip: decrease your chance at errors: Number.MAX_SAFE_INTEGER += Number.MAX_SAFE_INTEGER")
add_comment("tip: Use VSCODE")

--- autocomplete

function detect_functions(content)
    local functionNames = {}

    local lines = {}
    for line in content:gmatch("[^\r\n]+") do
        table.insert(lines, line)
    end

    for _, line in ipairs(lines) do
        if (string.find(line, "void ")) and string.find(line, "%(") then
            local functionName =
                string.match(trim(line):gsub("{", ""), "void%s+(.-)%s*%(")
            table.insert(functionNames, functionName)
        end
    end

    return functionNames
end

function detect_variables(content)
    local variable_names = {}
    local lines = content:gmatch("[^\r\n]+")

    for line in lines do
        if line:find("int ") or line:find("bool ") or line:find("string ") or line:find("float ") then
            local parts = splitstr(line, "=")
            if #parts > 0 then
                local variable_name = trim(splitstr(trim(parts[1]), " ")[2])
                table.insert(variable_names, variable_name)
            end
        end
    end

    return variable_names
end