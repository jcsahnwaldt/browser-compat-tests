if [ -z "$1" ] ; then echo usage: "$0" '<chrome|firefox>'; exit 1; fi
chrome="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
firefox="/Applications/Firefox.app/Contents/MacOS/firefox"
"${!1}" --headless --screenshot --window-size=10,15 "file://$(pwd)/lorem.html?w=10&h=15&f=%20"
pngtopam screenshot.png | tail -n +4
