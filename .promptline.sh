#
# This shell prompt config file was created by promptline.vim
# with manual edits
#
function PreExecCommand() {
    # The TIMER_ENABLE variable ensures that we only get to call this
    # once unless we flip the flag again
    if [[ -n $TIMER_ENABLE ]] ; then
        COMMAND_START_TIME="$(date +%s%N)"
        unset TIMER_ENABLE
    fi
}
trap 'PreExecCommand' DEBUG

# Signal to print 0s
FIRST_COMMAND=1

function __promptline_exec_time {
    if [[ -n $FIRST_COMMAND ]] ; then
        TIME_TO_DISPLAY="0s"
        return
    fi

    # Number of nanoseconds in these units
    local MSEC=1000000
    local SEC=$(($MSEC * 1000))
    local MIN=$((60 * $SEC))
    local HOUR=$((60 * $MIN))
    local DAY=$((24 * $HOUR))

    local start_time=$COMMAND_START_TIME
    local end_time=$(date +%s%N)
    local duration=$(($end_time - $start_time))

    local num_days=$(($duration / $DAY))
    local num_hours=$(($duration % $DAY / $HOUR))
    local num_mins=$(($duration % $HOUR / $MIN))
    local num_secs=$(($duration % $MIN / $SEC))
    local num_msecs=$(($duration % $SEC / $MSEC))

    TIME_TO_DISPLAY=''

    if [[ $num_days -gt 0 ]]; then
        TIME_TO_DISPLAY="${TIME_TO_DISPLAY}${num_days}d"
    fi
    if [[ $num_hours -gt 0 ]]; then
        TIME_TO_DISPLAY="${TIME_TO_DISPLAY}${num_hours}h"
    fi
    if [[ $num_mins -gt 0 ]]; then
        TIME_TO_DISPLAY="${TIME_TO_DISPLAY}${num_mins}m"
    fi
    local msec_string=$(printf '%03d' $num_msecs)
    TIME_TO_DISPLAY="${TIME_TO_DISPLAY}${num_secs}s$msec_string"
}

function __promptline_host {
  if [ -z $HOSTPROMPT ]; then
    printf "\h"
  else
    printf "$HOSTPROMPT"
  fi
}

function __promptline_last_exit_code {

  [[ $last_exit_code -gt 0 ]] || return 1;

  printf "%s" "$last_exit_code"
}

function __promptline_default_wrapper {
    # A function that calls the wrapper but has default arguments
    # This takes advantage of the dynamically scoped nature of bash. It
    # assumes parameters 2 and 3 are $slice_prefix and $slice_suffix
    __promptline_wrapper "$1" "$slice_prefix" "$slice_suffix" && \
        { slice_prefix="$slice_joiner"; is_prompt_empty=0; }
}


function __promptline_ps1 {
  local slice_prefix slice_empty_prefix slice_joiner slice_suffix is_prompt_empty=1

  # section "a" header
  slice_prefix="${a_bg}${sep}${a_fg}${a_bg}${space}"
  slice_suffix="$space${a_sep_fg}"
  slice_joiner="${a_fg}${a_bg}${alt_sep}${space}"
  slice_empty_prefix="${a_fg}${a_bg}${space}"
  [ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
  # section "a" slices
  __promptline_exec_time
  __promptline_default_wrapper "$TIME_TO_DISPLAY"

  # section "b" header
  slice_prefix="${b_bg}${sep}${b_fg}${b_bg}${space}"
  slice_suffix="$space${b_sep_fg}"
  slice_joiner="${b_fg}${b_bg}${alt_sep}${space}"
  slice_empty_prefix="${b_fg}${b_bg}${space}"
  [ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
  # section "b" slices
  __promptline_default_wrapper "$USER@$(__promptline_host)"

  # section "c" header
  slice_prefix="${c_bg}${sep}${c_fg}${c_bg}${space}"
  slice_suffix="$space${c_sep_fg}"
  slice_joiner="${c_fg}${c_bg}${alt_sep}${space}"
  slice_empty_prefix="${c_fg}${c_bg}${space}"
  [ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
  # section "c" slices
  __promptline_default_wrapper "$(__promptline_cwd)"

  # section "y" header
  slice_prefix="${y_bg}${sep}${y_fg}${y_bg}${space}"
  slice_suffix="$space${y_sep_fg}"
  slice_joiner="${y_fg}${y_bg}${alt_sep}${space}"
  slice_empty_prefix="${y_fg}${y_bg}${space}"
  [ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
  # section "y" slices
  __promptline_default_wrapper "$(__promptline_vcs_branch)"

  # section "warn" header
  slice_prefix="${warn_bg}${sep}${warn_fg}${warn_bg}${space}"
  slice_suffix="$space${warn_sep_fg}"
  slice_joiner="${warn_fg}${warn_bg}${alt_sep}${space}"
  slice_empty_prefix="${warn_fg}${warn_bg}${space}"
  [ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
  # section "warn" slices
  __promptline_default_wrapper "$(__promptline_last_exit_code)"

  # close sections
  printf "%s" "${reset_bg}${sep}$reset$space"
}

function __promptline_vcs_branch {
  local branch
  local branch_symbol=" "

  # git
  if hash git 2>/dev/null; then
    if branch=$( { git symbolic-ref --quiet HEAD || git rev-parse --short HEAD; } 2>/dev/null ); then
      branch=${branch##*/}
      printf "%s" "${branch_symbol}${branch:-unknown}"
      return
    fi
  fi
  return 1
}
function __promptline_cwd {
  printf "\w"
}

function __promptline_wrapper {
  # wrap the text in $1 with $2 and $3, only if $1 is not empty
  # $2 and $3 typically contain non-content-text, like color escape codes and separators

  [[ -n "$1" ]] || return 1
  printf "%s" "${2}${1}${3}"
}

function __promptline_ {
  local last_exit_code="${PROMPTLINE_LAST_EXIT_CODE:-$?}"

  local esc="\033[" end_esc="m"
  local noprint='\[' end_noprint='\]'
  local wrap="$noprint$esc" end_wrap="$end_esc$end_noprint"
  local space=" "
  local sep=""
  local rsep=""
  local alt_sep=""
  local alt_rsep=""
  local reset="${wrap}00${end_wrap}"
  local reset_bg="${wrap}49${end_wrap}"
  local a_fg="${wrap}1;97${end_wrap}"
  local a_bg="${wrap}48;5;1${end_wrap}"
  local a_sep_fg="${wrap}38;5;1${end_wrap}"
  local b_fg="${wrap}38;5;18${end_wrap}"
  local b_bg="${wrap}48;5;21${end_wrap}"
  local b_sep_fg="${wrap}38;5;21${end_wrap}"
  local c_fg="${wrap}97${end_wrap}"
  local c_bg="${wrap}48;5;19${end_wrap}"
  local c_sep_fg="${wrap}38;5;19${end_wrap}"
  local warn_fg="${wrap}38;5;231${end_wrap}"
  local warn_bg="${wrap}48;5;52${end_wrap}"
  local warn_sep_fg="${wrap}38;5;52${end_wrap}"
  local y_fg="${wrap}0;30${end_wrap}"
  local y_bg="${wrap}43${end_wrap}"
  local y_sep_fg="${wrap}33${end_wrap}"
  PS1="$(__promptline_ps1)"

  # Flip the switch to say that we should record the start time now
  unset FIRST_COMMAND
}

function __promptline_enable_timer {
    TIMER_ENABLE=1
}

if [[ ! "$PROMPT_COMMAND" == *__promptline_* ]]; then
  PROMPT_COMMAND='__promptline_; '"$PROMPT_COMMAND"' BCT_AT_PROMPT=0;'
fi
if [[ ! "$PROMPT_COMMAND" == *__promptline_enable_timer* ]]; then
  PROMPT_COMMAND="$PROMPT_COMMAND"' __promptline_enable_timer;'
fi
