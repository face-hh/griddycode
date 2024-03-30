--- Highlight Keywords
highlight("abstract", "reserved")
highlight("and", "reserved")
highlight("array", "reserved")
highlight("as", "reserved")
highlight("break", "reserved")
highlight("callable", "reserved")
highlight("case", "reserved")
highlight("catch", "reserved")
highlight("class", "reserved")
highlight("clone", "reserved")
highlight("const", "reserved")
highlight("continue", "reserved")
highlight("declare", "reserved")
highlight("default", "reserved")
highlight("die", "reserved")
highlight("do", "reserved")
highlight("echo", "reserved")
highlight("else", "reserved")
highlight("elseif", "reserved")
highlight("empty", "reserved")
highlight("enddeclare", "reserved")
highlight("endfor", "reserved")
highlight("endforeach", "reserved")
highlight("endif", "reserved")
highlight("endswitch", "reserved")
highlight("endwhile", "reserved")
highlight("eval", "reserved")
highlight("exit", "reserved")
highlight("extends", "reserved")
highlight("final", "reserved")
highlight("finally", "reserved")
highlight("fn", "reserved")
highlight("for", "reserved")
highlight("foreach", "reserved")
highlight("function", "reserved")
highlight("global", "reserved")
highlight("goto", "reserved")
highlight("if", "reserved")
highlight("implements", "reserved")
highlight("include", "reserved")
highlight("include_once", "reserved")
highlight("instanceof", "reserved")
highlight("insteadof", "reserved")
highlight("interface", "reserved")
highlight("isset", "reserved")
highlight("list", "reserved")
highlight("match", "reserved")
highlight("namespace", "reserved")
highlight("new", "reserved")
highlight("or", "reserved")
highlight("print", "reserved")
highlight("private", "reserved")
highlight("protected", "reserved")
highlight("public", "reserved")
highlight("readonly", "reserved")
highlight("require", "reserved")
highlight("require_once", "reserved")
highlight("return", "reserved")
highlight("static", "reserved")
highlight("switch", "reserved")
highlight("throw", "reserved")
highlight("trait", "reserved")
highlight("try", "reserved")
highlight("unset", "reserved")
highlight("use", "reserved")
highlight("var", "reserved")
highlight("while", "reserved")
highlight("xor", "reserved")
highlight("yield", "reserved")

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
highlight(".=", "operator")

--- Comparison Operators
highlight("==", "operator")
highlight("!=", "operator")
highlight("<>", "operator")
highlight("===", "operator")
highlight("!==", "operator")
highlight("<", "operator")
highlight(">", "operator")
highlight("<=", "operator")
highlight(">=", "operator")
highlight("<=>", "operator")

--- Increment/Decrement Operators
highlight("++", "operator")
highlight("--", "operator")

--- Logical Operators
highlight("and", "operator")
highlight("or", "operator")
highlight("xor", "operator")
highlight("!", "operator")
highlight("&&", "operator")
highlight("||", "operator")

--- String Operators
highlight(".", "operator")
highlight(".=", "operator")

--- Array Operators
highlight("+", "operator")
highlight("-", "operator")

--- Type Operators
highlight("instanceof", "operator")

--- Special Characters
highlight("$", "special") -- Variable Sign
highlight("=>", "special")
highlight("::", "special") -- Scope Resolution Operator
highlight("->", "special") -- Object Operator
highlight(";", "special")
highlight(":", "special")
highlight(",", "special")
highlight("?", "special")
highlight("@", "special") -- Error Control Operator
highlight("&", "special")

--- Strings
highlight_region("'", "'", "string")
highlight_region('"', '"', "string")
highlight_region("`", "`", "string")

--- Heredoc and Nowdoc
highlight_region("<<<'EOD'", "'EOD'", "string")
highlight_region("<<<EOD", "EOD", "string")

--- Comments
highlight_region("//", "", "comment", true)
highlight_region("#", "", "comment", true)
highlight_region("/*", "*/", "comment", true)

--- Function and Variable Detection
function detect_functions(content)
    local functionNames = {}
    for line in content:gmatch("[^\r\n]+") do
        local functionName = line:match("function%s+([%w_]+)%s*%(")
        if functionName then
            table.insert(functionNames, functionName)
        end
    end
    return functionNames
end

function detect_variables(content)
    local variable_names = {}
    for line in content:gmatch("[^\r\n]+") do
        local variable = line:match("%$([%w_]+)")
        if variable then
            table.insert(variable_names, variable)
        end
    end
    return variable_names
end
