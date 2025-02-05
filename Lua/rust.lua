-- Rust Language Support
local M = {}

-- Cache for pattern matching results
local cache = {
    functions = {},
    variables = {},
    last_text = "",
    last_line = -1
}

-- Essential keywords only
local core_keywords = {
    -- Most common keywords
    "fn", "let", "mut", "pub", "use", "mod",
    "struct", "enum", "impl", "trait", "type",
    "match", "if", "else", "for", "while", "loop",
    "return", "break", "continue", "self", "Self"
}

-- Common types
local core_types = {
    "i32", "u32", "i64", "u64", "bool", "str",
    "String", "Vec", "Option", "Result"
}

-- Initialize highlighting (done once at startup)
local function init_highlighting()
    -- Core keywords
    for _, kw in ipairs(core_keywords) do
        highlight(kw, "keyword")
    end
    
    -- Core types
    for _, ty in ipairs(core_types) do
        highlight(ty, "type")
    end
    
    -- Essential patterns only
    highlight_region("//", "\n", "comment", false)  -- Line comments
    highlight_region("\"", "\"", "string", true)   -- Strings
    highlight_region("'", "'", "character", false) -- Characters
end

-- Efficient function detection with caching
function M.detect_functions(text, line, column)
    if text == cache.last_text and line == cache.last_line then
        return cache.functions
    end
    
    cache.functions = {}
    cache.last_text = text
    cache.last_line = line
    
    -- Match function declarations
    for func in text:gmatch("fn%s+([a-zA-Z_][a-zA-Z0-9_]*)[%(%s]") do
        cache.functions[func] = true
    end
    
    return cache.functions
end

-- Efficient variable detection with caching
function M.detect_variables(text, line, column)
    if text == cache.last_text and line == cache.last_line then
        return cache.variables
    end
    
    cache.variables = {}
    
    -- Match struct, enum, and variable declarations
    local patterns = {
        "struct%s+([a-zA-Z_][a-zA-Z0-9_]*)",
        "enum%s+([a-zA-Z_][a-zA-Z0-9_]*)",
        "let%s+([a-zA-Z_][a-zA-Z0-9_]*)"
    }
    
    for _, pattern in ipairs(patterns) do
        for var in text:gmatch(pattern) do
            cache.variables[var] = true
        end
    end
    
    return cache.variables
end

-- Essential snippets only
local function init_snippets()
    add_snippet("fn", "fn $1($2) -> $3 {\n    $0\n}")
    add_snippet("struct", "struct $1 {\n    $0\n}")
    add_snippet("impl", "impl $1 {\n    $0\n}")
    add_snippet("test", "#[test]\nfn $1() {\n    $0\n}")
end

-- Initialize only once
init_highlighting()
init_snippets()

return M
