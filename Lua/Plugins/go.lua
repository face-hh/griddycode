highlight("var", "reserved")
highlight("const", "reserved")
highlight("for", "reserved")
highlight("if", "reserved")
highlight("else", "reserved")
highlight("func", "reserved")
highlight("range", "reserved")
highlight("break", "reserved")
highlight("default", "reserved")
highlight("interface", "reserved")
highlight("select", "reserved")
highlight("case", "reserved")
highlight("defer", "reserved")
highlight("go", "reserved")
highlight("map", "reserved")
highlight("struct", "reserved")
highlight("chan", "reserved")
highlight("goto", "reserved")
highlight("package", "reserved")
highlight("switch", "reserved")
highlight("fallthrough", "reserved")
highlight("type", "reserved")
highlight("continue", "reserved")
highlight("import", "reserved")
highlight("return", "reserved")

highlight("byte", "reserved")
highlight("rune", "reserved")
highlight("string", "reserved")
highlight("error", "reserved")
highlight("bool", "reserved")
highlight("int", "reserved")
highlight("int8", "reserved")
highlight("int16", "reserved")
highlight("int32", "reserved")
highlight("int64", "reserved")

highlight("uint", "reserved")
highlight("uint8", "reserved")
highlight("uint16", "reserved")
highlight("uint32", "reserved")
highlight("uint64", "reserved")

highlight("uintptr", "reserved")

highlight("float32", "reserved")
highlight("float64", "reserved")

highlight("complex64", "reserved")
highlight("complex128", "reserved")

highlight("false", "binary")
highlight("true", "binary")
highlight("nil", "binary")

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
highlight("!=", "operator")

highlight_region('"', '"', "string")
highlight_region("'", "'", "reserved")
highlight_region('`', '`', "string")
highlight_region('/*', '*/', "comments")
highlight_region('//', '', "comments", true)

add_comment("if err != nil gang")
add_comment("right shift in 2022 KEKW")
add_comment("go for it! I hear it's a great language to pick up")
add_comment("just write it in rust at this point")
add_comment("imagine doing if err != nil every other line")
add_comment("Interfaces in Go? More like vague approximations of functionality")
add_comment("have you ever heard of proper threads?")
add_comment("about time we get actual generics")
add_comment("error handling? who needs that just code and hope for the best")
add_comment("first try first try")
add_comment("GOTTEM")
add_comment("that's just a skill issue at this point")
add_comment("ain't no way 💀")
add_comment("how do you do a while loop in go?")

---@param tbl table<integer, string>
---@param element any
---@return boolean
function table.has(tbl, element)
    for _, elem in ipairs(tbl) do
        if elem == element then
            return true
        end
    end
    return false
end

function detect_functions(content)
    local function_names = {
        ["min"] = "min",
        ["max"] = "max",
        ["println"] = "println",
        ["print"] = "print",
        ["make"] = "make",
        ["new"] = "new",
        ["clear"] = "clear",
        ["append"] = "append",
        ["copy"] = "copy",
        ["close"] = "close",
        ["complex"] = "complex",
        ["real"] = "real",
        ["imag"] = "imag",
        ["delete"] = "delete",
        ["len"] = "len",
        ["cap"] = "cap",
        ["panic"] = "panic",
        ["recover"] = "recover",
    }

    local patterns = {
        "^func%s+([%a%d_]+)%s*%(",
        "^func%s*%(.+%)%s*([%a%d_]+)%s*%("
    }

    for line in content:gmatch("[^\r\n]+") do
        for _, pattern in ipairs(patterns) do
            local match = trim(line):match(pattern)
            if match ~= nil then
                table.insert(function_names, match)
                goto continue
            end
        end
        ::continue::
    end

    return function_names
end

function detect_variables(content)
    local variable_names = {}

    -- TODO: match variable and constant groups
    local patterns = {
        "^var%s+([%a%d_]+)%s*=",
        "^const%s+([%a%d_]+)%s*=",
        "^([%a%d_]+)%s*:=",
    }

    local function_patterns = {
        "^func%s+[%a%d_]+%s*%((.*)%)",
        "^func%s*%(.+%)%s*[%a%d_]+%s*%((.*)%)",
    }

    for line in content:gmatch("[^\r\n]+") do
        for _, pattern in ipairs(patterns) do
            local match = trim(line):match(pattern)
            if match ~= nil then
                table.insert(variable_names, match)
                goto continue
            end
        end
        for _, func_pat in ipairs(function_patterns) do
            local args = line:match(func_pat)
            if args ~= nil then
                for arg in args:gmatch("%s*([^,]+)%s*,?") do
                    local arg_name = arg:match("%s*(%w+)%s*")
                    table.insert(variable_names, arg_name)
                end
                goto continue
            end
        end
        ::continue::
    end

    return variable_names
end
