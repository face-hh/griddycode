--- Highlight keywords
highlight("import", "reserved")
highlight("from", "reserved")
highlight("while", "reserved")
highlight("if", "reserved")
highlight("else", "reserved")
highlight("elif", "reserved")

highlight("False", "binary")
highlight("true", "binary")
highlight("None", "binary")

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

--- Special Characters
highlight("{", "binary")
highlight("}", "binary")
highlight("[", "binary")
highlight("]", "binary")

--- Strings
highlight_region("'", "'", "string")
highlight_region('"', '"', "string")
--- (IDE) Comments
add_comment("WHAT THE FUCK STOP")
add_comment("this shi 100% breaking")
add_comment("Waiter, waiter! More useless docstrings for this self-explanatory code!")
add_comment("Tip: remove all spaces and tabs")
add_comment("You have to avoid Python to make your script fast")
add_comment("🚨🚨🚨 🐌🐌🐌 🚨🚨🚨")
add_comment("Do NOT run Python on your computer. I did and ALMOST died")
add_comment("Python is deprecated, uninstall python and use anything else instead.")
add_comment("Stop using black, its name is racist!")
add_comment(
    "For more annoyance, please use PyLint and enable C0114, " 
    .. "C0115, and C0116. You'll hate me for it.")
add_comment(
    "You have to document every variable, function, "
    .. "module, and class in Python because self-explanatory code is not enough")
--- Comments
highlight_region("#", "", "comments", true)
