--- Highlight Keywords
highlight("break", "reserved")
highlight("case", "reserved")
highlight("catch", "reserved")
highlight("class", "reserved")
highlight("const", "reserved")
highlight("continue", "reserved")
highlight("debugger", "reserved")
highlight("default", "reserved")
highlight("delete", "reserved")
highlight("do", "reserved")
highlight("else", "reserved")
highlight("enum", "reserved")
highlight("export", "reserved")
highlight("extends", "reserved")
highlight("false", "reserved")
highlight("finally", "reserved")
highlight("for", "reserved")
highlight("function", "reserved")
highlight("if", "reserved")
highlight("import", "reserved")
highlight("in", "reserved")
highlight("instanceof", "reserved")
highlight("new", "reserved")
highlight("null", "reserved")
highlight("return", "reserved")
highlight("super", "reserved")
highlight("switch", "reserved")
highlight("this", "reserved")
highlight("throw", "reserved")
highlight("true", "reserved")
highlight("try", "reserved")
highlight("typeof", "reserved")
highlight("var", "reserved")
highlight("void", "reserved")
highlight("while", "reserved")
highlight("with", "reserved")
highlight("yield", "reserved")
highlight("let", "reserved")
highlight("interface", "reserved")
highlight("type", "reserved")
highlight("async", "reserved")
highlight("await", "reserved")
highlight("public", "reserved")
highlight("private", "reserved")
highlight("protected", "reserved")
highlight("readonly", "reserved")
highlight("static", "reserved")

--- Arithmetic Operators
highlight("+", "operator")
highlight("-", "operator")
highlight("*", "operator")
highlight("/", "operator")
highlight("%", "operator")
highlight("**", "operator")

--- Assignment Operators
highlight("=", "operator")
highlight("+=", "operator")
highlight("-=", "operator")
highlight("*=", "operator")
highlight("/=", "operator")
highlight("%=", "operator")
highlight("**=", "operator")
highlight("&=", "operator")
highlight("|=", "operator")
highlight("^=", "operator")
highlight("<<=", "operator")
highlight(">>=", "operator")
highlight(">>>=", "operator")
highlight("&&=", "operator")
highlight("||=", "operator")
highlight("??=", "operator")

--- Comparison Operators
highlight("==", "operator")
highlight("===", "operator")
highlight("!=", "operator")
highlight("!==", "operator")
highlight(">", "operator")
highlight("<", "operator")
highlight(">=", "operator")
highlight("<=", "operator")

--- Logical Operators
highlight("&&", "operator")
highlight("||", "operator")
highlight("!", "operator")
highlight("??", "operator")

--- Bitwise Operators
highlight("&", "operator")
highlight("|", "operator")
highlight("^", "operator")
highlight("~", "operator")
highlight("<<", "operator")
highlight(">>", "operator")
highlight(">>>", "operator")

--- Special Characters
highlight("{", "special")
highlight("}", "special")
highlight("(", "special")
highlight(")", "special")
highlight("[", "special")
highlight("]", "special")
highlight(".", "special")
highlight(";", "special")
highlight(",", "special")
highlight("<", "special")
highlight(">", "special")
highlight(":", "special")
highlight("?", "special")
highlight("`", "special")
highlight("=>", "special")

--- Strings
highlight_region('"', '"', "string")
highlight_region("'", "'", "string")
highlight_region("`", "`", "string")

--- Comments
highlight_region("//", "", "comment", true)
highlight_region("/*", "*/", "comment", true)

--- TypeScript-specific
highlight("as", "reserved")
highlight("any", "reserved")
highlight("boolean", "reserved")
highlight("constructor", "reserved")
highlight("declare", "reserved")
highlight("get", "reserved")
highlight("module", "reserved")
highlight("namespace", "reserved")
highlight("never", "reserved")
highlight("number", "reserved")
highlight("object", "reserved")
highlight("set", "reserved")
highlight("string", "reserved")
highlight("symbol", "reserved")
highlight("undefined", "reserved")
highlight("unknown", "reserved")

--- Function and Variable Detection
function detect_functions(content)
    local functionNames = {}
    for line in content:gmatch("[^\r\n]+") do
        local functionName = line:match("function%s+([%w_]+)%s*%(")
        if not functionName then
            functionName = line:match("^([%w_]+)%s*%(")
        end
        if functionName then
            table.insert(functionNames, functionName)
        end
    end
    return functionNames
end

function detect_variables(content)
    local variable_names = {}
    for line in content:gmatch("[^\r\n]+") do
        local assignment = line:match("(%w+)%s*=%s*.+")
        if assignment then
            table.insert(variable_names, assignment)
        end
    end
    return variable_names
end
