--- Highlight Keywords
highlight("And", "reserved")
highlight("As", "reserved")
highlight("Boolean", "reserved")
highlight("ByRef", "reserved")
highlight("Byte", "reserved")
highlight("ByVal", "reserved")
highlight("Case", "reserved")
highlight("Call", "reserved")
highlight("Class", "reserved")
highlight("Const", "reserved")
highlight("Dim", "reserved")
highlight("Do", "reserved")
highlight("Double", "reserved")
highlight("Each", "reserved")
highlight("Else", "reserved")
highlight("ElseIf", "reserved")
highlight("End", "reserved")
highlight("Enum", "reserved")
highlight("Erase", "reserved")
highlight("Error", "reserved")
highlight("Exit", "reserved")
highlight("False", "reserved")
highlight("For", "reserved")
highlight("Function", "reserved")
highlight("Get", "reserved")
highlight("If", "reserved")
highlight("In", "reserved")
highlight("Integer", "reserved")
highlight("Is", "reserved")
highlight("Let", "reserved")
highlight("Like", "reserved")
highlight("Long", "reserved")
highlight("Loop", "reserved")
highlight("Mod", "reserved")
highlight("New", "reserved")
highlight("Next", "reserved")
highlight("Not", "reserved")
highlight("Nothing", "reserved")
highlight("Object", "reserved")
highlight("On", "reserved")
highlight("Option", "reserved")
highlight("Or", "reserved")
highlight("Private", "reserved")
highlight("Property", "reserved")
highlight("Public", "reserved")
highlight("Redim", "reserved")
highlight("Resume", "reserved")
highlight("Select", "reserved")
highlight("Set", "reserved")
highlight("Static", "reserved")
highlight("Step", "reserved")
highlight("Stop", "reserved")
highlight("String", "reserved")
highlight("Sub", "reserved")
highlight("Then", "reserved")
highlight("To", "reserved")
highlight("True", "reserved")
highlight("Type", "reserved")
highlight("Until", "reserved")
highlight("Variant", "reserved")
highlight("Wend", "reserved")
highlight("While", "reserved")
highlight("With", "reserved")
highlight("Xor", "reserved")

--- Arithmetic Operators
highlight("+", "operator")
highlight("-", "operator")
highlight("*", "operator")
highlight("/", "operator")
highlight("\\", "operator")
highlight("^", "operator")
highlight("Mod", "operator")

--- Comparison Operators
highlight("=", "operator")
highlight("<>", "operator")
highlight("<", "operator")
highlight(">", "operator")
highlight("<=", "operator")
highlight(">=", "operator")

--- Logical Operators
highlight("And", "operator")
highlight("Not", "operator")
highlight("Or", "operator")
highlight("Xor", "operator")

--- Assignment Operator
highlight("=", "operator")

--- Special Characters
highlight("(", "special")
highlight(")", "special")
highlight(".", "special")
highlight(",", "special")
highlight("&", "special") -- Concatenation
highlight("_", "special") -- Line Continuation

--- Strings
highlight_region('"', '"', "string")

--- Comments
highlight_region("'", "", "comment", true)
highlight_region("Rem", "", "comment", true)

--- Function and Variable Detection
function detect_functions(content)
    local functionNames = {}
    for line in content:gmatch("[^\r\n]+") do
        local functionName = line:match("Function%s+([%w_]+)")
        if not functionName then
            functionName = line:match("Sub%s+([%w_]+)")
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
        local variable = line:match("Dim%s+([%w_]+)")
        if not variable then
            variable = line:match("Set%s+([%w_]+)%s*=")
        end
        if not variable then
            variable = line:match("([%w_]+)%s*=")
        end
        if variable then
            table.insert(variable_names, variable)
        end
    end
    return variable_names
end
