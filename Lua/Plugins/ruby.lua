--- Highlight Keywords
highlight("BEGIN", "reserved")
highlight("END", "reserved")
highlight("alias", "reserved")
highlight("and", "reserved")
highlight("begin", "reserved")
highlight("break", "reserved")
highlight("case", "reserved")
highlight("class", "reserved")
highlight("def", "reserved")
highlight("defined?", "reserved")
highlight("do", "reserved")
highlight("else", "reserved")
highlight("elsif", "reserved")
highlight("end", "reserved")
highlight("ensure", "reserved")
highlight("false", "reserved")
highlight("for", "reserved")
highlight("if", "reserved")
highlight("in", "reserved")
highlight("module", "reserved")
highlight("next", "reserved")
highlight("nil", "reserved")
highlight("not", "reserved")
highlight("or", "reserved")
highlight("redo", "reserved")
highlight("rescue", "reserved")
highlight("retry", "reserved")
highlight("return", "reserved")
highlight("self", "reserved")
highlight("super", "reserved")
highlight("then", "reserved")
highlight("true", "reserved")
highlight("undef", "reserved")
highlight("unless", "reserved")
highlight("until", "reserved")
highlight("when", "reserved")
highlight("while", "reserved")
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

--- Comparison Operators
highlight("==", "operator")
highlight("!=", "operator")
highlight(">", "operator")
highlight("<", "operator")
highlight(">=", "operator")
highlight("<=", "operator")
highlight("<=>", "operator")
highlight("===", "operator")
highlight(".eql?", "operator")

--- Logical Operators
highlight("&&", "reserved")
highlight("||", "reserved")
highlight("!", "reserved")
highlight("not", "reserved")

--- Bitwise Operators
highlight("&", "operator")
highlight("|", "operator")
highlight("^", "operator")
highlight("~", "operator")
highlight("<<", "operator")
highlight(">>", "operator")

--- Special Characters
highlight("{", "special")
highlight("}", "special")
highlight("(", "special")
highlight(")", "special")
highlight("[", "special")
highlight("]", "special")
highlight("?", "special")
highlight(":", "special")
highlight("=>", "special")

--- Strings and Characters
highlight_region('"', '"', "string")
highlight_region("'", "'", "string")
highlight_region("%q{", "}", "string")
highlight_region("%Q{", "}", "string")
highlight_region("%r{", "}", "regex")
highlight_region("%w{", "}", "array")
highlight_region("%x{", "}", "backtick")

--- Comments
highlight_region("#", "", "comment", true)
highlight_region("=begin", "=end", "comment", true)

--- Function and Variable Detection
function detect_functions(content)
    local functionNames = {}
    for line in content:gmatch("[^\r\n]+") do
        local functionName = line:match("def%s+([%w_?.!]+)")
        if functionName then
            table.insert(functionNames, functionName)
        end
    end
    return functionNames
end

function detect_variables(content)
    local variable_names = {}
    for line in content:gmatch("[^\r\n]+") do
        local assignment = line:match("(%w+)%s*=")
        if assignment then
            table.insert(variable_names, assignment)
        end
    end
    return variable_names
end
