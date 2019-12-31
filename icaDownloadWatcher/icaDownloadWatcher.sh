#! /bin/zsh
SCRIPT_PATH=$(cd "${0%/*}" 2>/dev/null; echo "$PWD"/)
SCRIPT_NAME=$(basename $0)
PLIST_NAME=${SCRIPT_NAME/.sh/.plist}
NAME=${SCRIPT_NAME/.sh/}


function usage() {
    echo "${SCRIPT_NAME}"
    echo "Installs script to run on login that uses watchexec to"
    echo "watch for *.ica files in Downloads folder. These will"
    echo "be automatically opened to start Citrix."
    echo "Parameters:"
    echo "    -i : Create plist file and install as launchctl service"
    echo "    -h : Show this help."
    exit 0
}


function install() {
    set -e
    print -P "%F{green}Checking for watchexec installation ...%f"
    if ! which watchexec; then
        print -P "%F{red}watchexec is missing, please install it with%f"
        print -P "  brew cask install watchexec"
        exit 1
    fi
    print -P "%F{green}Writing ${PLIST_NAME} content ...%f"
    TEMP=$(mktemp) || exit 1
    echo '<?xml version="1.0" encoding="UTF-8"?>' > ${TEMP}
    echo '<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">' >> ${TEMP}
    echo '<plist version="1.0">' >> ${TEMP}
    echo '<dict>' >> ${TEMP}
    echo '   <key>Label</key>' >> ${TEMP}
    echo '   <string>au.com.sailer.'${NAME}'</string>' >> ${TEMP}
    echo '   <key>ProgramArguments</key>' >> ${TEMP}
    echo '   <array><string>'${SCRIPT_PATH}${SCRIPT_NAME}'</string></array>' >> ${TEMP}
    echo '   <key>RunAtLoad</key>' >> ${TEMP}
    echo '   <true/>' >> ${TEMP}
    echo '   <key>EnvironmentVariables</key>' >> ${TEMP}
    echo '   <dict>' >> ${TEMP}
    echo '       <key>PATH</key>' >> ${TEMP}
    echo '       <string><![CDATA[/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin]]></string>' >> ${TEMP}
    echo '   </dict>' >> ${TEMP}
    echo '   <key>WorkingDirectory</key>' >> ${TEMP}
    echo '   <string>'${SCRIPT_PATH}'</string>' >> ${TEMP}
    echo '</dict>' >> ${TEMP}
    echo '</plist>' >> ${TEMP}
    cat ${TEMP} | sed 's/^/     /'
    if [[ ! -a ~/Library/LaunchAgents ]]; then
        print -P "%F{green}Creating ~/Library/LaunchAgents ...%f"
        mkdir ~/Library/LaunchAgents
    fi
    if [[ -a ~/Library/LaunchAgents/${PLIST_NAME} ]]; then
        print -P "%F{green}Unloading service ...%f"
        launchctl unload ~/Library/LaunchAgents/${PLIST_NAME}
    fi
    print -P "%F{green}Copying ${PLIST_NAME} ...%f"
    cp ${TEMP} ~/Library/LaunchAgents/${PLIST_NAME}
    print -P "%F{green}Loading service ...%f"
    launchctl load ~/Library/LaunchAgents/${PLIST_NAME}
    launchctl list | grep ${NAME}
    rm ${TEMP}
    exit 0
}

while getopts "ih" optionName; do
    case "$optionName" in
        h) usage;;
        i) install;;
    esac
done

/usr/local/bin/watchexec --watch ~/Downloads/ --exts "*.ica" /usr/bin/open "\$WATCHEXEC_CREATED_PATH" &>/dev/null