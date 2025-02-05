-- TypeScript Language Support
local M = {}

-- Cache for pattern matching results
local cache = {
    functions = {},
    variables = {},
    last_text = "",
    last_line = -1
}

-- Core keywords only (most commonly used)
local core_keywords = {
    -- Essential TypeScript keywords
    "class", "interface", "type", "enum",
    "public", "private", "protected",
    "const", "let", "var",
    "function", "return",
    "if", "else", "switch", "case",
    "for", "while", "do", "break", "continue",
    "import", "export", "from",
    "async", "await",
    "extends", "implements"
}

-- Common types
local core_types = {
    "string", "number", "boolean", "void",
    "null", "undefined", "any", "never",
    "Array", "Promise", "Record", "Partial"
}

-- Essential operators
local core_operators = {
    "=>", "...", "?.", "??", "&&", "||",
    "===", "!==", "==", "!=", ">=", "<="
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
    
    -- Core operators
    for _, op in ipairs(core_operators) do
        highlight(op, "operator")
    end
    
    -- Essential patterns only
    highlight_region("//", "\n", "comment", false)   -- Line comments
    highlight_region("\"", "\"", "string", true)     -- Double quotes
    highlight_region("'", "'", "string", true)       -- Single quotes
    highlight_region("`", "`", "string", true)       -- Template literals
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
    local patterns = {
        "function%s+([a-zA-Z_][a-zA-Z0-9_]*)",
        "([a-zA-Z_][a-zA-Z0-9_]*)%s*=%s*function",
        "([a-zA-Z_][a-zA-Z0-9_]*)%s*:%s*function",
        "async%s+function%s+([a-zA-Z_][a-zA-Z0-9_]*)"
    }
    
    for _, pattern in ipairs(patterns) do
        for func in text:gmatch(pattern) do
            cache.functions[func] = true
        end
    end
    
    return cache.functions
end

-- Efficient variable/type detection with caching
function M.detect_variables(text, line, column)
    if text == cache.last_text and line == cache.last_line then
        return cache.variables
    end
    
    cache.variables = {}
    
    -- Match type definitions and variables
    local patterns = {
        "interface%s+([a-zA-Z_][a-zA-Z0-9_]*)",
        "type%s+([a-zA-Z_][a-zA-Z0-9_]*)",
        "class%s+([a-zA-Z_][a-zA-Z0-9_]*)",
        "enum%s+([a-zA-Z_][a-zA-Z0-9_]*)",
        "const%s+([a-zA-Z_][a-zA-Z0-9_]*)",
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
    -- Core TypeScript snippets
    add_snippet("fn", "function $1($2): $3 {\n    $0\n}")
    add_snippet("afn", "async function $1($2): Promise<$3> {\n    $0\n}")
    add_snippet("int", "interface $1 {\n    $0\n}")
    add_snippet("class", "class $1 {\n    constructor($2) {\n        $0\n    }\n}")
    
    -- React essentials
    add_snippet("rfc", "function $1(props: $2Props) {\n    return (\n        $0\n    );\n}")
    add_snippet("useState", "const [$1, set${1/(.*)/${1:/capitalize}/}] = useState<$2>($3);")
end

-- Initialize only once
init_highlighting()
init_snippets()

return M
