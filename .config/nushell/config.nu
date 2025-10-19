## PREAMBLE
#
# config.nu
#
# Installed by:
# version = "0.107.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R
# 
## PREAMBLE

## CUSTOM CONFIG
#
$env.config.edit_mode = "vi"
#
$env.config.show_banner = "false"
#
$env.config.cursor_shape.vi_insert = "line"
$env.config.cursor_shape.vi_normal = "block"
#
$env.config.table.mode = "heavy"
#
$env.config.table.trim = {
  methodology: "wrapping"
  wrapping_try_keep_words: true
}
#
$env.config.datetime_format.table = "%y-%b-%d-%H_%M_%S"
$env.config.datetime_format.normal = "%y-%b-%d-%H_%M_%S"
#
$env.config.filesize.precision = 2
#
$env.PROMPT_COMMAND_RIGHT = {||}
$env.PROMPT_INDICATOR_VI_NORMAL = " "
$env.PROMPT_INDICATOR_VI_INSERT = " "
