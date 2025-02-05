highlight("lit", "reserved")
highlight("mf", "reserved")

highlight("while", "reserved")
highlight("yall", "reserved")

highlight("sus", "reserved")
highlight("impostor", "reserved")
highlight("fuck_around", "reserved")
highlight("find_out", "reserved")

highlight("bruh", "reserved")

highlight("cap", "binary")
highlight("nocap", "binary")
highlight("fake", "binary")

highlight("plus", "operator")
highlight("minus", "operator")
highlight("divided by", "operator")
highlight("times", "operator")
highlight("beplus", "operator")
highlight("beminus", "operator")
highlight("bedivided", "operator")
highlight("betimes", "operator")
highlight("smol", "operator")
highlight("thicc", "operator")
highlight("fr", "operator")
highlight("nah", "operator")

highlight("{", "binary")
highlight("}", "binary")

highlight_region("\"", "\"", "string")
highlight_region("//", "", "comments", true)
highlight_region("/*", "*/", "comments")

add_comment("yo code aint sigma bro 🗣️🔥")
add_comment("quit the bussin syntax")
add_comment("yappacino(bruh perform() { waffle(\"what the fuck am i reading\") }, 1)")
add_comment("use a language with comments you fool")
add_comment("nerd.random() 🤓")
add_comment("blud is using a typescript esolang 🗣️💯🔥")

-- fix default colorings.
highlight("be", "operator")
highlight("rn", "operator")
highlight("carenot", "operator")
highlight("btw", "operator")

function detect_variables(content)
    -- default variables that bsx includes
    local variable_names = {
        "error",
        "nerd",
        "fs",
        "objects",
        "regex",
        "args",
        "error"
    }
    local lines = content:gmatch("[^\r\n]+")

    for line in lines do
        if trim(line):find("^lit ") or trim(line):find("^mf ") then
            local parts = splitstr(line, "be")
            if #parts > 0 then
                local variable_name = trim(splitstr(trim(parts[1]), " ")[2])
                table.insert(variable_names, variable_name)
            end
        end
    end

    return variable_names
end

function detect_functions(content)
    -- default functions that bsx includes
    local functionNames = {
        "waffle",
        "clapback",
        "yap",
        "bye",
        "hollup",
        "yappacino",
        "charat",
        "strcon",
        "format",
        "fetch",
        "len",
        "import",
        "splitstr",
        "trim",
        "time"
    }
    local lines = content:gmatch("[^\r\n]+")

    for line in lines do
        if (trim(line):find("^bruh ")) and trim(line):find("%(") then
            local functionName = string.match(trim(line):gsub("{", ""), "bruh%s+(.-)%s*%(")
            table.insert(functionNames, functionName)
        end
    end

    return functionNames
end