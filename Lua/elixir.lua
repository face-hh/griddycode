-- Elixir Language Support
local M = {}

-- Cache commonly used patterns
local cache = {
    functions = {},
    variables = {},
    last_text = "",
    last_line = -1
}

-- Core keywords only (reduced set for better performance)
local core_keywords = {
    -- Most common keywords only
    "def", "defp", "defmodule", "do", "end", "if", "else",
    "case", "cond", "with", "try", "catch", "rescue", "after",
    "import", "alias", "use", "require"
}

-- Reduced operator set (most common only)
local core_operators = {
    "->", "<-", "++", "--", "|>", "=", "==", "!=", ">=", "<="
}

-- Initialize highlighting (done once at startup)
local function init_highlighting()
    for _, kw in ipairs(core_keywords) do
        highlight(kw, "keyword")
    end
    
    for _, op in ipairs(core_operators) do
        highlight(op, "operator")
    end
    
    -- Essential patterns only
    highlight_region("#", "\n", "comment", false)
    highlight_region("\"", "\"", "string", true)
    highlight_region("'", "'", "string", true)
end

-- Efficient pattern matching with result caching
function M.detect_functions(text, line, column)
    -- Return cached result if analyzing same line
    if text == cache.last_text and line == cache.last_line then
        return cache.functions
    end
    
    cache.functions = {}
    cache.last_text = text
    cache.last_line = line
    
    -- Simple pattern matching for def* declarations
    for func in text:gmatch("def[p]?%s+([a-zA-Z_][a-zA-Z0-9_?!]*)[%(%s]") do
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
    
    -- Match module attributes and variables
    for var in text:gmatch("@[a-zA-Z_][a-zA-Z0-9_]*") do
        cache.variables[var] = true
    end
    
    return cache.variables
end

-- Essential snippets only
local function init_snippets()
    add_snippet("defm", "defmodule $1 do\n  $0\nend")
    add_snippet("def", "def $1 do\n  $0\nend")
    add_snippet("defp", "defp $1 do\n  $0\nend")
    add_snippet("test", "test \"$1\" do\n  $0\nend")
end

-- Initialize only once
init_highlighting()
init_snippets()

return M
