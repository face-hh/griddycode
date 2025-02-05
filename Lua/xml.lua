-- XML Language Support
local tags = {}
local attributes = {}

-- Common XML tags
local common_tags = {
    "xml", "html", "head", "body", "div", "span", "p", "a", "img",
    "table", "tr", "td", "th", "form", "input", "button", "select",
    "option", "label", "script", "style", "meta", "link", "title"
}

-- Common attributes
local common_attributes = {
    "id", "class", "style", "href", "src", "alt", "title", "name",
    "value", "type", "width", "height", "target", "rel", "method",
    "action", "lang", "charset", "content"
}

-- Add common tags and attributes to completion
for _, tag in ipairs(common_tags) do
    highlight(tag, "function")
    table.insert(tags, tag)
end

for _, attr in ipairs(common_attributes) do
    highlight(attr, "variable")
    table.insert(attributes, attr)
end

-- Highlight XML syntax
highlight_region("<!--", "-->", "comments", true)
highlight_region("<![CDATA[", "]]>", "string", true)
highlight_region("\"", "\"", "string", true)
highlight_region("'", "'", "string", true)
highlight_region("<", ">", "symbol", false)
highlight("=", "operator")
highlight("/", "operator")
highlight("?", "operator")
highlight("!", "operator")

-- Add some example comments for documentation
add_comment("<!-- This is an XML comment -->")
add_comment("<!-- Use <tag attribute=\"value\"> for XML elements -->")
add_comment("<!-- CDATA sections can contain special characters: <![CDATA[ <, >, & ]]> -->")

-- Function to detect XML tags in context
function detect_functions(text, line, column)
    local detected = {}
    -- Add all known tags
    for _, tag in ipairs(tags) do
        table.insert(detected, tag)
    end
    return detected
end

-- Function to detect attributes in context
function detect_variables(text, line, column)
    local detected = {}
    -- Add all known attributes
    for _, attr in ipairs(attributes) do
        table.insert(detected, attr)
    end
    return detected
end
