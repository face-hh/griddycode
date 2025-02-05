-- HTML Keywords
highlight("!DOCTYPE", "reserved")
highlight("a", "reserved")
highlight("abbr", "reserved")
highlight("acronym", "reserved")
highlight("address", "reserved")
highlight("applet", "reserved")
highlight("area", "reserved")
highlight("article", "reserved")
highlight("aside", "reserved")
highlight("audio", "reserved")
highlight("b", "reserved")
highlight("base", "reserved")
highlight("basefont", "reserved")
highlight("bdi", "reserved")
highlight("bdo", "reserved")
highlight("big", "reserved")
highlight("blockquote", "reserved")
highlight("body", "reserved")
highlight("br", "reserved")
highlight("button", "reserved")
highlight("canvas", "reserved")
highlight("caption", "reserved")
highlight("c", "reserved")
highlight("center", "reserved")
highlight("cite", "reserved")
highlight("code", "reserved")
highlight("col", "reserved")
highlight("colgroup", "reserved")
highlight("data", "reserved")
highlight("datalist", "reserved")
highlight("dd", "reserved")
highlight("del", "reserved")
highlight("details", "reserved")
highlight("dfn", "reserved")
highlight("dialog", "reserved")
highlight("dir", "reserved")
highlight("div", "reserved")
highlight("dl", "reserved")
highlight("dt", "reserved")
highlight("em", "reserved")
highlight("embed", "reserved")
highlight("fieldset", "reserved")
highlight("figcaption", "reserved")
highlight("figure", "reserved")
highlight("font", "reserved")
highlight("footer", "reserved")
highlight("form", "reserved")
highlight("frame", "reserved")
highlight("frameset", "reserved")
highlight("h1", "reserved")
highlight("h2", "reserved")
highlight("h3", "reserved")
highlight("h4", "reserved")
highlight("h5", "reserved")
highlight("h6", "reserved")
highlight("head", "reserved")
highlight("header", "reserved")
highlight("hgroup", "reserved")
highlight("hr", "reserved")
highlight("html", "reserved")
highlight("i", "reserved")
highlight("iframe", "reserved")
highlight("img", "reserved")
highlight("input", "reserved")
highlight("ins", "reserved")
highlight("kbd", "reserved")
highlight("label", "reserved")
highlight("legend", "reserved")
highlight("li", "reserved")
highlight("link", "reserved")
highlight("main", "reserved")
highlight("map", "reserved")
highlight("mark", "reserved")
highlight("menu", "reserved")
highlight("meta", "reserved")
highlight("meter", "reserved")
highlight("nav", "reserved")
highlight("noframes", "reserved")
highlight("noscript", "reserved")
highlight("object", "reserved")
highlight("ol", "reserved")
highlight("optgroup", "reserved")
highlight("option", "reserved")
highlight("output", "reserved")
highlight("p", "reserved")
highlight("param", "reserved")
highlight("picture", "reserved")
highlight("pre", "reserved")
highlight("progress", "reserved")
highlight("q", "reserved")
highlight("rp", "reserved")
highlight("rt", "reserved")
highlight("ruby", "reserved")
highlight("s", "reserved")
highlight("samp", "reserved")
highlight("script", "reserved")
highlight("search", "reserved")
highlight("section", "reserved")
highlight("select", "reserved")
highlight("small", "reserved")
highlight("source", "reserved")
highlight("span", "reserved")
highlight("strike", "reserved")
highlight("strong", "reserved")
highlight("sub", "reserved")
highlight("summary", "reserved")
highlight("sup", "reserved")
highlight("svg", "reserved")
highlight("table", "reserved")
highlight("tbody", "reserved")
highlight("td", "reserved")
highlight("template", "reserved")
highlight("textarea", "reserved")
highlight("tfoot", "reserved")
highlight("th", "reserved")
highlight("thead", "reserved")
highlight("time", "reserved")
highlight("title", "reserved")
highlight("tr", "reserved")
highlight("track", "reserved")
highlight("tt", "reserved")
highlight("u", "reserved")
highlight("ul", "reserved")
highlight("var", "reserved")
highlight("video", "reserved")
highlight("wbr", "reserved")

-- CSS Keywords
local css_keywords = {
    "accent-color", 
    "align-content", 
    "align-items", 
    "align-self", 
    "all", 
    "animation", 
    "animation-delay", 
    "animation-direction", 
    "animation-duration", 
    "animation-fill-mode", 
    "animation-iteration-count", 
    "animation-name", 
    "animation-play-state", 
    "animation-timing-reserved", 
    "aspect-ratio", 
    "backdrop-filter", 
    "backface-visibility", 
    "background", 
    "background-attachment", 
    "background-blend-mode", 
    "background-clip", 
    "background-color", 
    "background-image", 
    "background-origin", 
    "background-position", 
    "background-position-x", 
    "background-position-y", 
    "background-repeat", 
    "background-size", 
    "block-size", 
    "border", 
    "border-block", 
    "border-block-color", 
    "border-block-end", 
    "border-block-end-color", 
    "border-block-end-style", 
    "border-block-end-width", 
    "border-block-start", 
    "border-block-start-color", 
    "border-block-start-style", 
    "border-block-start-width", 
    "border-block-style", 
    "border-block-width", 
    "border-bottom", 
    "border-bottom-color", 
    "border-bottom-left-radius", 
    "border-bottom-right-radius", 
    "border-bottom-style", 
    "border-bottom-width", 
    "border-collapse", 
    "border-color", 
    "border-end-end-radius", 
    "border-end-start-radius", 
    "border-image", 
    "border-image-outset", 
    "border-image-repeat", 
    "border-image-slice", 
    "border-image-source", 
    "border-image-width", 
    "border-inline", 
    "border-inline-color", 
    "border-inline-end", 
    "border-inline-end-color", 
    "border-inline-end-style", 
    "border-inline-end-width", 
    "border-inline-start", 
    "border-inline-start-color", 
    "border-inline-start-style", 
    "border-inline-start-width", 
    "border-inline-style", 
    "border-inline-width", 
    "border-left", 
    "border-left-color", 
    "border-left-style", 
    "border-left-width", 
    "border-radius", 
    "border-right", 
    "border-right-color", 
    "border-right-style", 
    "border-right-width", 
    "border-spacing", 
    "border-start-end-radius", 
    "border-start-start-radius", 
    "border-style", 
    "border-top", 
    "border-top-color", 
    "border-top-left-radius", 
    "border-top-right-radius", 
    "border-top-style", 
    "border-top-width", 
    "border-width", 
    "bottom", 
    "box-decoration-break", 
    "box-reflect", 
    "box-shadow", 
    "box-sizing", 
    "break-after", 
    "break-before", 
    "break-inside", 
    "caption-side", 
    "caret-color", 
    "@charset", 
    "clear", 
    "clip", 
    "clip-path", 
    "color", 
    "column-count", 
    "column-fill", 
    "column-gap", 
    "column-rule", 
    "column-rule-color", 
    "column-rule-style", 
    "column-rule-width", 
    "column-span", 
    "column-width", 
    "columns", 
    "content", 
    "counter-increment", 
    "counter-reset", 
    "counter-set", 
    "cursor", 
    "direction", 
    "display", 
    "empty-cells", 
    "filter", 
    "flex", 
    "flex-basis", 
    "flex-direction", 
    "flex-flow", 
    "flex-grow", 
    "flex-shrink", 
    "flex-wrap", 
    "float", 
    "font", 
    "@font-face", 
    "font-family", 
    "font-feature-settings", 
    "@font-feature-values", 
    "font-kerning", 
    "font-language-override", 
    "font-size", 
    "font-size-adjust", 
    "font-stretch", 
    "font-style", 
    "font-synthesis", 
    "font-variant", 
    "font-variant-alternates", 
    "font-variant-caps", 
    "font-variant-east-asian", 
    "font-variant-ligatures", 
    "font-variant-numeric", 
    "font-variant-position", 
    "font-weight", 
    "gap", 
    "grid", 
    "grid-area", 
    "grid-auto-columns", 
    "grid-auto-flow", 
    "grid-auto-rows", 
    "grid-column", 
    "grid-column-end", 
    "grid-column-gap", 
    "grid-column-start", 
    "grid-gap", 
    "grid-row", 
    "grid-row-end", 
    "grid-row-gap", 
    "grid-row-start", 
    "grid-template", 
    "grid-template-areas", 
    "grid-template-columns", 
    "grid-template-rows", 
    "hanging-punctuation", 
    "height", 
    "hyphens", 
    "hypenate-character", 
    "image-rendering", 
    "@import", 
    "inline-size", 
    "inset", 
    "inset-block", 
    "inset-block-end", 
    "inset-block-start", 
    "inset-inline", 
    "inset-inline-end", 
    "inset-inline-start", 
    "isolation", 
    "justify-content", 
    "justify-items", 
    "justify-self", 
    "@keyframes", 
    "left", 
    "letter-spacing", 
    "line-break", 
    "line-height", 
    "list-style", 
    "list-style-image", 
    "list-style-position", 
    "list-style-type", 
    "margin", 
    "margin-block", 
    "margin-block-end", 
    "margin-block-start", 
    "margin-bottom", 
    "margin-inline", 
    "margin-inline-end", 
    "margin-inline-start", 
    "margin-left", 
    "margin-right", 
    "margin-top", 
    "mask", 
    "mask-clip", 
    "mask-composite", 
    "mask-image", 
    "mask-mode", 
    "mask-origin", 
    "mask-position", 
    "mask-repeat", 
    "mask-size", 
    "mask-type", 
    "max-height", 
    "max-width", 
    "@media", 
    "max-block-size", 
    "max-inline-size", 
    "min-block-size", 
    "min-inline-size", 
    "min-height", 
    "min-width", 
    "mix-blend-mode", 
    "object-fit", 
    "object-position", 
    "offset", 
    "offset-anchor", 
    "offset-distance", 
    "offset-path", 
    "offset-rotate", 
    "opacity", 
    "order", 
    "orphans", 
    "outline", 
    "outline-color", 
    "outline-offset", 
    "outline-style", 
    "outline-width", 
    "overflow", 
    "Specifies", 
    "overflow-anchor", 
    "Specifies", 
    "overflow-wrap", 
    "overflow-x", 
    "overflow-y", 
    "overscroll-behavior", 
    "overscroll-behavior-block", 
    "overscroll-behavior-inline", 
    "overscroll-behavior-x", 
    "overscroll-behavior-y", 
    "padding", 
    "padding-block", 
    "padding-block-end", 
    "padding-block-start", 
    "padding-bottom", 
    "padding-inline", 
    "padding-inline-end", 
    "padding-inline-start", 
    "padding-left", 
    "padding-right", 
    "padding-top", 
    "page-break-after", 
    "page-break-before", 
    "page-break-inside", 
    "paint-order", 
    "perspective", 
    "perspective-origin", 
    "place-content", 
    "place-items", 
    "place-self", 
    "pointer-events", 
    "position", 
    "quotes", 
    "resize", 
    "right", 
    "rotate", 
    "row-gap", 
    "scale", 
    "scroll-behavior", 
    "scroll-margin", 
    "scroll-margin-block", 
    "scroll-margin-block-end", 
    "scroll-margin-block-start", 
    "scroll-margin-bottom", 
    "scroll-margin-inline", 
    "scroll-margin-inline-end", 
    "scroll-margin-inline-start", 
    "scroll-margin-left", 
    "scroll-margin-right", 
    "scroll-margin-top", 
    "scroll-padding", 
    "scroll-padding-block", 
    "scroll-padding-block-end", 
    "scroll-padding-block-start", 
    "scroll-padding-bottom", 
    "scroll-padding-inline", 
    "scroll-padding-inline-end", 
    "scroll-padding-inline-start", 
    "scroll-padding-left", 
    "scroll-padding-right", 
    "scroll-padding-top", 
    "scroll-snap-align", 
    "scroll-snap-stop", 
    "scroll-snap-type", 
    "scrollbar-color", 
    "tab-size", 
    "table-layout", 
    "text-align", 
    "text-align-last", 
    "text-combine-upright", 
    "text-decoration", 
    "text-decoration-color", 
    "text-decoration-line", 
    "text-decoration-style", 
    "text-decoration-thickness", 
    "text-emphasis", 
    "text-emphasis-color", 
    "text-emphasis-position", 
    "text-emphasis-style", 
    "text-indent", 
    "text-justify", 
    "text-orientation", 
    "text-overflow", 
    "text-shadow", 
    "text-transform", 
    "text-underline-offset", 
    "text-underline-position", 
    "top", 
    "transform", 
    "transform-origin", 
    "transform-style", 
    "transition", 
    "transition-delay", 
    "transition-duration", 
    "transition-property", 
    "transition-timing-reserved", 
    "translate", 
    "unicode-bidi", 
    "user-select", 
    "vertical-align", 
    "visibility", 
    "white-space", 
    "widows", 
    "width", 
    "word-break", 
    "word-spacing", 
    "word-wrap", 
    "writing-mode", 
    "z-index", 
}
for keyword in css_keywords do
    highlight(keyword, "function")
end

--- Special Characters
highlight("{", "symbol")
highlight("#", "symbol")
highlight(".", "symbol")

--- Autocomplete

function detect_variables(content)
    local variable_names = css_keywords
    local lines = content:gmatch("[^\r\n]+")

    for line in lines do
        if trim(line):find("^--") then
            local parts = splitstr(line, ":")
            if #parts > 0 then
                local variable_name = trim(parts[1])
                table.insert(variable_names, "--" .. variable_name)
            end
        end
    end

    return variable_names
end
