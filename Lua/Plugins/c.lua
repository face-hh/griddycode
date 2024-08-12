-- Highlight Keywords
local function highlight(word, category)
    -- Function to apply highlighting based on word and category
    print("Highlighting", word, "as", category)
end

local function highlight_region(start_delim, end_delim, category, single_line)
    -- Function to apply highlighting to regions between start_delim and end_delim
    print("Highlighting region from", start_delim, "to", end_delim, "as", category, single_line and "(single line)" or "")
end

local function highlight_all()
    -- Reserved Keywords
    local reserved_keywords = {
        "auto", "break", "case", "char", "const", "continue", "default", "do", "double",
        "else", "enum", "extern", "float", "for", "goto", "if", "inline", "int", "long",
        "register", "restrict", "return", "short", "signed", "sizeof", "static", "struct",
        "switch", "typedef", "union", "unsigned", "void", "volatile", "while",
        "_Alignas", "_Alignof", "_Atomic", "_Bool", "_Complex", "_Generic", "_Imaginary",
        "_Noreturn", "_Static_assert", "_Thread_local"
    }

    -- Operators
    local operators = {
        "+", "-", "*", "/", "%", "++", "--", "=", "+=", "-=", "*=", "/=", "%=", "&=", "^=", "|=", 
        "<<=", ">>=", "==", "!=", ">", "<", ">=", "<=", "&&", "||", "!", "&", "|", "^", "~", "<<", ">>"
    }

    -- Special Characters
    local special_chars = {"{", "}", "[", "]", "(", ")", ";", ","}

    -- Highlight reserved keywords
    for _, keyword in ipairs(reserved_keywords) do
        highlight(keyword, "reserved")
    end

    -- Highlight operators
    for _, operator in ipairs(operators) do
        highlight(operator, "operator")
    end

    -- Highlight special characters
    for _, char in ipairs(special_chars) do
        highlight(char, "binary")
    end

    -- Highlight strings
    highlight_region("\"", "\"", "string")
    highlight_region("'", "'", "string")

    -- Highlight comments
    highlight_region("//", "", "comments", true)
    highlight_region("/*", "*/", "comments", false)
end

-- Autocomplete Functions

local function detect_functions(content)
    local functionNames = {
        -- Standard Library Functions
        "abort", "abs", "acos", "asctime", "asin", "atan", "atan2", "atexit", "atof", "atoi", "atol", "atoll", 
        "bsearch", "btowc", "calloc", "ceil", "clearerr", "clock", "cos", "cosh", "ctime", 
        "difftime", "div", "exit", "exp", "fabs", "fclose", "fcntl", "fdopen", "feof", "ferror", "fflush", 
        "fgetc", "fgetpos", "fgets", "floor", "fmod", "fopen", "fprintf", "fputc", "fputs", "fread", 
        "free", "freopen", "frexp", "fscanf", "fseek", "fsetpos", "ftell", "fwrite", 
        "getc", "getchar", "getenv", "gets", "gmtime", 
        "hypot", "isalnum", "isalpha", "iscntrl", "isdigit", "isgraph", "islower", "isprint", "ispunct", "isspace", "isupper", "isxdigit",
        "labs", "ldexp", "ldiv", "localeconv", "localtime", "log", "log10", "longjmp", "malloc", "mblen", "mbrlen", "mbrtowc", 
        "mbsinit", "mbsrtowcs", "mbstowcs", "mbtowc", "memchr", "memcmp", "memcpy", "memmove", "memset", "mktime", 
        "modf", "perror", "pow", "printf", "putc", "putchar", "puts", "qsort", "raise", 
        "rand", "realloc", "remove", "rename", "rewind", "scanf", "setbuf", "setjmp", "setlocale", "setvbuf", "signal", 
        "sin", "sinh", "sprintf", "sqrt", "srand", "sscanf", "strcat", "strchr", "strcmp", "strcoll", "strcpy", 
        "strcspn", "strerror", "strftime", "strlen", "strncat", "strncmp", "strncpy", "strpbrk", "strrchr", "strspn", "strstr", 
        "strtod", "strtok", "strtol", "strtoul", "strxfrm", "system", "tan", "tanh", "time", 
        "tmpfile", "tmpnam", "ungetc", "vfprintf", "vprintf", "vsprintf", "wcstombs", "wctomb",
        
        -- Additional Common Functions
        "access", "chdir", "chmod", "chown", "closedir", "dup", "dup2", "execv", "execve", 
        "fchdir", "fchmod", "fchown", "fork", "fstat", "getcwd", "getpid", "getppid", "getuid", "geteuid", 
        "getgid", "getegid", "getgrgid", "getgrnam", "gethostname", "getlogin", "getopt", "getpwuid", "getpwnam", "getrlimit", 
        "getrusage", "getsid", "gettimeofday", "kill", "link", "lseek", "mkdir", "mkfifo", "mknod", "open", 
        "opendir", "pipe", "read", "readdir", "rename", "rmdir", "select", "setgid", "setuid", 
        "sleep", "stat", "symlink", "tcdrain", "tcflow", "tcflush", "tcgetattr", "tcsetattr", "tcsendbreak", 
        "time", "times", "truncate", "umask", "uname", "unlink", "utime", "wait", "waitpid", "write",
    
        -- Math Functions
        "acos", "asin", "atan", "atan2", "ceil", "cos", "cosh", "exp", "fabs", "floor", 
        "fmod", "frexp", "ldexp", "log", "log10", "modf", "pow", "sin", "sinh", "sqrt", "tan", "tanh",
    
        -- String Functions
        "memchr", "memcmp", "memcpy", "memmove", "memset", "strcat", "strchr", "strcmp", 
        "strcoll", "strcpy", "strcspn", "strdup", "strerror", "strftime", "strlen", 
        "strncat", "strncmp", "strncpy", "strpbrk", "strrchr", "strspn", "strstr", 
        "strtod", "strtok", "strtol", "strtoul", "strxfrm",
    
        -- Input/Output Functions
        "clearerr", "fclose", "feof", "ferror", "fflush", "fgetc", "fgetpos", 
        "fgets", "fopen", "fprintf", "fputc", "fputs", "fread", "freopen", 
        "fscanf", "fseek", "fsetpos", "ftell", "fwrite", "getc", "getchar", 
        "gets", "perror", "printf", "putc", "putchar", "puts", "remove", 
        "rename", "rewind", "scanf", "setbuf", "setvbuf", "sprintf", "sscanf", 
        "tmpfile", "tmpnam", "ungetc", "vfprintf", "vprintf", "vsprintf",
    
        -- Memory Management Functions
        "calloc", "free", "malloc", "realloc",
    
        -- Utility Functions
        "exit", "getenv", "system", "bsearch", "qsort", "abs", "div", "labs", "ldiv",
    
        -- Character Classification Functions
        "isalnum", "isalpha", "iscntrl", "isdigit", "isgraph", "islower", 
        "isprint", "ispunct", "isspace", "isupper", "isxdigit", "tolower", "toupper",
    
        -- Date and Time Functions
        "asctime", "clock", "ctime", "difftime", "gmtime", "localtime", 
        "mktime", "strftime", "time",
    
        -- Signal Handling Functions
        "signal", "raise",
    
        -- Non-standard and POSIX functions
        "sleep", "getopt", "strdup", "strlcpy", "strlcat", "mkstemp", "mkdtemp", "mkfifo", 
        "popen", "pclose", "getline", "getdelim", "strcasestr", "strsep", "strcasecmp", 
        "strncasecmp", "realpath", "canonicalize_file_name", "readlink", "gethostname", 
        "getlogin", "getlogin_r", "getpwuid", "getpwnam", "getgrgid", "getgrnam", 
        "getuid", "geteuid", "getgid", "getegid", "getppid", "getpgid", "getpgrp", 
        "setuid", "seteuid", "setgid", "setegid", "setpgid", "setpgrp", "fork", 
        "execv", "execve", "execvp", "execl", "execlp", "exit", "abort", "kill", 
        "wait", "waitpid", "waitid", "sleep", "usleep", "nanosleep", "alarm", 
        "pause", "getrlimit", "setrlimit", "getrusage", "times", "clock_gettime", 
        "clock_settime", "clock_getres", "strftime", "gmtime", "localtime", "mktime", 
        "timegm", "difftime", "gettimeofday", "settimeofday", "adjtime", "utime", 
        "utimes", "syscall", "sysctl", "getpagesize", "sysconf", "pathconf", 
        "fpathconf", "confstr", "realpath", "canonicalize_file_name", "getcwd", 
        "chdir", "fchdir", "mkdir", "rmdir", "link", "symlink", "readlink", "unlink", 
        "rename", "chmod", "fchmod", "chown", "fchown", "lchown", "umask", 
        "mkdir", "mkfifo", "mknod", "mkfifoat", "mknodat", "open", "creat", 
        "openat", "close", "lseek", "read", "write", "pread", "pwrite", "readv", 
        "writev", "preadv", "pwritev", "fcntl", "ioctl", "dup", "dup2", "pipe", 
        "pipe2", "socket", "socketpair", "bind", "connect", "listen", "accept", 
        "accept4", "getsockname", "getpeername", "send", "sendto", "recv", "recvfrom", 
        "sendmsg", "recvmsg", "getsockopt", "setsockopt", "shutdown", "close", 
        "dup", "dup2", "fcntl", "ioctl", "getfd", "setfd", "getpid", "getppid", 
        "getuid", "geteuid", "getgid", "getegid", "getpgrp", "setpgrp", "getpgid", 
        "setpgid", "getsid", "setsid", "fork", "vfork", "execv", "execve", 
        "execvp", "execvpe", "execl", "execlp", "execle", "getenv", "putenv", 
        "setenv", "unsetenv", "clearenv", "syslog", "openlog", "closelog", 
        "setlogmask", "popen", "pclose", "pipe", "mkfifo", "umask", "chmod", 
        "fchmod", "chown", "fchown", "lchown", "utime", "utimes", "futimes", 
        "lutimes", "futimens", "utimensat", "stat", "fstat", "lstat", "fstatat", 
        "truncate", "ftruncate", "mkdir", "rmdir", "readlink", "symlink", 
        "link", "unlink", "rename", "realpath", "canonicalize_file_name", "getcwd", 
        "chdir", "fchdir", "chroot", "readdir", "opendir", "closedir", "rewinddir", 
        "dirfd", "telldir", "seekdir", "scandir", "alphasort", "versionsort", 
        "getgrnam", "getgrgid", "getpwnam", "getpwuid", "setpwent", "endpwent", 
        "getpwent", "putpwent", "getgrouplist", "getgrouplist", "getgroups", 
        "setgroups", "initgroups", "gethostbyname", "gethostbyaddr", "gethostbyname2", 
        "gethostent", "sethostent", "endhostent", "getnetbyname", "getnetbyaddr", 
        "getnetent", "setnetent", "endnetent", "getservbyname", "getservbyport", 
        "getservent", "setservent", "endservent", "getprotoent", "getprotobyname", 
        "getprotobynumber", "setprotoent", "endprotoent", "getaddrinfo", 
        "freeaddrinfo", "gai_strerror", "getnameinfo", "gethostbyname", 
        "gethostbyaddr", "gethostent", "sethostent", "endhostent", "getnetbyname", 
        "getnetbyaddr", "getnetent", "setnetent", "endnetent", "getservbyname", 
        "getservbyport", "getservent", "setservent", "endservent", "getprotoent", 
        "getprotobyname", "getprotobynumber", "setprotoent", "endprotoent", 
        "if_nameindex", "if_freenameindex", "if_indextoname", "if_nametoindex"
    }
    

    for line in content:gmatch("[^\r\n]+") do
        -- Match function declarations
        local functionName = line:match("%s*([%w_]+)%s*%([^%)]*%)%s*%{?")
        if functionName then 
            table.insert(functionNames, functionName)
        end
    end

    return functionNames
end

local function detect_variables(content)
    local variable_names = {
        -- Common loop and iterator variables
        "i", "j", "k", "index", "count", "n", "m", "len", "size",
    
        -- Common general-purpose variables
        "temp", "flag", "result", "sum", "total", "average", "min", "max",
    
        -- Variables for pointers and addresses
        "ptr", "p", "q", "address", "buffer",
    
        -- Common string-related variables
        "str", "string", "char", "text", "name", "message",
    
        -- Variables for file handling
        "file", "fp", "filename", "filepath",
    
        -- Variables related to time
        "time", "t", "timestamp", "start_time", "end_time", "duration", "elapsed_time",
    
        -- Variables for dimensions and coordinates
        "x", "y", "z", "width", "height", "depth", "radius", "angle",
    
        -- Flags and status indicators
        "is_valid", "is_ready", "is_done", "is_active", "status", "error", "success", "fail",
    
        -- Counters and indices
        "counter", "pos", "position", "offset",
    
        -- Network-related variables
        "socket", "sockfd", "port", "host", "ip", "address", "client", "server",
    
        -- Data structures and containers
        "array", "list", "queue", "stack", "map", "node", "tree",
    
        -- Variables for numerical values
        "value", "num", "val", "factor", "coefficient", "percentage", "rate",
    
        -- User input/output related
        "input", "output", "arg", "argc", "argv", "input_value", "output_value",
    
        -- Flags and configuration options
        "option", "mode", "config", "setting",
    
        -- Variables for coordinates and points
        "coord", "point", "vector", "matrix",
    
        -- Boolean variables
        "is_true", "is_false", "is_enabled", "is_disabled", "enabled", "disabled",
    
        -- Miscellaneous variables
        "key", "value", "data", "info", "details", "id", "index", "id_num", "record", "entry"
    }    
    local lines = content:gmatch("[^\r\n]+")

    for line in lines do
        -- Match variable declarations
        local variable = line:match("%s*([%w_]+)%s+[%w_]+%s*[=;%(%),]")
      
        if variable then
            table.insert(variable_names, variable)
        end
    end

    return variable_names
end

local function highlight_suggestions(input)
    local suggestions = {}

    -- Reserved Keywords
    local reserved_keywords = {
        "auto", "break", "case", "char", "const", "continue", "default", "do", "double",
        "else", "enum", "extern", "float", "for", "goto", "if", "inline", "int", "long",
        "register", "restrict", "return", "short", "signed", "sizeof", "static", "struct",
        "switch", "typedef", "union", "unsigned", "void", "volatile", "while",
        "_Alignas", "_Alignof", "_Atomic", "_Bool", "_Complex", "_Generic", "_Imaginary",
        "_Noreturn", "_Static_assert", "_Thread_local"
    }

    -- Operators
    local operators = {
        "+", "-", "*", "/", "%", "++", "--", "=", "+=", "-=", "*=", "/=", "%=", "&=", "^=", "|=", 
        "<<=", ">>=", "==", "!=", ">", "<", ">=", "<=", "&&", "||", "!", "&", "|", "^", "~", "<<", ">>"
    }

    -- Special Characters
    local special_chars = {"{", "}", "[", "]", "(", ")", ";", ","}

    -- Check for matching reserved keywords
    for _, keyword in ipairs(reserved_keywords) do
        if keyword:find(input) then
            table.insert(suggestions, { type = "keyword", value = keyword })
        end
    end

    -- Check for matching operators
    for _, operator in ipairs(operators) do
        if operator:find(input) then
            table.insert(suggestions, { type = "operator", value = operator })
        end
    end

    -- Check for matching special characters
    for _, char in ipairs(special_chars) do
        if char:find(input) then
            table.insert(suggestions, { type = "special_char", value = char })
        end
    end

    -- Return the list of suggestions
    return suggestions
end

-- Example usage:
local input = "re"
local suggestions = highlight_suggestions(input)

for _, suggestion in ipairs(suggestions) do
    print("Type:", suggestion.type, "Value:", suggestion.value)
end

-- Run the highlight function
highlight_all()
