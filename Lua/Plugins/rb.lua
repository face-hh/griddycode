-- Comments
highlight_region("#"              , "", "comments", true)
highlight_region("=begin"         , "=end", "comments", false)

-- Strings
highlight_region("\"", "\"", "string")
highlight_region("'", "'", "string")

-- Keywords
--- basic
highlight("BEGIN"                 , "reserved")
highlight("END"                   , "reserved")
highlight("alias"                 , "reserved")
highlight("begin"                 , "reserved")
highlight("class"                 , "reserved")
highlight("module"                , "reserved")
highlight("redo"                  , "reserved")
highlight("rescue"                , "reserved")
highlight("retry"                 , "reserved")
highlight("return"                , "reserved")
highlight("end"                   , "reserved")
highlight("defined?"              , "reserved")
highlight("self"                  , "reserved")
highlight("require"               , "reserved")
highlight("require_relative"      , "reserved")
highlight("def"                   , "reserved")
highlight("nil"                   , "reserved")
highlight("ensure"                , "reserved")
highlight("super"                 , "reserved")

-- branching
highlight("if"                    , "reserved")
highlight("elsif"                 , "reserved")
highlight("unless"                , "reserved")
highlight("else"                  , "reserved")
highlight("case"                  , "reserved")
highlight("when"                  , "reserved")
highlight("then"                  , "reserved")

-- loops
highlight("break"                 , "reserved")
highlight("next"                  , "reserved")
highlight("for"                   , "reserved")
highlight("undef"                 , "reserved")
highlight("do"                    , "reserved")
highlight("until"                 , "reserved")
highlight("while"                 , "reserved")
highlight("loop"                  , "reserved")

-- Binary keywords
highlight("true"                  , "binary")
highlight("false"                 , "binary")

-- Binary Operator Keywords
highlight("or"                    , "reserved")
highlight("and"                   , "reserved")
highlight("not"                   , "reserved")

-- Normal operators
-- binary singular
highlight("+"                     , "operator")
highlight("-"                     , "operator")
highlight("*"                     , "operator")
highlight("/"                     , "operator")
highlight("%"                     , "operator")
highlight("&"                     , "operator")
highlight("|"                     , "operator")
highlight("^"                     , "operator")

-- binary multiple
highlight("**"                    , "operator")
highlight("<<"                    , "operator")
highlight(">>"                    , "operator")
highlight("&&"                    , "operator")
highlight("||"                    , "operator")

-- Assignment (abbreviated) operators
highlight("+="                    , "operator")
highlight("-="                    , "operator")
highlight("*="                    , "operator")
highlight("/="                    , "operator")
highlight("%="                    , "operator")
highlight("&="                    , "operator")
highlight("|="                    , "operator")
highlight("^="                    , "operator")
highlight("&&="                   , "operator")
highlight("**="                   , "operator")
highlight("||="                   , "operator")
highlight("<="                    , "operator")
highlight(">="                    , "operator")
highlight("=="                    , "operator")
highlight("==="                   , "operator")
highlight("!="                    , "operator")
highlight("!=="                   , "operator")

-- additional operators
highlight("{"                     , "binary")
highlight("}"                     , "binary")
highlight("["                     , "binary")
highlight("]"                     , "binary")

-- Reserved words
highlight("block_given?"          , "reserved")
highlight("&block"                , "reserved")

-- Comments
add_comment("Fuck. You. - DHH")
add_comment("Smart people underestimate the ordinarity of ordinary people. - Yukihiro Matsumoto ")
add_comment("Plant a memory, plant a tree, do it today for tomorrow.")
add_comment("Ruby’s original heresy was indeed to place the happiness of the programmer on a pedestal")
add_comment("Don't forget to run Rubocop before pushing  🤖🚓💨")
add_comment("Too weird for you? How about you shut up")
add_comment("IDK what am I doing, but at least in Ruby it looks nice")

function detect_functions(content)
  local functionNames = {}

  for line in content:gmatch("[^\r\n]+") do
    -- Match the "def" keyword for regular functions
    -- note that Ruby allows the ! and ? symbols at the end
    -- of function definitions.

    local functionName = line:match("def%s+([%w_(%?%!)]+)/?%s*%(")
      or line:match(".%s+([%w_(%?%!)]+)/?%s*%(")

    -- Although detected properly , AND being a part of the function name as a string,
    -- the base editor does not detect functions with names ending in ! and ? properly for now.
    -- Will open an issue.
    -- - Shannarra
    if functionName then
      table.insert(functionNames  , functionName)
    end
  end

  return functionNames
end

function detect_variables(content)
  local variable_names = {
    -- TODO: add variables here if you think of any.. Hmmge
    "self"                        ,
  }
  local lines = content:gmatch("[^\r\n]+")

  for line in lines do
    local assignment = line:match("(%w+)%s*=%s*+")
    if assignment then
      local variable_name = assignment:match("(%w+)")
      table.insert(variable_names , variable_name)
    end
  end

  return variable_names
end
