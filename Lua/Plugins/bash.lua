-- Highlight Keywords
highlight("if", "reserved")
highlight("then", "reserved")
highlight("else", "reserved")
highlight("elif", "reserved")
highlight("fi", "reserved")
highlight("case", "reserved")
highlight("esac", "reserved")
highlight("for", "reserved")
highlight("in", "reserved")
highlight("do", "reserved")
highlight("done", "reserved")
highlight("while", "reserved")
highlight("until", "reserved")
highlight("select", "reserved")
highlight("function", "reserved")

-- Arithmetic Operators
highlight("+", "operator")
highlight("-", "operator")
highlight("*", "operator")
highlight("/", "operator")
highlight("%", "operator")
highlight("**", "operator")

-- Assignment Operators
highlight("=", "operator")
highlight("+=", "operator")
highlight("-=", "operator")
highlight("*=", "operator")
highlight("/=", "operator")
highlight("%=", "operator")

-- Comparison Operators
highlight("==", "operator")
highlight("!=", "operator")
highlight("-eq", "operator")
highlight("-ne", "operator")
highlight("-lt", "operator")
highlight("-le", "operator")
highlight("-gt", "operator")
highlight("-ge", "operator")

-- Logical Operators
highlight("&&", "reserved")
highlight("||", "reserved")
highlight("!", "reserved")

-- Strings
highlight_region("'", "'", "string")
highlight_region('"', '"', "string")

-- User Comments
highlight_region("#", "", "comments", true)

-- Special Characters
highlight("{", "special")
highlight("}", "special")
highlight("(", "special")
highlight(")", "special")
highlight("$", "special") -- Variable Sign

-- Detect Functions (Bash style)
function detect_functions(content)
    local functionNames = {}

    for line in content:gmatch("[^\r\n]+") do
        local functionName = line:match("function%s+([%w_]+)%s*%b()")
        if not functionName then
            functionName = line:match("^([%w_]+)%s*%(")
        end
        if functionName then
            table.insert(functionNames, functionName)
        end
    end

    return functionNames
end

-- Detect Variables (Bash style)
function detect_variables(content)
    local variable_names = {}
    local lines = content:gmatch("[^\r\n]+")

    for line in lines do
        local assignment = line:match("(%w+)=.*")
        if assignment then
            table.insert(variable_names, assignment)
        end
    end

    return variable_names
end
