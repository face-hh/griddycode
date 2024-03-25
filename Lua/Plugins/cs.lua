-- This code has been @generated with MonarchToGriddyPlug
-- I edited it a little bit to include more stuff

--#region keywords
highlight("when", "reserved")
highlight("nameof", "reserved")
highlight("unsafe", "reserved")
highlight("stackalloc", "reserved")
highlight("sizeof", "reserved")
highlight("fixed", "reserved")
highlight("await", "reserved")
highlight("async", "reserved")
highlight("null", "reserved")
highlight("enum", "reserved")
highlight("interface", "reserved")
highlight("explicit", "reserved")
highlight("implicit", "reserved")
highlight("false", "reserved")
highlight("true", "reserved")
highlight("operator", "reserved")
highlight("remove", "reserved")
highlight("add", "reserved")
highlight("set", "reserved")
highlight("get", "reserved")
highlight("params", "reserved")
highlight("override", "reserved")
highlight("virtual", "reserved")
highlight("volatile", "reserved")
highlight("readonly", "reserved")
highlight("struct", "reserved")
highlight("static", "reserved")
highlight("sealed", "reserved")
highlight("abstract", "reserved")
highlight("private", "reserved")
highlight("internal", "reserved")
highlight("protected", "reserved")
highlight("public", "reserved")
highlight("param", "reserved")
highlight("method", "reserved")
highlight("event", "reserved")
highlight("field", "reserved")
highlight("class", "reserved")
highlight("partial", "reserved")
highlight("namespace", "reserved")
highlight("by", "reserved")
highlight("group", "reserved")
highlight("select", "reserved")
highlight("descending", "reserved")
highlight("ascending", "reserved")
highlight("orderby", "reserved")
highlight("into", "reserved")
highlight("equals", "reserved")
highlight("on", "reserved")
highlight("join", "reserved")
highlight("where", "reserved")
highlight("let", "reserved")
highlight("from", "reserved")
highlight("yield", "reserved")
highlight("lock", "reserved")
highlight("finally", "reserved")
highlight("catch", "reserved")
highlight("try", "reserved")
highlight("throw", "reserved")
highlight("return", "reserved")
highlight("goto", "reserved")
highlight("continue", "reserved")
highlight("break", "reserved")
highlight("in", "reserved")
highlight("foreach", "reserved")
highlight("for", "reserved")
highlight("do", "reserved")
highlight("while", "reserved")
highlight("case", "reserved")
highlight("switch", "reserved")
highlight("else", "reserved")
highlight("if", "reserved")
highlight("const", "reserved")
highlight("var", "reserved")
highlight("delegate", "reserved")
highlight("default", "reserved")
highlight("unchecked", "reserved")
highlight("checked", "reserved")
highlight("void", "reserved")
highlight("typeof", "reserved")
highlight("new", "reserved")
highlight("base", "reserved")
highlight("this", "reserved")
highlight("out", "reserved")
highlight("ref", "reserved")
highlight("as", "reserved")
highlight("is", "reserved")
highlight("assembly", "reserved")
highlight("string", "reserved")
highlight("dynamic", "reserved")
highlight("object", "reserved")
highlight("double", "reserved")
highlight("float", "reserved")
highlight("char", "reserved")
highlight("ulong", "reserved")
highlight("long", "reserved")
highlight("uint", "reserved")
highlight("int", "reserved")
highlight("ushort", "reserved")
highlight("short", "reserved")
highlight("byte", "reserved")
highlight("sbyte", "reserved")
highlight("decimal", "reserved")
highlight("bool", "reserved")
highlight("using", "reserved")
highlight("alias", "reserved")
highlight("extern", "reserved")
--#endregion

--#region comments
highlight_region("/*", "*/", "comments", false)
highlight_region("//", "", "comments", true)
--#endregion

--#region IDE comments (for CTRL+L)
add_comment("C# Andy detected!")
add_comment("Holy this C# looks like Java")
add_comment("Make your C# roleplay Java, turn that i-- to i++")
add_comment(
	"I thought I'd never see a Microsoft product be open source or source available."
		.. " If only Windows was the same way."
)
add_comment("Avid Windows user")
add_comment(
	"Let's lock you into the Microsoft walled garden even more! "
	.. "Install Windows and use WPF, UWP, and WinForms."
)
add_comment("Probably using Windows making garbage WinForms or UWP tutorials.")
add_comment("Get locked into the walled garden of Windows with UWP, WinForms, or WPF!")
add_comment(
	"UWP? Deprecated. WinForms? Deprecated. WPF? Not deprecated (some people think it's dead). "
		.. "Microsoft deprecates everything they start except WPF."
)
add_comment("C#? More like C-hashtag-please-stop-coding!") -- AI generated
add_comment("!!! JAVA CLONE !!!")
add_comment("rewrite in Rust")
add_comment("NoGet")
add_comment(
	"I swear if you're writing a WPF, UWP, "
		.. "or WinForms app then stop "
		.. "and think about why you're making the microsoft walled garden bigger."
)
--#endregion

---Detects variables for auto complete
---@param content string
---@return string[]
function detect_variables(content)
	local variables = {}
	-- example match: int x =
	-- the reason why there's a 2nd word match
	-- is because we only want declarations of variables,
	-- we want to match `int x =`,
	-- not `x =`, because `x =` is only re-assigning `x`.
	local re = "[a-zA-ZA-z]+ [a-zA-ZA-z]+ ?="
	for match in content:gmatch(re) do
		table.insert(variables, match:split(" ")[2])
	end

	return variables
end

---Detects functions for auto complete
---@param content string
---@return string[]
function detect_functions(content)
	-- example match: typeHere something(
	local re = "[a-zA-ZA-z]+ [a-zA-ZA-z]+%("
	local functions = {}
	for match in content:gmatch(re) do
		table.insert(functions, match:split(" ")[2]:split("(")[1])
	end
	return functions
end
