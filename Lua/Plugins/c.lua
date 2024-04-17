-- Highlight Keywords
highlight("auto", "reserved")
highlight("break", "reserved")
highlight("case", "reserved")
highlight("char", "reserved")
highlight("const", "reserved")
highlight("continue", "reserved")
highlight("default", "reserved")
highlight("do", "reserved")
highlight("double", "reserved")
highlight("else", "reserved")
highlight("enum", "reserved")
highlight("extern", "reserved")
highlight("float", "reserved")
highlight("for", "reserved")
highlight("goto", "reserved")
highlight("if", "reserved")
highlight("inline", "reserved")
highlight("int", "reserved")
highlight("long", "reserved")
highlight("register", "reserved")
highlight("restrict", "reserved")
highlight("return", "reserved")
highlight("short", "reserved")
highlight("signed", "reserved")
highlight("sizeof", "reserved")
highlight("static", "reserved")
highlight("struct", "reserved")
highlight("switch", "reserved")
highlight("typedef", "reserved")
highlight("union", "reserved")
highlight("unsigned", "reserved")
highlight("void", "reserved")
highlight("volatile", "reserved")
highlight("while", "reserved")
highlight("_Alignas", "reserved")
highlight("_Alignof", "reserved")
highlight("_Atomic", "reserved")
highlight("_Bool", "reserved")
highlight("_Complex", "reserved")
highlight("_Generic", "reserved")
highlight("_Imaginary", "reserved")
highlight("_Noreturn", "reserved")
highlight("_Static_assert", "reserved")
highlight("_Thread_local", "reserved")

-- Arithmetic Operators
highlight("+", "operator") 
highlight("-", "operator")
highlight("*", "operator")
highlight("/", "operator")
highlight("%", "operator")
highlight("++", "operator")
highlight("--", "operator")

-- Assignment Operators
highlight("=", "operator")
highlight("+=", "operator")
highlight("-=", "operator") 
highlight("*=", "operator")
highlight("/=", "operator")
highlight("%=", "operator")
highlight("&=", "operator")
highlight("^=", "operator")
highlight("|=", "operator")
highlight("<<=", "operator")
highlight(">>=", "operator")

-- Comparison Operators
highlight("==", "operator")
highlight("!=", "operator")
highlight(">", "operator")
highlight("<", "operator")
highlight(">=", "operator")
highlight("<=", "operator")

-- Logical Operators 
highlight("&&", "operator")
highlight("||", "operator")
highlight("!", "operator")

-- Bitwise Operators
highlight("&", "operator")
highlight("|", "operator")
highlight("^", "operator")
highlight("~", "operator")
highlight("<<", "operator")
highlight(">>", "operator")

-- Special Characters
highlight("{", "binary")
highlight("}", "binary")
highlight("[", "binary")
highlight("]", "binary")
highlight("(", "binary")
highlight(")", "binary") 
highlight(";", "binary")
highlight(",", "binary")

-- Strings 
highlight_region("\"", "\"", "string")
highlight_region("'", "'", "string")

-- Comments
add_comment("//", "", "comments", true)
add_comment("/*", "*/", "comments", false)

-- Autocomplete

function detect_functions(content)
    local functionNames = {}
    
    for line in content:gmatch("[^\r\n]+") do
        -- Match function declarations
        local functionName = line:match("%s*([%w_]+)%s*%([^%)]*%)%s*%{?")
        if functionName then 
            table.insert(functionNames, functionName)
        end
    end
    
    return functionNames
end

function detect_variables(content) 
    local variable_names = {}
    local lines = content:gmatch("[^\r\n]+")
    
    for line in lines do
        -- Match variable declarations
        local variable = line:match("%s*([%w_]+)%s+[%w_]+%s*[=;%(%),]")
      
        if variable then
            table.insert(variable_names, variable)
        end
    end
  
    return variable_names
end
