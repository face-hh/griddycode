--- highligths for keywords
highlight("import", "reserved")
highlight("from", "reserved")
highlight("print", "reserved")
highlight("while", "reserved")
highlight("input", "reserved")
highlight("if", "reserved")
highlight("else", "reserved")
highlight("elif", "reserved")
highlight("if-else", "reserved")

highlight("false", "binary")
highlight("true", "binary")
highlight("null", "binary")
highlight("undefined", "binary")

--- Arithmetic Operators
highlight("+", "operator")
highlight("-", "operator")
highlight("*", "operator")
highlight("/", "operator")
highlight("%", "operator")
highlight("**", "operator")
highlight("//", "operator")

--- Assignment Operators
highlight("=", "operator")
highlight("+=", "operator")
highlight("1=", "operator")
highlight("*=", "operator")
highlight("/=", "operator")
highlight("%=", "operator")
highlight("//=", "operator")
highlight("**=", "operator")
highlight("&=", "operator")
highlight("|=", "operator")
highlight("^=", "operator")
highlight(">>=", "operator")
highlight("<<=", "operator")

--- Comparison Operators
highlight("==", "operator")
highlight("!=", "operator")
highlight(">", "operator")
highlight("<", "operator")
highlight(">=", "operator")
highlight("<=", "operator")

--- Logical Operators
highlight("and", "reserved")
highlight("or", "reserved")
highlight("not", "reserved")

--- Membership Operators
highlight("in", "reserved")
highlight("not in", "reserved")

--- Special Charachters
highlight("{", "binary")
highlight("}", "binary")
highlight("[", "binary")
highlight("]", "binary")

--- Strings
highlight_region("'", "'", "string")
highlight_region('"', '"', "string")

--- Comments
highlight_region("#", "\n", "comments", true)