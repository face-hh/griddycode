---@meta

---Tells GriddyCode to highlight a certain keyword with a preset of colors.
---@param keyword string
---@param color string
function highlight(keyword, color) end

---@Tells GriddyCode to highlight a region with a preset of colors.
---@param start string
---@param _end string
---@param color string
---@param line_only? boolean
function highlight_region(start, _end, color, line_only) end

---Adds a comment to be randomly chosen in the `CTRL` + `L` menu.
---@param comment string
function add_comment(comment) end

---Called by GriddyCode upon input. Results are showed in the autocomplete feature.
---@param content string
---@param line integer
---@param column integer
function detect_functions(content, line, column) end

---Called by GriddyCode upon input. Results are showed in the autocomplete feature.
---@param content any
---@param line any
---@param column any
function detect_variables(content, line, column) end

---Set the color of syntax highlighting.
---@param property string
---@param new_color string
function set_keywords(property, new_color) end

---This method is dedicated to the overall GUI aspect of GriddyCode.
---@param property string
---@param new_color string
function set_gui(property, new_color) end

---@param input string
---@param separator string
---@return table<string>
function splitstr(input, separator) end

---@param input string
---@return string
function trim(input) end
