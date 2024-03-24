local BINARY = "binary";
local RESERVED = "reserved";
local OPERATOR = "operator";
local VARIABLE = "variable";

local hl = highlight;
local hlreg = highlight_region;

hl("false",BINARY);
hl("true",BINARY);
hl("nil",RESERVED);

hl("+",OPERATOR);
hl("-",OPERATOR);
hl("*",OPERATOR);
hl("/",OPERATOR);
hl("^",OPERATOR);
hl("<",OPERATOR);
hl(">",OPERATOR);
hl("<=",OPERATOR);
hl(">=",OPERATOR);
hl("==",OPERATOR);
hl("~=",OPERATOR);

hl("if",RESERVED);
hl("else",RESERVED);
hl("elseif",RESERVED);
hl("and",RESERVED);
hl("repeat",RESERVED);
hl("for",RESERVED);
hl("in",RESERVED);
hl("until",RESERVED);
hl("or",RESERVED);
hl("not",RESERVED);
hl("then",RESERVED);
hl("while",RESERVED);
hl("do",RESERVED);
hl("end",RESERVED);
hl("local",RESERVED);
hl("function",RESERVED);
hl(";",OPERATOR);
hl("#",OPERATOR);
hl("_",OPERATOR);
hl("_G",OPERATOR);
hl("..",OPERATOR);

hl("break",RESERVED);
hl("return", RESERVED);
hl("pairs",BINARY);
hl("ipairs",BINARY);

hl("{",RESERVED);
hl("}",RESERVED);
hl("[",RESERVED);
hl("]",RESERVED);

hlreg("'","'","string",false);
hlreg("\"","\"","string",false);
hlreg("[[","]]","string",false);

hlreg("--","","comments",true);
hlreg("--[[","]]","comments",false);

-- 💀🔥🗣️👍
add_comment("lego game language");
add_comment("Waiter, waiter! Another \"local\" please!");
add_comment("oh god. just WHAT have you done 💀💀");
add_comment("local wait = task.wait;\n\nwait why is there roblx lua in my comment");
add_comment("did bro just type \"null\"");
add_comment("this monkey ain't typing no shakespeare tonight 💀💀");
add_comment("bros FUCKING cooking 🗣️🗣️🔥🔥");
add_comment("bro over cooked the rice 💀💀");
add_comment("im calling your dad rn");
add_comment("[] is a list, right?\n[] is a list, right?!");
add_comment("obama approved code 👍");
add_comment("free tip:\nlithium is very tasty, try it");
add_comment("wdym OOP in Lua\n\noh FUCK its OOP in Lua");
add_comment("lua for the FUCKING WIN FRFR 🔥🔥");
add_comment("TO THE LUA\nnot a crypto scam i swear");
add_comment("gotta get them free robux amirite");
add_comment("please stop writing loops its driving me insane");
add_comment("highlight(\"ipairs\",\"binary\");");
add_comment("why are we all using semi-colons to end our lines when less than 1% of lua users do that");
add_comment("anyone else locked up in a basement being held at gun-point?");

-- my hands hurt.. 
-- (no, ctrl+c ctrl+v wasn't used)
-- !! huge thanks to tutorialspoint.com !!
-- yall the real mvps fr fr
local libraries = {
	["math"] = {
		"abs", "acos", "asin", "atan",
		"atan2", "ceil", "cos", "cosh",
		"deg", "exp", "floor", "fmod",
		"frexp", "huge", "ldexp", "log",
		"log10", "max", "min", "modf",
		"pi", "pow", "rad", "random",
		"randomseed", "sin", "sinh", "sqrt",
		"tan", "tanh"
	},
	["table"] = {
		"concat", "insert", "maxn", "remove",
		"sort"
	},
	["string"] = {
		"upper", "lower", "gsub", "find",
		"reverse", "format", "char", "len",
		"rep", "byte"
	},
	["debug"] = {
		"getfenv", "gethook", "getinfo", "getlocal",
		"getmetatable", "getregistry", "getupvalue", "setfenv",
		"sethook", "setlocal", "setmetatable", "setupvalue",
		"traceback"
	},
	["coroutine"] = {
		"create", "resume", "yield", "status",
		"wrap", "running"
	},
	["io"] = {
		"open", "input", "close", "read",
		"write", "output", "tmpfile", "lines",
		"flush", "type"
	},
	["os"] = {
		"clock", "date", "difftime", "execute",
		"exit", "getenv", "remove", "rename",
		"setlocale", "time", "tmpname"
	}
};
local librariesFunctions = {};
for Library, Methods in pairs(libraries) do
	for _, Method in ipairs(Methods) do
		table.insert(librariesFunctions,Library.."."..Method);
	end;
end;
function detect_functions(content)
	local functionNames = {
		"print", "getfenv", "loadfile", "assert",
		"error", "ipairs", "require", "loadlib",
		"xpcall", "tostring", "rawset", "pairs",
		"loadstring", "pcall", "type", "dofile",
		"wait", "getmetatable", "load", "next",
		"rawget", "rawset", "select", "tostring",
		"tonumber", "unpack", "rawequal", "collectgarbage",
		
		-- (if ur gonna plugin dev, un-comment)
		-- "trim", "splitstr"
		-- courtesy of bussin industries 🔥🔥
	};
	for _, libraryFunction in ipairs(librariesFunctions) do
		table.insert(functionNames,libraryFunction);
	end;

	local lines = {};
	for line in content:gmatch("[^\r\n]+") do
		table.insert(lines, line);
	end;
	for _, line in ipairs(lines) do
		if trim(line):find("^function ") or trim(line):find("^local function ") and string.find(line, "%(") then
			local functionName =
				string.match(trim(line):gsub("then",""), "function%s+(.-)%s*%(") or
				string.match(trim(line):gsub("then",""), "local%s+(.-)%s*%(")
			table.insert(functionNames, functionName);
		end;
	end;

	return functionNames;
end;

local Variables = {
	"_", "_G", "_VERSION"
};
for Library, _ in pairs(libraries) do
	table.insert(Variables,Library);
end;
for _, variable in ipairs(Variables) do
	hl(variable,VARIABLE);
end;
function detect_variables(content)
	local variable_names = {
		"return", "in", "boolean", "number",
		"if", "then", "do", "while",
		"for", "repeat", "until", "break",
		"or", "and", "not", "else", "elseif",
		"in", "false", "true", "nil",
		"userdata", "thread", "end",
		"local", "function"
	};
	for _, variable in ipairs(Variables) do
		table.insert(variable_names,variable);
	end;

	local lines = content:gmatch("[^\r\n]+");
	for line in lines do
		if trim(line):find("=") and not trim(line):find("==") then
			line = line:gsub("local","");
			local parts = splitstr(line, "=");
			if #parts > 0 then
				if trim(parts[1]):find(",") then
					for _, variable in ipairs(splitstr(parts[1],",")) do
						table.insert(variable_names, trim(variable));
					end;
				else
					local variable_name = trim(parts[1]);
					table.insert(variable_names, variable_name);
				end;
			end;
		end;
	end;

	return variable_names;
end;
