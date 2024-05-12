highlight("package", "reserved")
highlight("import", "reserved")

highlight("public", "reserved")
highlight("private", "reserved")
highlight("protected", "reserved")

highlight("class", "reserved")
highlight("enum", "reserved")
highlight("record", "reserved")
highlight("interface", "reserved")

highlight("extends", "reserved")
highlight("implements", "reserved")
highlight("module", "reserved")

highlight("super", "reserved")
highlight("this", "reserved")

highlight("void", "reserved")
highlight("boolean", "reserved")
highlight("int", "reserved")
highlight("double", "reserved")
highlight("long", "reserved")
highlight("float", "reserved")
highlight("char", "reserved")
highlight("byte", "reserved")
highlight("short", "reserved")

-- which mf actually uses these
highlight("const", "reserved")
highlight("goto", "reserved")
highlight("strictfp", "reserved")

highlight("instanceof", "reserved")
highlight("native", "reserved")
highlight("new", "reserved")

highlight("return", "reserved")

highlight("final", "reserved")
highlight("static", "reserved")
highlight("transient", "reserved")
highlight("volatile", "reserved")

highlight_region("\"", "\"", "string", true)
highlight_region("//", "", "comments", true)
highlight_region("/*", "*/", "comments")

highlight_region("@", "", "annotation", true)

highlight("if", "reserved")
highlight("else", "reserved")

highlight("do", "reserved")
highlight("while", "reserved")
highlight("for", "reserved")
highlight("continue", "reserved")
highlight("default", "reserved")
highlight("break", "reserved")

highlight("switch", "reserved")
highlight("case", "reserved")

highlight("try", "reserved")
highlight("catch", "reserved")
highlight("finally", "reserved")
highlight("throw", "reserved")
highlight("throws", "reserved")

highlight("false", "binary")
highlight("true", "binary")
highlight("null", "binary")

highlight("synchronized", "reserved")

highlight("assert", "reserved")

highlight("exports", "reserved")
highlight("module", "reserved")
highlight("non-sealed", "reserved")
highlight("open", "reserved")
highlight("opens", "reserved")
highlight("permits", "reserved")
highlight("provides", "reserved")
highlight("requires", "reserved")
highlight("sealed", "reserved")
highlight("to", "reserved")
highlight("transitive", "reserved")
highlight("uses", "reserved")
highlight("var", "reserved")
highlight("when", "reserved")
highlight("with", "reserved")
highlight("yield", "reserved")


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

add_comment("boiler plate alert!!!")
add_comment("public static volatile transient transitive synchronized class type language 🗣️🔥")
add_comment("another semicolon please")
add_comment("use a lambda you dumbass")

function detect_functions(content)
    local functionNames = {}

    for line in content:gmatch("[^\r\n]+") do
        local pattern = "[%a_][%a%d_<>]*%s+([%a_][%a%d_]*)%s*%("
        local functionName = line:match(pattern)
        if functionName then
            table.insert(functionNames, functionName);
        end
    end

    return functionNames
end

function detect_variables(content)
    local variable_names = {
        "this",
        "super",
        "System",
        "Object",
        "Math",
        "Thread",
        "Runtime"
    }
    for line in content:gmatch("[^\r\n]+") do
        local pattern = "%f[%a_][%a_][%a%d_<>]*%s+([%a_][%a%d_<>]*)%s*=%s*[^;]+;"
        local match = line:match(pattern)
        if match then
            table.insert(variable_names, match)
        end
    end
    return variable_names
end
