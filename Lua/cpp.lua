--- Highlight Keywords
highlight("alignas", "reserved")
highlight("alignof", "reserved")
highlight("and", "reserved")
highlight("and_eq", "reserved")
highlight("asm", "reserved")
highlight("atomic_cancel", "reserved")
highlight("atomic_commit", "reserved")
highlight("atomic_noexcept", "reserved")
highlight("auto", "reserved")
highlight("bitand", "reserved")
highlight("bitor", "reserved")
highlight("bool", "reserved")
highlight("break", "reserved")
highlight("case", "reserved")
highlight("catch", "reserved")
highlight("char", "reserved")
highlight("char8_t", "reserved")
highlight("char16_t", "reserved")
highlight("char32_t", "reserved")
highlight("class", "reserved")
highlight("compl", "reserved")
highlight("concept", "reserved")
highlight("const", "reserved")
highlight("consteval", "reserved")
highlight("constexpr", "reserved")
highlight("constinit", "reserved")
highlight("const_cast", "reserved")
highlight("continue", "reserved")
highlight("co_await", "reserved")
highlight("co_return", "reserved")
highlight("co_yield", "reserved")
highlight("decltype", "reserved")
highlight("default", "reserved")
highlight("delete", "reserved")
highlight("do", "reserved")
highlight("double", "reserved")
highlight("dynamic_cast", "reserved")
highlight("else", "reserved")
highlight("enum", "reserved")
highlight("explicit", "reserved")
highlight("export", "reserved")
highlight("extern", "reserved")
highlight("false", "reserved")
highlight("float", "reserved")
highlight("for", "reserved")
highlight("friend", "reserved")
highlight("goto", "reserved")
highlight("if", "reserved")
highlight("import", "reserved")
highlight("inline", "reserved")
highlight("int", "reserved")
highlight("long", "reserved")
highlight("module", "reserved")
highlight("mutable", "reserved")
highlight("namespace", "reserved")
highlight("new", "reserved")
highlight("noexcept", "reserved")
highlight("not", "reserved")
highlight("not_eq", "reserved")
highlight("nullptr", "reserved")
highlight("operator", "reserved")
highlight("or", "reserved")
highlight("or_eq", "reserved")
highlight("private", "reserved")
highlight("protected", "reserved")
highlight("public", "reserved")
highlight("reflexpr", "reserved")
highlight("register", "reserved")
highlight("reinterpret_cast", "reserved")
highlight("requires", "reserved")
highlight("return", "reserved")
highlight("short", "reserved")
highlight("signed", "reserved")
highlight("sizeof", "reserved")
highlight("static", "reserved")
highlight("static_assert", "reserved")
highlight("static_cast", "reserved")
highlight("struct", "reserved")
highlight("switch", "reserved")
highlight("synchronized", "reserved")
highlight("template", "reserved")
highlight("this", "reserved")
highlight("thread_local", "reserved")
highlight("throw", "reserved")
highlight("true", "reserved")
highlight("try", "reserved")
highlight("typedef", "reserved")
highlight("typeid", "reserved")
highlight("typename", "reserved")
highlight("union", "reserved")
highlight("unsigned", "reserved")
highlight("using", "reserved")
highlight("virtual", "reserved")
highlight("void", "reserved")
highlight("volatile", "reserved")
highlight("wchar_t", "reserved")
highlight("while", "reserved")
highlight("xor", "reserved")
highlight("xor_eq", "reserved")

--- Arithmetic Operators
highlight("+", "operator")
highlight("-", "operator")
highlight("*", "operator")
highlight("/", "operator")
highlight("%", "operator")
highlight("**", "operator")
highlight("++", "operator")
highlight("--", "operator")

--- Assignment Operators
highlight("=", "operator")
highlight("+=", "operator")
highlight("-=", "operator")
highlight("*=", "operator")
highlight("/=", "operator")
highlight("%=", "operator")

--- Comparison Operators
highlight("==", "operator")
highlight("!=", "operator")
highlight(">", "operator")
highlight("<", "operator")
highlight(">=", "operator")
highlight("<=", "operator")

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

--- Special Characters
highlight("{", "binary")
highlight("}", "binary")
highlight("[", "binary")
highlight("]", "binary")
highlight("(", "binary")
highlight(")", "binary")
highlight(";", "binary")
highlight(",", "binary")

--- Strings
highlight_region("\"", "\"", "string")
highlight_region("'", "'", "string")

--- Comments
add_comment("//", "", "comments", true)
add_comment("/*", "*/", "comments", false)

--- Autocomplete

function detect_functions(content)
    local functionNames = {}

    for line in content:gmatch("[^\r\n]+") do
        -- Match function declarations
        local functionName = line:match("%s*([%w_:]+)%s+[%w_:]+%s*%([^%)]*%)%s*%{?")
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
        local variable = line:match("%s*([%w_:]+)%s+[%w_:]+%s*[=;%(%),]")
        if variable then
            table.insert(variable_names, variable)
        end
    end

    return variable_names
end
