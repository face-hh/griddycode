-- YAML Language Support
local M = {}

-- Cache for pattern matching results
local cache = {
    keys = {},
    last_text = "",
    last_line = -1
}

-- Core YAML tokens (reduced set)
local core_tokens = {
    -- Basic scalars
    "true", "false", "null", "~",
    -- Common directives
    "%YAML", "%TAG"
}

-- Essential special characters
local core_chars = {
    ":", "-", "|", ">", "&", "*"
}

-- Initialize highlighting (done once at startup)
local function init_highlighting()
    -- Core tokens
    for _, token in ipairs(core_tokens) do
        highlight(token, "constant")
    end
    
    -- Special characters
    for _, char in ipairs(core_chars) do
        highlight(char, "operator")
    end
    
    -- Essential patterns only
    highlight_region("#", "\n", "comment", false)  -- Comments
    highlight_region("\"", "\"", "string", true)   -- Double quoted strings
    highlight_region("'", "'", "string", true)     -- Single quoted strings
    highlight_pattern("^%s*-%s", "operator")       -- List items
    highlight_pattern("^%s*[%w_-]+:", "identifier") -- Keys
end

-- Efficient key/anchor detection with caching
function M.detect_variables(text, line, column)
    if text == cache.last_text and line == cache.last_line then
        return cache.keys
    end
    
    cache.keys = {}
    cache.last_text = text
    cache.last_line = line
    
    -- Match keys and anchors
    for key in text:gmatch("^%s*([%w_-]+):") do
        cache.keys[key] = true
    end
    
    -- Match anchors and aliases
    for anchor in text:gmatch("[&*]([%w_-]+)") do
        cache.keys[anchor] = true
    end
    
    return cache.keys
end

-- Essential snippets only
local function init_snippets()
    -- Basic YAML structures
    add_snippet("---", "---\n$0")
    add_snippet("list", "- $0")
    add_snippet("map", "$1: $0")
    
    -- Common templates (minimal versions)
    add_snippet("docker", "version: '$1'\nservices:\n  $2:\n    image: $0")
    add_snippet("k8s", "apiVersion: $1\nkind: $2\nmetadata:\n  name: $3")
end

-- Initialize only once
init_highlighting()
init_snippets()

return M
