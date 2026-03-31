--- Highlight Keywords (Rust Reserved Words)
highlight("as", "reserved")
highlight("async", "reserved")
highlight("await", "reserved")
highlight("break", "reserved")
highlight("const", "reserved")
highlight("continue", "reserved")
highlight("crate", "reserved")
highlight("dyn", "reserved")
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

--- Reserved for Future Use
highlight("abstract", "reserved")
highlight("become", "reserved")
highlight("box", "reserved")
highlight("do", "reserved")
highlight("final", "reserved")
highlight("macro", "reserved")
highlight("override", "reserved")
highlight("priv", "reserved")
highlight("try", "reserved")
highlight("typeof", "reserved")
highlight("unsized", "reserved")
highlight("virtual", "reserved")
highlight("yield", "reserved")

--- Primitive Types
highlight("bool", "variable")
highlight("char", "variable")
highlight("str", "variable")
highlight("u8", "variable")
highlight("u16", "variable")
highlight("u32", "variable")
highlight("u64", "variable")
highlight("u128", "variable")
highlight("usize", "variable")
highlight("i8", "variable")
highlight("i16", "variable")
highlight("i32", "variable")
highlight("i64", "variable")
highlight("i128", "variable")
highlight("isize", "variable")
highlight("f32", "variable")
highlight("f64", "variable")

--- Common Types & Traits
highlight("Option", "function")
highlight("Result", "function")
highlight("Some", "function")
highlight("None", "function")
highlight("Ok", "function")
highlight("Err", "function")
highlight("Box", "function")
highlight("Vec", "function")
highlight("String", "function")
highlight("HashMap", "function")
highlight("HashSet", "function")
highlight("Rc", "function")
highlight("Arc", "function")
highlight("Cell", "function")
highlight("RefCell", "function")
highlight("Mutex", "function")
highlight("RwLock", "function")

--- Macros (common)
highlight("println!", "annotation")
highlight("print!", "annotation")
highlight("eprintln!", "annotation")
highlight("eprint!", "annotation")
highlight("format!", "annotation")
highlight("panic!", "annotation")
highlight("assert!", "annotation")
highlight("assert_eq!", "annotation")
highlight("assert_ne!", "annotation")
highlight("debug_assert!", "annotation")
highlight("vec!", "annotation")
highlight("todo!", "annotation")
highlight("unimplemented!", "annotation")
highlight("unreachable!", "annotation")
highlight("cfg!", "annotation")
highlight("env!", "annotation")
highlight("include!", "annotation")
highlight("include_str!", "annotation")
highlight("include_bytes!", "annotation")
highlight("concat!", "annotation")
highlight("stringify!", "annotation")
highlight("matches!", "annotation")

--- Arithmetic Operators
highlight("+", "operator")
highlight("-", "operator")
highlight("*", "operator")
highlight("/", "operator")
highlight("%", "operator")

--- Assignment Operators
highlight("=", "operator")
highlight("+=", "operator")
highlight("-=", "operator")
highlight("*=", "operator")
highlight("/=", "operator")
highlight("%=", "operator")
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

--- Logical Operators
highlight("&&", "operator")
highlight("||", "operator")
highlight("!", "operator")

--- Bitwise Operators
highlight("&", "operator")
highlight("|", "operator")
highlight("^", "operator")
highlight("<<", "operator")
highlight(">>", "operator")

--- Rust-specific Operators
highlight("->", "operator")
highlight("=>", "operator")
highlight("::", "operator")
highlight("..", "operator")
highlight("..=", "operator")
highlight("?", "operator")

--- Special Characters
highlight("{", "binary")
highlight("}", "binary")
highlight("[", "binary")
highlight("]", "binary")
highlight("(", "binary")
highlight(")", "binary")
highlight(";", "binary")
highlight(",", "binary")
highlight(":", "binary")

--- Attributes
highlight_region("#[", "]", "annotation")
highlight_region("#![", "]", "annotation")

--- Strings
highlight_region("\"", "\"", "string")
highlight_region("r#\"", "\"#", "string")
highlight_region("r##\"", "\"##", "string")
highlight_region("'", "'", "string")

--- Comments
highlight_region("//", "", "comments", true)
highlight_region("/*", "*/", "comments", false)
highlight_region("///", "", "comments", true)
highlight_region("//!", "", "comments", true)

--- Fun Comments
add_comment("borrow checker says no 💀")
add_comment("zero-cost abstractions go brrrr 🚀")
add_comment("fearless concurrency 🦀")
add_comment("unwrap() and pray 🙏")
add_comment("fighting the borrow checker again...")
add_comment("memory safety without garbage collection 😎")
add_comment("lifetime annotations everywhere...")
add_comment("blazingly fast 🔥")
add_comment("rewrite it in Rust when? 🦀")
add_comment("cargo build --release")
add_comment("impl Drop for MyStruggles")
add_comment("where T: Send + Sync + 'static + Clone + Debug")

--- Autocomplete

function detect_functions(content, line, column)
    local function_names = {
        -- Standard library functions
        "println!", "print!", "format!", "panic!",
        "vec!", "assert!", "assert_eq!", "assert_ne!",
        "Some", "None", "Ok", "Err",
        "unwrap", "expect", "unwrap_or", "unwrap_or_else",
        "map", "and_then", "or_else", "filter",
        "collect", "iter", "into_iter", "iter_mut",
        "push", "pop", "len", "is_empty",
        "clone", "to_string", "to_owned", "as_ref",
        "from", "into", "default",
    }

    for func_line in content:gmatch("[^\r\n]+") do
        -- Match fn declarations: fn function_name(
        local func_name = func_line:match("fn%s+([%w_]+)%s*[<%(]")
        if func_name then
            table.insert(function_names, func_name)
        end
        
        -- Match impl methods
        local method_name = func_line:match("pub%s+fn%s+([%w_]+)%s*[<%(]")
        if method_name then
            table.insert(function_names, method_name)
        end
    end

    return function_names
end

function detect_variables(content, line, column)
    local variable_names = {
        -- Common prelude items
        "self", "Self", "crate", "super",
    }

    for var_line in content:gmatch("[^\r\n]+") do
        -- Match let bindings: let variable_name or let mut variable_name
        local var_name = var_line:match("let%s+mut%s+([%w_]+)")
        if not var_name then
            var_name = var_line:match("let%s+([%w_]+)")
        end
        if var_name then
            table.insert(variable_names, var_name)
        end
        
        -- Match const declarations: const NAME
        local const_name = var_line:match("const%s+([%w_]+)")
        if const_name then
            table.insert(variable_names, const_name)
        end
        
        -- Match static declarations: static NAME
        local static_name = var_line:match("static%s+mut%s+([%w_]+)")
        if not static_name then
            static_name = var_line:match("static%s+([%w_]+)")
        end
        if static_name then
            table.insert(variable_names, static_name)
        end
        
        -- Match struct names: struct Name
        local struct_name = var_line:match("struct%s+([%w_]+)")
        if struct_name then
            table.insert(variable_names, struct_name)
        end
        
        -- Match enum names: enum Name
        local enum_name = var_line:match("enum%s+([%w_]+)")
        if enum_name then
            table.insert(variable_names, enum_name)
        end
        
        -- Match type aliases: type Name
        local type_name = var_line:match("type%s+([%w_]+)")
        if type_name then
            table.insert(variable_names, type_name)
        end
        
        -- Match trait names: trait Name
        local trait_name = var_line:match("trait%s+([%w_]+)")
        if trait_name then
            table.insert(variable_names, trait_name)
        end
    end

    return variable_names
end