# ~/.bashrc: executed by bash(1) for non-login shells.

# append to the history file, don't overwrite it
shopt -s histappend

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

FG_BLACK=$'\e[30m';
FG_RED=$'\e[31m';
FG_GREEN=$'\e[32m';
FG_YELLOW=$'\e[33m';
FG_BLUE=$'\e[34m';
FG_MAGENTA=$'\e[35m';
FG_CYAN=$'\e[36m';
FG_WHITE=$'\e[37m';
BG_BLACK=$'\e[40m';
BG_RED=$'\e[41m';
BG_GREEN=$'\e[42m';
BG_YELLOW=$'\e[43m';
BG_BLUE=$'\e[44m';
BG_MAGENTA=$'\e[45m';
BG_CYAN=$'\e[46m';
BG_WHITE=$'\e[47m';
FONT_RESET=$'\e[0m';
FONT_BOLD=$'\e[1m';
FONT_BRIGHT="$FONT_BOLD";
FONT_DIM=$'\e[2m';
FONT_UNDERLINE=$'\e[4m';
FONT_BLINK=$'\e[5m';
FONT_REVERSE=$'\e[7m';
FONT_HIDDEN=$'\e[8m';
FONT_INVISIBLE="$FONT_HIDDEN";


let upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
let secs=$((${upSeconds}%60))
let mins=$((${upSeconds}/60%60))
let hours=$((${upSeconds}/3600%24))
let days=$((${upSeconds}/86400))
UPTIME=`printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs"`

# get the load averages
read one five fifteen rest < /proc/loadavg

echo "$(tput setaf 2)
`date +"%A, %e %B %Y, %X %Z"`
`uname -srmo`$(tput setaf 1)

$FG_WHITE Uptime.............: ${UPTIME} $FG_RED
$FG_WHITE Memory.............: `cat /proc/meminfo | grep MemFree | awk {'print $2'}`kB (Free) / `cat /proc/meminfo | grep MemTotal | awk {'print $2'}`kB (Total) $FG_RED
$FG_WHITE Load Averages......: ${one}, ${five}, ${fifteen} (1, 5, 15 min) $FG_RED
$FG_WHITE Running Processes..: `ps ax | wc -l | tr -d " "` $FG_RED
$FG_WHITE CPU Temperature....:$FG_RED
$FG_WHITE Free Disk Space....: `df -Ph | grep -E '^/dev/root' | awk '{ print $4 " of " $2 }'` $FG_RED
$FG_WHITE IP Addresses.......: `ifconfig | grep 'inet ' | grep -v '127.0.0.1' | awk '{ print $2 }'` $FONT_RESET

$(tput sgr0)"




alias dir="dir --color=auto"
alias grep="grep --color=auto"
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias dmesg='dmesg --color'

alias ls='ls $LS_OPTIONS -Ap'               # Preferred ‘ls’ implementation
alias ll='ls $LS_OPTIONS -lah'              # ls mods
alias la='ls $LS_OPTIONS -lah'              # ls mods
alias l='ls $LS_OPTIONS -Ap'                # ls mods
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
cd() { builtin cd "$@"; ll; }               # Always list directory contents upon 'cd'
alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels
alias ~="cd ~"                              # ~:            Go Home
alias c='clear'                             # c:            Clear terminal display
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
alias show_options='shopt'                  # Show_options: display bash options settings
alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up


# Git Commands
# Add and Commit are used as functions
alias gpo='git push origin master'
alias gp='git pull'
alias gs='git status'
alias gd='git diff'
alias gr='git reflog'
alias glf='git ls-files'


#NEEDS FIXING
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
#alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000


#   mans:   Search manpage given in agument '1' for term given in argument '2' (case insensitive)
#           displays paginated result with colored search terms and two lines surrounding each hit.             Example: mans mplayer codec
#   --------------------------------------------------------------------
    mans () {
        man $1 | grep -iC2 --color=always $2 | less
    }

#   showa: to remind yourself of an alias (given some part of it)
#   ------------------------------------------------------------
    showa () { /usr/bin/grep --color=always -i -a1 $@ ~/Library/init/bash/aliases.bash | grep -v '^\s*$' | less -FSRXc ; }


#   -------------------------------
#   3.  FILE AND FOLDER MANAGEMENT
#   -------------------------------

zipf () { zip -r "$1".zip "$1" ; }          # zipf:         To create a ZIP archive of a folder
alias numFiles='echo $(ls -1 | wc -l)'      # numFiles:     Count of non-hidden files in current dir
alias make1mb='mkfile 1m ./1MB.dat'         # make1mb:      Creates a file of 1mb size (all zeros)
alias make5mb='mkfile 5m ./5MB.dat'         # make5mb:      Creates a file of 5mb size (all zeros)
alias make10mb='mkfile 10m ./10MB.dat'      # make10mb:     Creates a file of 10mb size (all zeros)


 #   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
    extract () {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
             esac
         else
             echo "'$1' is not a valid file"
         fi
    }



#   ---------------------------
#   4.  SEARCHING
#   ---------------------------

alias qfind="find . -iname "                     # qfind:    Quickly search for file
ff () { /usr/bin/find . -iname "$@" ; }          # ff:       Find file under the current directory
ffs () { /usr/bin/find . -iname "$@"'*' ; }      # ffs:      Find file whose name starts with a given string
ffe () { /usr/bin/find . -iname '*'"$@" ; }      # ffe:      Find file whose name ends with a given string

#   spotlight: Search for a file using MacOS Spotlight's metadata
#   -----------------------------------------------------------
    spotlight () { mdfind "kMDItemDisplayName == '$@'wc"; }


#   ---------------------------
#   5.  PROCESS MANAGEMENT
#   ---------------------------

#   findPid: find out the pid of a specified process
#   -----------------------------------------------------
#       Note that the command name can be specified via a regex
#       E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
#       Without the 'sudo' it will only find processes of the current user
#   -----------------------------------------------------
    findPid () { lsof -t -c "$@" ; }

#   memHogsTop, memHogsPs:  Find memory hogs
#   -----------------------------------------------------
    alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'

#   cpuHogs:  Find CPU hogs
#   -----------------------------------------------------
    alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'

#   ttop:  Recommended 'top' invocation to minimize resources
#   ------------------------------------------------------------

#   my_ps: List processes owned by my user:
#   ------------------------------------------------------------
    my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }


#   ---------------------------
#   6.  NETWORKING
#   ---------------------------

alias openNet='lsof -i'                              # netCons:      Show all open TCP/IP sockets
alias flushDNS='dscacheutil -flushcache'             # flushDNS:     Flush out the DNS Cache
alias openSockets='lsof -i -P'                       # lsock:        Display open sockets
alias openUDP='lsof -nP | grep UDP'                  # lsockU:       Display only open UDP sockets
alias openTCP='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
alias openPorts='sudo lsof -i | grep LISTEN'         # openPorts:    All listening connections
alias showBlocked='sudo ipfw list'                   # showBlocked:  All ipfw rules inc/ blocked IPs

#   ii:  display useful host related informaton
#   -------------------------------------------------------------------
#check to see if first green tag works
ii() {
    echo -n "${FG_GREEN}Current date:$FONT_RESET " ; date
    echo -e "You are logged on: $FG_GREEN `uname -srmo` $FONT_RESET"
    echo -n "Additionnal information: " ; uname -a
    echo -e "$FG_GREEN Users logged on:$FONT_RESET " ; w -h

    echo -n "$FG_GREEN Machine stats :$FONT_RESET " ; uptime
    echo -n "$FG_GREEN Public facing IP Address :$FONT_RESET " ; ifconfig | grep 'inet ' | grep -v '127.0.0.1' | awk '{ print $2 }'
    nmcli d
    echo
}


#   ---------------------------------------
#   7.  SYSTEMS OPERATIONS & INFORMATION
#   ---------------------------------------

alias mountReadWrite='/sbin/mount -uw /'    # mountReadWrite:   For use when booted into single-user

#   cleanupDS:  Recursively delete .DS_Store files
#   -------------------------------------------------------------------
    alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"

#   finderShowHidden:   Show hidden files in Finder
#   finderHideHidden:   Hide hidden files in Finder
#   -------------------------------------------------------------------
    alias finderShowHidden='defaults write com.apple.finder ShowAllFiles TRUE'
    alias finderHideHidden='defaults write com.apple.finder ShowAllFiles FALSE'

#   cleanupLS:  Clean up LaunchServices to remove duplicates in the "Open With" menu
#   -----------------------------------------------------------------------------------
    alias cleanupLS="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

#    screensaverDesktop: Run a screensaver on the Desktop
#   -----------------------------------------------------------------------------------
    alias screensaverDesktop='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background'

#   ---------------------------------------
#   8.  WEB DEVELOPMENT
#   ---------------------------------------

# alias apacheEdit='sudo edit /etc/httpd/httpd.conf'      # apacheEdit:       Edit httpd.conf
# alias apacheRestart='sudo apachectl graceful'           # apacheRestart:    Restart Apache
alias editHosts='sudo edit /etc/hosts'                    # editHosts:        Edit /etc/hosts file
alias herr='tail /var/log/httpd/error_log'                # herr:             Tails HTTP error logs
# alias apacheLogs="less +F /var/log/apache2/error_log"   # Apachelogs:   Shows apache error logs
httpHeaders () { /usr/bin/curl -I -L $@ ; }               # httpHeaders:      Grabs headers from web page

#   httpDebug:  Download a web page and show info on what took time
#   -------------------------------------------------------------------
    httpDebug () { /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; }

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Development
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
# source /usr/local/bin/virtualenvwrapper.sh
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


alias unpushed_symbol="△"
alias dirty_unpushed_symbol="▲"
alias unpulled_symbol="▽"
alias dirty_unpulled_symbol="▼"

#   ---------------------------------------
#   9.  REMINDERS & NOTES
#   ---------------------------------------

#   remove_disk: spin down unneeded disk
#   ---------------------------------------
#   diskutil eject /dev/disk1s3

#   to change the password on an encrypted disk image:
#   ---------------------------------------
#   hdiutil chpass /path/to/the/diskimage

#   to mount a read-only disk image as read-write:
#   ---------------------------------------
#   hdiutil attach example.dmg -shadow /tmp/example.shadow -noverify

#   mounting a removable drive (of type msdos or hfs)
#   ---------------------------------------
#   mkdir /Volumes/Foo
#   ls /dev/disk*   to find out the device to use in the mount command)
#   mount -t msdos /dev/disk1s1 /Volumes/Foo
#   mount -t hfs /dev/disk1s1 /Volumes/Foo

#   to create a file of a given size: /usr/sbin/mkfile or /usr/bin/hdiutil
#   ---------------------------------------
#   e.g.: mkfile 10m 10MB.dat
#   e.g.: hdiutil create -size 10m 10MB.dmg
#   the above create files that are almost all zeros - if random bytes are desired
#   then use: ~/Dev/Perl/randBytes 1048576 > 10MB.dat






#    \a : an ASCII bell character (07)
#    \d : the date in “Weekday Month Date” format (e.g., “Tue May 26”)
#    \D{format} : the format is passed to strftime(3) and the result is inserted into the prompt string; an empty format results in a locale-specific time representation. The braces are required
#    \e : an ASCII escape character (033)
#    \h : the hostname up to the first ‘.’
#    \H : the hostname
#    \j : the number of jobs currently managed by the shell
#    \l : the basename of the shell’s terminal device name
#    \n : newline
#    \r : carriage return
#    \s : the name of the shell, the basename of $0 (the portion following the final slash)
#    \t : the current time in 24-hour HH:MM:SS format
#    \T : the current time in 12-hour HH:MM:SS format
#    \@ : the current time in 12-hour am/pm format
#    \A : the current time in 24-hour HH:MM format
#    \u : the username of the current user
#    \v : the version of bash (e.g., 2.00)
#    \V : the release of bash, version + patch level (e.g., 2.00.0)
#    \w : the current working directory, with $HOME abbreviated with a tilde
#    \W : the basename of the current working directory, with $HOME abbreviated with a tilde
#    \! : the history number of this command
#    \# : the command number of this command
#    \$ : if the effective UID is 0, a #, otherwise a $
#    \nnn : the character corresponding to the octal number nnn
#    \\ : a backslash
#    \[ : begin a sequence of non-printing characters, which could be used to embed a terminal control sequence into the prompt
#    \] : end a sequence of non-printing characters



#WORK IN PROGRESS
#code to display jobs but not working correctly
#PS1="\n#\[\`if [[ \$? = "0" ]]; then if [ $(jobs | wc -l ) -gt 0 ]; then echo '$FONT_BOLD$BG_GREEN jobs:\j $FONT_RESET$FONT_BOLD$FG_RED\u$FONT_RESET$FONT_BOLD@$BG_GREEN\h$FONT_RESET'; else echo '$FONT_BOLD$FG_RED\u$FONT_RESET$FONT_BOLD@$BG_GREEN\h$FONT_RESET'; fi else echo '$FONT_BOLD$FG_RED\u$FONT_RESET@$FONT_BOLD$BG_RED\h$FONT_RESET' ; fi\`:\w\n"


echo "#Number of Jobs-User@Command Color: Path" 

#(Number of jobs) if the last command was sucessful then display red name @ green highlight else display red name @ red highlight:(PATH)(NEW LINE)
PS1="\n#\j \[\`if [[ \$? = "0" ]]; then echo '$FONT_BOLD$FG_RED\u$FONT_RESET$FONT_BOLD@$BG_GREEN\h$FONT_RESET'; else echo '$FONT_BOLD$FG_RED\u$FONT_RESET@$FONT_BOLD$BG_RED\h$FONT_RESET' ; fi\`:\w\n"
