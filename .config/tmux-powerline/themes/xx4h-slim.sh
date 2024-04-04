# Default Theme
# If changes made here does not take effect, then try to re-create the tmux session to force reload.

if patched_font_in_use; then
	TMUX_POWERLINE_SEPARATOR_LEFT_BOLD=""
	TMUX_POWERLINE_SEPARATOR_LEFT_THIN=""
	TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD=""
	TMUX_POWERLINE_SEPARATOR_RIGHT_THIN=""
else
	TMUX_POWERLINE_SEPARATOR_LEFT_BOLD="◀"
	TMUX_POWERLINE_SEPARATOR_LEFT_THIN="❮"
	TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD="▶"
	TMUX_POWERLINE_SEPARATOR_RIGHT_THIN="❯"
fi

# See Color formatting section below for details on what colors can be used here.
TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR:-'235'}
TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR:-'255'}
TMUX_POWERLINE_SEG_AIR_COLOR=$("${TMUX_POWERLINE_DIR_HOME}/segments/air_color.sh")
TMUX_POWERLINE_BELL_FOREGROUND_COLOR=${TMUX_POWERLINE_BELL_FOREGROUND_COLOR:-colour${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR}}
TMUX_POWERLINE_BELL_BACKGROUND_COLOR=${TMUX_POWERLINE_BELL_BACKGROUND_COLOR:-colour197}
TMUX_POWERLINE_ACTIVITY_FOREGROUND_COLOR=${TMUX_POWERLINE_ACTIVITY_FOREGROUND_COLOR:-colour${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR}}
TMUX_POWERLINE_ACTIVITY_BACKGROUND_COLOR=${TMUX_POWERLINE_ACTIVITY_BACKGROUND_COLOR:-colour78}

TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD}
TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}

# See `man tmux` for additional formatting options for the status line.
# The `format regular` and `format inverse` functions are provided as conveniences

if [ -z $TMUX_POWERLINE_WINDOW_STATUS_CURRENT ]; then
	TMUX_POWERLINE_WINDOW_STATUS_CURRENT=(
		"#[$(format inverse)]" \
		"$TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR" \
		" #I#F " \
		"$TMUX_POWERLINE_SEPARATOR_RIGHT_THIN" \
		" #W " \
		"#[$(format regular)]" \
		"$TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR"
	)
fi

if [ -z $TMUX_POWERLINE_WINDOW_STATUS_STYLE ]; then
	TMUX_POWERLINE_WINDOW_STATUS_STYLE=(
		"$(format regular)"
	)
fi

if [ -z $TMUX_POWERLINE_WINDOW_STATUS_FORMAT ]; then
	TMUX_POWERLINE_WINDOW_STATUS_FORMAT=(
		"#[fg=colour235,bg=colour240,nobold,noitalics,nounderscore]" \
    "#{?window_activity_flag,#[bg=${TMUX_POWERLINE_ACTIVITY_BACKGROUND_COLOR}],}#{?window_bell_flag,#[bg=${TMUX_POWERLINE_BELL_BACKGROUND_COLOR}],}" \
		"$TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR" \
		"#[fg=colour255,bg=colour240,nobold,noitalics,nounderscore]" \
    "#{?window_activity_flag,#[bg=${TMUX_POWERLINE_ACTIVITY_BACKGROUND_COLOR}],}#{?window_bell_flag,#[bg=${TMUX_POWERLINE_BELL_BACKGROUND_COLOR}],}" \
		" #{?window_activity_flag,#[fg=${TMUX_POWERLINE_BELL_FOREGROUND_COLOR}],}#{?window_bell_flag,#[fg=${TMUX_POWERLINE_BELL_FOREGROUND_COLOR}],}#I#{?window_flags,#F, } " \
		"#[fg=colour240,bg=colour235,nobold,noitalics,nounderscore]" \
    "#{?window_activity_flag,#[fg=${TMUX_POWERLINE_ACTIVITY_BACKGROUND_COLOR}],}#{?window_bell_flag,#[fg=${TMUX_POWERLINE_BELL_BACKGROUND_COLOR}],}" \
		"$TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR" \
		"#[$(format regular)]" \
		" #W "
	)
fi

# Format: segment_name background_color foreground_color [non_default_separator] [separator_background_color] [separator_foreground_color] [spacing_disable] [separator_disable]
#
# * background_color and foreground_color. Color formatting (see `man tmux` for complete list):
#   * Named colors, e.g. black, red, green, yellow, blue, magenta, cyan, white
#   * Hexadecimal RGB string e.g. #ffffff
#   * 'default' for the default tmux color.
#   * 'terminal' for the terminal's default background/foreground color
#   * The numbers 0-255 for the 256-color palette. Run `tmux-powerline/color-palette.sh` to see the colors.
# * non_default_separator - specify an alternative character for this segment's separator
# * separator_background_color - specify a unique background color for the separator
# * separator_foreground_color - specify a unique foreground color for the separator
# * spacing_disable - remove space on left, right or both sides of the segment:
#   * "left_disable" - disable space on the left
#   * "right_disable" - disable space on the right
#   * "both_disable" - disable spaces on both sides
#   * - any other character/string produces no change to default behavior (eg "none", "X", etc.)
#
# * separator_disable - disables drawing a separator on this segment, very useful for segments
#   with dynamic background colours (eg tmux_mem_cpu_load):
#   * "separator_disable" - disables the separator
#   * - any other character/string produces no change to default behavior
#
# Example segment with separator disabled and right space character disabled:
# "hostname 33 0 {TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD} 33 0 right_disable separator_disable"
#
# Note that although redundant the non_default_separator, separator_background_color and
# separator_foreground_color options must still be specified so that appropriate index
# of options to support the spacing_disable and separator_disable features can be used

if [ -z $TMUX_POWERLINE_LEFT_STATUS_SEGMENTS ]; then
	TMUX_POWERLINE_LEFT_STATUS_SEGMENTS=(
		"tmux_session_info 148 234" \
		"hostname 33 0" \
    "vpn 215 0" \
		"kubernetes_context 45 0" \
		#"mode_indicator 165 0" \
		#"ifstat 30 255" \
		#"ifstat_sys 30 255" \
		#"lan_ip 24 255 ${TMUX_POWERLINE_SEPARATOR_RIGHT_THIN}" \
		#"wan_ip 24 255" \
		"vcs_branch 29 88" \
		"vcs_rootpath 36 17" \
		"vcs_compare 60 255" \
		"vcs_staged 64 255" \
		"vcs_modified 9 255" \
		"vcs_others 245 0" \
		#"vcs_revision 60 0" \
	)
fi

if [ -z $TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS ]; then
	TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS=(
		#"earthquake 3 0" \
		"pwd 89 211" \
		#"macos_notification_count 29 255" \
		#"mailcount 9 255" \
		"now_playing 234 37" \
		#"cpu 240 136" \
		#"load 237 167" \
		#"tmux_mem_cpu_load 234 136" \
		#"battery 137 127" \
		#"air ${TMUX_POWERLINE_SEG_AIR_COLOR} 255" \
		"weather 37 255" \
		#"rainbarf 0 ${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR}" \
		#"xkb_layout 125 117" \
		"date_week 235 136" \
		"date_day 235 136 ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN}" \
		"date 235 136 ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN}" \
		"time 235 136 ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN}" \
		#"utc_time 235 136 ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN}" \
		"mode_indicator 33 0" \
	)
fi
