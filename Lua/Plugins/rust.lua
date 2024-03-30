--- Highlight Keywords
highlight("as", "reserved")
highlight("break", "reserved")
highlight("const", "reserved")
highlight("continue", "reserved")
highlight("crate", "reserved")
highlight("else", "reserved")
highlight("enum", "reserved")
highlight("extern", "reserved")
highlight("false", "reserved")
highlight("fn", "reserved")
highlight("for", "reserved")
highlight("if", "reserved")
highlight("impl", "reserved")
highlight("in", "reserved")
highlight("let", "reserved")
highlight("loop", "reserved")
highlight("match", "reserved")
highlight("mod", "reserved")
highlight("move", "reserved")
highlight("mut", "reserved")
highlight("pub", "reserved")
highlight("ref", "reserved")
highlight("return", "reserved")
highlight("self", "reserved")
highlight("Self", "reserved")
highlight("static", "reserved")
highlight("struct", "reserved")
highlight("super", "reserved")
highlight("trait", "reserved")
highlight("true", "reserved")
highlight("type", "reserved")
highlight("unsafe", "reserved")
highlight("use", "reserved")
highlight("where", "reserved")
highlight("while", "reserved")
highlight("async", "reserved")
highlight("await", "reserved")
highlight("dyn", "reserved")

--- Arithmetic and Bitwise Operators
highlight("+", "operator")
highlight("-", "operator")
highlight("*", "operator")
highlight("/", "operator")
highlight("%", "operator")
highlight("<<", "operator")
highlight(">>", "operator")
highlight("&", "operator")
highlight("|", "operator")
highlight("^", "operator")
highlight("!=", "operator")
highlight("==", "operator")
highlight(">", "operator")
highlight("<", "operator")
highlight(">=", "operator")
highlight("<=", "operator")
highlight("&&", "operator")
highlight("||", "operator")
highlight("!", "operator")

--- Assignment Operators
highlight("=", "operator")
highlight("+=", "operator")
highlight("-=", "operator")
highlight("*=", "operator")
highlight("/=", "operator")
highlight("%=", "operator")
highlight("&=", "operator")
highlight("|=", "operator")
highlight("^=", "operator")
highlight("<<=", "operator")
highlight(">>=", "operator")

--- Special Characters
highlight("{", "special")
highlight("}", "special")
highlight("(", "special")
highlight(")", "special")
highlight("[", "special")
highlight("]", "special")
highlight("->", "special")
highlight("=>", "special")
highlight("::", "special")
highlight(";", "special")
highlight("_", "special")
highlight("'", "special")
highlight(":", "special")
highlight(",", "special")

--- Strings and Characters
highlight_region('"', '"', "string")
highlight_region("'", "'", "character")

--- Comments
highlight_region("//", "", "comment", true)
highlight_region("/*", "*/", "comment", true)

--- Function and Variable Detection
function detect_functions(content)
    local functionNames = {}
    for line in content:gmatch("[^\r\n]+") do
        local functionName = line:match("fn%s+([%w_]+)%s*%b()")
        if functionName then
            table.insert(functionNames, functionName)
        end
    end
    return functionNames
end

function detect_variables(content)
    local variable_names = {}
    for line in content:gmatch("[^\r\n]+") do
        local assignment = line:match("let%s+(mut%s+)?([%w_]+)%s*=")
        if assignment then
            table.insert(variable_names, assignment)
        end
    end
    return variable_names
end
