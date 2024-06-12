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

--- Highlight Types
highlight("i8", "type")
highlight("i16", "type")
highlight("i32", "type")
highlight("i64", "type")
highlight("i128", "type")
highlight("u8", "type")
highlight("u16", "type")
highlight("u32", "type")
highlight("u64", "type")
highlight("u128", "type")
highlight("f32", "type")
highlight("f64", "type")
highlight("bool", "type")
highlight("char", "type")
highlight("str", "type")
highlight("String", "type")
highlight("Vec", "type")
highlight("Option", "type")
highlight("Result", "type")

--- Highlight Constants
highlight("true", "binary")
highlight("false", "binary")

--- Highlight Operators
highlight("+", "operator")
highlight("-", "operator")
highlight("*", "operator")
highlight("/", "operator")
highlight("%", "operator")
highlight("&&", "operator")
highlight("||", "operator")
highlight("!", "operator")
highlight("==", "operator")
highlight("!=", "operator")
highlight("<", "operator")
highlight(">", "operator")
highlight("<=", "operator")
highlight(">=", "operator")
highlight("=", "operator")
highlight("+=", "operator")
highlight("-=", "operator")
highlight("*=", "operator")
highlight("/=", "operator")
highlight("%=", "operator")
highlight("<<", "operator")
highlight(">>", "operator")
highlight("&", "operator")
highlight("|", "operator")
highlight("^", "operator")
highlight("<<=", "operator")
highlight(">>=", "operator")
highlight("&=", "operator")
highlight("|=", "operator")
highlight("^=", "operator")

--- Highlight Special Characters
highlight("{", "binary")
highlight("}", "binary")
highlight("[", "binary")
highlight("]", "binary")
highlight("(", "binary")
highlight(")", "binary")

--- Highlight Special Variables
highlight("self", "variable")

--- Highlight Strings
highlight_region("\"", "\"", "string", true)
highlight_region("'", "'", "string", true)

--- Highlight Comments
highlight_region("/*", "*/", "comments")
highlight_region("//", "", "comments", true)

--- Add Comments
add_comment("OOP in rust is fucking weird man i dont like it")
add_comment("write your own python interpreter in rust")
add_comment("bussin os in rust")
add_comment("Rust is just nicer to use for some things than the alternatives")
add_comment("i also don't believe purelua can outspeed rust, even with the overhead")
add_comment("surely rust isn't a difficult language to learn?")
add_comment("god damn i wanna use rust but cannot")
add_comment("We don't like Rust personally")
add_comment("Its either something with lua -> rust or gtk being slow to update it or its smth in the code idk")
add_comment("I am not touching rust again wtf")

--- Autocomplete

function detect_functions(content)
    local functionNames = {}

    for line in content:gmatch("[^\r\n]+") do
        local functionName = line:match("fn%s+([%w_]+)%s*%(")
        if functionName then
            table.insert(functionNames, functionName)
        end
    end

    return functionNames
end

function detect_variables(content)
    local variable_names = {"self"}
    local lines = content:gmatch("[^\r\n]+")

    for line in lines do
        local let_variable = line:match("let%s+mut%s+([%w_]+)%s*=") or line:match("let%s+([%w_]+)%s*=")
        if let_variable then
            table.insert(variable_names, let_variable)
        end

        local const_variable = line:match("const%s+([%w_]+)%s*=")
        if const_variable then
            table.insert(variable_names, const_variable)
        end
    end

    return variable_names
end
