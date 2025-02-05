highlight("connotate", "reserved")
highlight("derives", "reserved")
highlight("variable", "reserved")
highlight("synchronised", "reserved")
highlight("unsynchronised", "reserved")
highlight("constant", "reserved")
highlight("mutable", "reserved")
highlight("volatile", "reserved")
highlight("stable", "reserved")
highlight("independent", "reserved")
highlight("dependent", "reserved")
highlight("invariable", "reserved")
highlight("void", "reserved")
highlight("ratify", "reserved")
highlight("subroutine", "reserved")
highlight("?", "reserved")
highlight("transient", "reserved")
highlight("classification", "reserved")
highlight("extemporize", "reserved")
highlight("aforementioned", "variable")
highlight("epitomise", "reserved")
highlight("stipulate", "reserved")
highlight("otherwise", "reserved")
highlight("compeer", "reserved")
highlight("towards", "reserved")
highlight("within", "reserved")
highlight("nonfulfillment", "reserved")

highlight("neither", "binary")
highlight("both", "binary")
highlight("maybe", "binary")
highlight("trueish", "binary")
highlight("falseish", "binary")
highlight("depends", "binary")
highlight("complicated", "binary")
--
highlight("var", "reserved")
highlight("let", "reserved")
highlight("const", "reserved")
highlight("new", "reserved")

highlight("while", "reserved")
highlight("for", "reserved")

highlight("if", "reserved")
highlight("else", "reserved")
highlight("try", "reserved")
highlight("catch", "reserved")

highlight("extends", "reserved")
highlight("typeof", "reserved")
highlight("void", "reserved")

highlight("in", "reserved")
highlight("of", "reserved")
highlight("with", "reserved")

highlight("import", "reserved")
highlight("finally", "reserved")
highlight("delete", "reserved")

highlight("class", "reserved")
highlight("function", "reserved")
highlight("return", "reserved")
highlight("export", "reserved")
highlight("async", "reserved")
highlight("await", "reserved")
highlight("throw", "reserved")
highlight("continue", "reserved")
highlight("break", "reserved")
highlight("yield", "reserved")

highlight("instanceof", "reserved")
highlight("typeof", "reserved")
highlight("switch", "reserved")
highlight("case", "reserved")
highlight("default", "reserved")
highlight("do", "reserved")

highlight("false", "binary")
highlight("true", "binary")
highlight("null", "binary")
highlight("undefined", "binary")

highlight("+", "operator")
highlight("-", "operator")
highlight("/", "operator")
highlight("*", "operator")
highlight("+=", "operator")
highlight("-=", "operator")
highlight("/=", "operator")
highlight("*=", "operator")
highlight("<", "operator")
highlight(">", "operator")
highlight("<=", "operator")
highlight(">=", "operator")
highlight("%", "operator")
highlight("==", "operator")
highlight("===", "operator")
highlight("!=", "operator")
highlight("!==", "operator")

highlight("{", "binary")
highlight("}", "binary")
highlight("[", "binary")
highlight("]", "binary")

highlight("this", "variable")

highlight_region("\"", "\"", "string", true)
highlight_region("'", "'", "string", true)
highlight_region("`", "`", "string")
highlight_region("/*", "*/", "comments")
highlight_region("//", "", "comments", true)

--- comments
add_comment("yap yap yap yap yap")
add_comment("its the funny language 🗣️🗣️🗣️🗣️🗣️🗣️🗣️🗣️🗣️🗣️‼️‼️💥💥💥🤯")
add_comment("typescript better 💀💀💀")
add_comment("lil bro ain't onto something")

--- autocomplete

function detect_functions(content)
    local functionNames = {}

    local lines = {}
    for line in content:gmatch("[^\r\n]+") do
        table.insert(lines, line)
    end

    for _, line in ipairs(lines) do
        local trimmedLine = trim(line)

        -- Look for function, async function, subroutine, or ? (class) function definitions
        if trimmedLine:find("function ") or
           trimmedLine:find("async ") or
           trimmedLine:find("subroutine ") or
           trimmedLine:find("%w%s?") then
            local functionName =
                string.match(trimmedLine:gsub("{", ""), "%w+%s+%?") or
                string.match(trimmedLine:gsub("{", ""), "%.?function%s+(.-)%s*%(") or
                string.match(trimmedLine:gsub("{", ""), "%.?subroutine%s+(.-)%s*%(") or
                string.match(trimmedLine:gsub("{", ""), "%.?async%s+(.-)%s*%(")

            if functionName:find("?") then
                functionName = functionName.gsub(functionName, "?", "")
                functionName = trim(functionName)
            end

            table.insert(functionNames, functionName)
        end
    end

    return functionNames
end

function detect_variables(content)
    local variable_names = {
        "global",
        "process",
        "console",
        "Buffer",
        "__dirname",
        "__filename",
        "module",
        "exports",
        "connotate",
        "derives",
        "variable",
        "synchronised",
        "unsynchronised",
        "constant",
        "mutable",
        "volatile",
        "stable",
        "independent",
        "dependent",
        "invariable",
        "void",
        "ratify",
        "subroutine",
        "?",
        "transient",
        "classification",
        "extemporize",
        "aforementioned",
        "epitomise",
        "stipulate",
        "otherwise",
        "compeer",
        "towards",
        "within",
        "nonfulfillment"
    }
    
    local lines = content:gmatch("[^\r\n]+")

    for line in lines do
      local is_yap = trim(line):find("variable ")
        if is_yap or trim(line):find("let ") or trim(line):find("var ") or trim(line):find("const ") then
            local parts = splitstr(line, "=")
            if #parts > 0 then
                local variable_name = trim(splitstr(trim(parts[1]), " ")[2])
                
                if is_yap then
                  variable_name = splitstr(trim(parts[1]), " ")[4]
                  variable_name = variable_name:gsub("[^a-zA-Z]", "")
                end
                table.insert(variable_names, variable_name)
            end
        end
    end

    return variable_names
end
