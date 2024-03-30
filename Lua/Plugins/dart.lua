--- Highlight Keywords
highlight("abstract", "reserved")
highlight("as", "reserved")
highlight("assert", "reserved")
highlight("async", "reserved")
highlight("await", "reserved")
highlight("break", "reserved")
highlight("case", "reserved")
highlight("catch", "reserved")
highlight("class", "reserved")
highlight("const", "reserved")
highlight("continue", "reserved")
highlight("default", "reserved")
highlight("deferred", "reserved")
highlight("do", "reserved")
highlight("dynamic", "reserved")
highlight("else", "reserved")
highlight("enum", "reserved")
highlight("export", "reserved")
highlight("extends", "reserved")
highlight("external", "reserved")
highlight("factory", "reserved")
highlight("false", "reserved")
highlight("final", "reserved")
highlight("finally", "reserved")
highlight("for", "reserved")
highlight("Function", "reserved")
highlight("get", "reserved")
highlight("hide", "reserved")
highlight("if", "reserved")
highlight("implements", "reserved")
highlight("import", "reserved")
highlight("in", "reserved")
highlight("interface", "reserved")
highlight("is", "reserved")
highlight("library", "reserved")
highlight("mixin", "reserved")
highlight("new", "reserved")
highlight("null", "reserved")
highlight("on", "reserved")
highlight("operator", "reserved")
highlight("part", "reserved")
highlight("rethrow", "reserved")
highlight("return", "reserved")
highlight("set", "reserved")
highlight("show", "reserved")
highlight("static", "reserved")
highlight("super", "reserved")
highlight("switch", "reserved")
highlight("sync", "reserved")
highlight("this", "reserved")
highlight("throw", "reserved")
highlight("true", "reserved")
highlight("try", "reserved")
highlight("typedef", "reserved")
highlight("var", "reserved")
highlight("void", "reserved")
highlight("while", "reserved")
highlight("with", "reserved")
highlight("yield", "reserved")

--- Arithmetic Operators
highlight("+", "operator")
highlight("-", "operator")
highlight("*", "operator")
highlight("/", "operator")
highlight("%", "operator")
highlight("++", "operator")
highlight("--", "operator")

--- Assignment Operators
highlight("=", "operator")
highlight("+=", "operator")
highlight("-=", "operator")
highlight("*=", "operator")
highlight("/=", "operator")
highlight("%=", "operator")
highlight("&&=", "operator")
highlight("||=", "operator")
highlight("^=", "operator")
highlight("~=", "operator")
highlight("<<=", "operator")
highlight(">>=", "operator")
highlight(">>>=", "operator")

--- Comparison Operators
highlight("==", "operator")
highlight("!=", "operator")
highlight(">", "operator")
highlight("<", "operator")
highlight(">=", "operator")
highlight("<=", "operator")
highlight("===", "operator")
highlight("!==", "operator")

--- Logical Operators
highlight("&&", "operator")
highlight("||", "operator")
highlight("!", "operator")

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
highlight(",", "special")
highlight(";", "special")
highlight(":", "special")
highlight("?", "special")
highlight("=>", "special")

--- Strings
highlight_region('"', '"', "string")
highlight_region("'", "'", "string")
highlight_region("`", "`", "string") -- Used in backticks for regular expressions, etc.

--- Comments
highlight_region("//", "", "comment", true)
highlight_region("/*", "*/", "comment", true)

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
