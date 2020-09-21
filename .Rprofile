# see https://help.farbox.com/pygments.html
# for a list of supported color schemes, default scheme is "native"
options(radian.color_scheme = "monokai")

# either  `"emacs"` (default) or `"vi"`.
options(radian.editing_mode = "vi")

# indent continuation lines
# turn this off if you want to copy code without the extra indentation;
# but it leads to less elegent layout
options(radian.indent_lines = TRUE)

# auto match brackets and quotes
options(radian.auto_match = TRUE)

# auto indentation for new line and curly braces
options(radian.auto_indentation = TRUE)
options(radian.tab_size = 4)

# pop up completion while typing
options(radian.complete_while_typing = TRUE)
# timeout in seconds to cancel completion if it takes too long
# set it to 0 to disable it
options(radian.completion_timeout = 0.05)

# automatically adjust R buffer size based on terminal width
options(radian.auto_width = TRUE)

# insert new line between prompts
options(radian.insert_new_line = TRUE)

# when using history search (ctrl-r/ctrl-s in emacs mode), do not show duplicate results
options(radian.history_search_no_duplicates = FALSE)

# custom prompt for different modes
options(radian.prompt = "\033[0;34mr$>\033[0m ")
options(radian.shell_prompt = "\033[0;31m#!>\033[0m ")
options(radian.browse_prompt = "\033[0;33mBrowse[{}]>\033[0m ")

# supress the loading message for reticulate
options(radian.suppress_reticulate_message = FALSE)
# enable reticulate prompt and trigger `~`
options(radian.enable_reticulate_prompt = TRUE)

# allows user defined shortcuts, these keys should be escaped when send through the terminal.
# In the following example, `esc` + `-` sends `<-` and `esc` + `m` sends `%>%`.
# Note that in some terminals, you could mark `alt` as `escape` so you could use `alt` + `-` instead.
options(radian.escape_key_map = list(
    list(key = "-", value = "<-"),
    list(key = "m", value = "%>%")
))
