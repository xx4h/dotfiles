# Default Theme
# If changes made here does not take effect, then try to re-create the tmux session to force reload.

TMUX_POWERLINE_SEG_AIR_COLOR="$(air_color)"

TMUX_POWERLINE_SEPARATOR_LEFT_BOLD=""
TMUX_POWERLINE_SEPARATOR_LEFT_THIN=""
TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD=""
TMUX_POWERLINE_SEPARATOR_RIGHT_THIN=""

# used in "format" function & "__process_segment_defaults"
TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR="default"
TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR="colour255"
# used in ""
TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD}
TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}

#-- theme specifics
# Default colours foreground & background for all status line objects
TMUX_POWERLINE_THEME_BACKGROUND_COLOUR="${TMUX_POWERLINE_THEME_BACKGROUND_COLOUR:-$TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR}"
TMUX_POWERLINE_THEME_FOREGROUND_COLOUR="${TMUX_POWERLINE_THEME_FOREGROUND_COLOUR:-$TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR}"

# Default colours foreground & background for active window status
TMUX_POWERLINE_THEME_ACTIVE_STATUS_BACKGROUND_COLOUR="${TMUX_POWERLINE_THEME_ACTIVE_STATUS_BACKGROUND_COLOUR:-colour250}"
TMUX_POWERLINE_THEME_ACTIVE_STATUS_FOREGROUND_COLOUR="${TMUX_POWERLINE_THEME_ACTIVE_STATUS_FOREGROUND_COLOUR:-colour0}"

# Default colours foreground & background for inactive window status
TMUX_POWERLINE_THEME_INACTIVE_STATUS_BACKGROUND_COLOUR="${TMUX_POWERLINE_THEME_INACTIVE_STATUS_BACKGROUND_COLOUR:-colour240}"
TMUX_POWERLINE_THEME_INACTIVE_STATUS_FOREGROUND_COLOUR="${TMUX_POWERLINE_THEME_INACTIVE_STATUS_FOREGROUND_COLOUR:-colour255}"

# Default window status layout
TMUX_POWERLINE_THEME_LEFTSIDE_WINDOW_SEPARATOR=" "
TMUX_POWERLINE_THEME_RIGHTSIDE_WINDOW_SEPARATOR=""
TMUX_POWERLINE_THEME_MIDDLE_WINDOW_SEPARATOR=""

# Colors for window status with "bell"
TMUX_POWERLINE_BELL_FOREGROUND_COLOR=${TMUX_POWERLINE_BELL_FOREGROUND_COLOR:-colour${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR}}
TMUX_POWERLINE_BELL_BACKGROUND_COLOR=${TMUX_POWERLINE_BELL_BACKGROUND_COLOR:-colour197}

# Colors for window status with "activity"
TMUX_POWERLINE_ACTIVITY_FOREGROUND_COLOR=${TMUX_POWERLINE_ACTIVITY_FOREGROUND_COLOR:-colour0}
TMUX_POWERLINE_ACTIVITY_BACKGROUND_COLOR=${TMUX_POWERLINE_ACTIVITY_BACKGROUND_COLOR:-colour78}

# See `man tmux` for additional formatting options for the status line.
# The `format regular` and `format inverse` functions are provided as conveniences

if [ -z "$TMUX_POWERLINE_WINDOW_STATUS_CURRENT" ]; then
	TMUX_POWERLINE_WINDOW_STATUS_CURRENT=(
		"#[fg=${TMUX_POWERLINE_THEME_ACTIVE_STATUS_BACKGROUND_COLOUR}]"
		"$TMUX_POWERLINE_THEME_LEFTSIDE_WINDOW_SEPARATOR"
		"#[bg=${TMUX_POWERLINE_THEME_ACTIVE_STATUS_BACKGROUND_COLOUR},fg=${TMUX_POWERLINE_THEME_ACTIVE_STATUS_FOREGROUND_COLOUR}]"
		" #I#F "
		"$TMUX_POWERLINE_THEME_MIDDLE_WINDOW_SEPARATOR"
		" #W "
		"#[fg=${TMUX_POWERLINE_THEME_ACTIVE_STATUS_BACKGROUND_COLOUR},bg=${TMUX_POWERLINE_THEME_BACKGROUND_COLOUR}]"
		"$TMUX_POWERLINE_THEME_RIGHTSIDE_WINDOW_SEPARATOR "
	)
fi

if [ -z "$TMUX_POWERLINE_WINDOW_STATUS_STYLE" ]; then
	TMUX_POWERLINE_WINDOW_STATUS_STYLE=(
		"$(format regular)"
	)
fi

if [ -z "$TMUX_POWERLINE_WINDOW_STATUS_FORMAT" ]; then
	TMUX_POWERLINE_WINDOW_STATUS_FORMAT=(
		"#[fg=${TMUX_POWERLINE_THEME_INACTIVE_STATUS_BACKGROUND_COLOUR},bg=default,nobold,noitalics,nounderscore]"
    "#{?window_activity_flag,#[fg=${TMUX_POWERLINE_ACTIVITY_BACKGROUND_COLOR}],}#{?window_bell_flag,#[fg=${TMUX_POWERLINE_BELL_BACKGROUND_COLOR}],}"
		"$TMUX_POWERLINE_THEME_LEFTSIDE_WINDOW_SEPARATOR"
		"#[fg=${TMUX_POWERLINE_THEME_INACTIVE_STATUS_FOREGROUND_COLOUR},bg=${TMUX_POWERLINE_THEME_INACTIVE_STATUS_BACKGROUND_COLOUR},nobold,noitalics,nounderscore]"
    "#{?window_activity_flag,#[bg=${TMUX_POWERLINE_ACTIVITY_BACKGROUND_COLOR}],}#{?window_bell_flag,#[bg=${TMUX_POWERLINE_BELL_BACKGROUND_COLOR}],}"
		" #{?window_activity_flag,#[fg=${TMUX_POWERLINE_ACTIVITY_FOREGROUND_COLOR}],}#{?window_bell_flag,#[fg=${TMUX_POWERLINE_BELL_FOREGROUND_COLOR}],}#I#{?window_flags,#F, } "
		"#[fg=${TMUX_POWERLINE_THEME_INACTIVE_STATUS_BACKGROUND_COLOUR},bg=${TMUX_POWERLINE_THEME_BACKGROUND_COLOUR},nobold,noitalics,nounderscore]"
    "#{?window_activity_flag,#[fg=${TMUX_POWERLINE_ACTIVITY_BACKGROUND_COLOR}],}#{?window_bell_flag,#[fg=${TMUX_POWERLINE_BELL_BACKGROUND_COLOR}],}"
		"$TMUX_POWERLINE_THEME_RIGHTSIDE_WINDOW_SEPARATOR"
		"#[fg=${TMUX_POWERLINE_THEME_FOREGROUND_COLOUR},bg=${TMUX_POWERLINE_THEME_BACKGROUND_COLOUR}]"
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

if [ -z "$TMUX_POWERLINE_LEFT_STATUS_SEGMENTS" ]; then
	TMUX_POWERLINE_LEFT_STATUS_SEGMENTS=(
		"status_icon 148 234 default_separator no_sep_bg_color no_sep_fg_color no_spacing_disable separator_disable"
		"tmux_session_info 148 234"
		"hostname 33 0"
		"vpn 39 0"
		"kubernetes_context 45 0"
		#"mode_indicator 165 0"
		#"ifstat 30 255"
		#"ifstat_sys 30 255"
		#"lan_ip 24 255 ${TMUX_POWERLINE_SEPARATOR_RIGHT_THIN}"
		#"wan_ip 24 255"
		"vcs_branch 51 88"
		"vcs_rootpath 123 17"
		"vcs_compare 60 255"
		"vcs_staged 64 255"
		"vcs_modified 9 255"
		"vcs_others 245 0"
		#"vcs_revision 60 0"
	)
fi

if [ -z "$TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS" ]; then
	TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS=(
		#"earthquake 3 0"
		"pwd 123 0"
		#"macos_notification_count 29 255"
		#"mailcount 9 255"
		"now_playing 51 0"
		#"cpu 240 136"
		#"load 237 167"
		#"tmux_mem_cpu_load 234 136"
		#"battery 137 127"
		#"air ${TMUX_POWERLINE_SEG_AIR_COLOR} 255"
		"weather 45 0"
		#"rainbarf 0 ${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR}"
		#"xkb_layout 125 117"
		"date_week 39 0 default_separator no_sep_bg_color no_sep_fg_color right_disable"
		"date_day 39 0 󰿟 no_sep_bg_color 45 both_disable"
		"date 39 0 󰿟 no_sep_bg_color 45 both_disable"
		"time 39 0 󰿟 no_sep_bg_color 45 left_disable"
		#"date_week 39 0"
		#"date_day 39 0 ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN} no_sep_bg_color 33"
		#"date 39 0 ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN} no_sep_bg_color 33"
		#"time 39 0 ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN} no_sep_bg_color 33"
		#"utc_time 235 136 ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN}"
		"mode_indicator 33 0"
		"github_notifications 148 234"
	)
fi
