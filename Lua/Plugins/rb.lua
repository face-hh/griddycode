-- Comments
highlight_region("#", "", "comments", true)
highlight_region("=begin", "=end", "comments", false)

-- Keywords
highlight("BEGIN"    , "reserved")
highlight("END"      , "reserved")
highlight("alias"    , "reserved")
highlight("begin"    , "reserved")
highlight("break"    , "reserved")
highlight("case"     , "reserved")
highlight("class"    , "reserved")
highlight("def"      , "reserved")
highlight("module"   , "reserved")
highlight("next"     , "reserved")
highlight("nil"      , "reserved")
highlight("redo"     , "reserved")
highlight("rescue"   , "reserved")
highlight("retry"    , "reserved")
highlight("return"   , "reserved")
highlight("elsif"    , "reserved")
highlight("end"      , "reserved")
highlight("ensure"   , "reserved")
highlight("for"      , "reserved")
highlight("if"       , "reserved")
highlight("undef"    , "reserved")
highlight("unless"   , "reserved")
highlight("do"       , "reserved")
highlight("else"     , "reserved")
highlight("super"    , "reserved")
highlight("then"     , "reserved")
highlight("until"    , "reserved")
highlight("when"     , "reserved")
highlight("while"    , "reserved")
highlight("defined?" , "reserved")
highlight("self"     , "reserved")
highlight("loop"     , "reserved")
highlight("require"     , "reserved")
highlight("require_relative"     , "reserved")

-- Binary keywords
highlight("true"     , "binary")
highlight("false"    , "binary")

-- Binary Operator Keywords
highlight("or"       , "reserved")
highlight("and"      , "reserved")
highlight("not"      , "reserved")

-- Normal operators
highlight("+", "operator")
highlight("-", "operator")
highlight("*", "operator")
highlight("/", "operator")
highlight("%", "operator")
highlight("&", "operator")
highlight("|", "operator")
highlight("^", "operator")
highlight("**", "operator")
highlight("<<", "operator")
highlight(">>", "operator")
highlight("&&", "operator")
highlight("||", "operator")

-- Assignment (abbreviated) operators
highlight("+=", "operator")
highlight("-=", "operator")
highlight("*=", "operator")
highlight("/=", "operator")
highlight("%=", "operator")
highlight("&=", "operator")
highlight("|=", "operator")
highlight("^=", "operator")
highlight("&&=", "operator")
highlight("**=", "operator")
highlight("||=", "operator")
highlight("<=", "operator")
highlight(">=", "operator")
highlight("==", "operator")
highlight("===", "operator")
highlight("!=", "operator")
highlight("!==", "operator")

highlight("{", "binary")
highlight("}", "binary")
highlight("[", "binary")
highlight("]", "binary")

-- Reserved words
highlight("block_given?", "reserved")
highlight("&block", "reserved")

function detect_functions(content)
  local functionNames = {}

  for line in content:gmatch("[^\r\n]+") do
    -- Match the "def" keyword for regular functions
    -- note that Ruby allows the ! and ? symbols at the end
    -- of function definitions.

    local functionName = line:match("def%s+([%w_(%?%!)]+)/?%s*%(")
      or line:match(".%s+([%w_(%?%!)]+)/?%s*%(")

    -- Although detected properly, AND being a part of the function name as a string,
    -- the base editor does not detect functions with names ending in ! and ? properly for now.
    -- Will open an issue.
    -- - Shannarra
    if functionName then
      table.insert(functionNames, functionName)
    end
  end

  return functionNames
end

function detect_variables(content)
  local variable_names = {
    -- TODO: add variables here if you think of any.. Hmmge
    "self",
  }
  local lines = content:gmatch("[^\r\n]+")

  for line in lines do
    local assignment = line:match("(%w+)%s*=%s*.+")
    if assignment then
      local variable_name = assignment:match("(%w+)")
      table.insert(variable_names, variable_name)
    end
  end

  return variable_names
end
