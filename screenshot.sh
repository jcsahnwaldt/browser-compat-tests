chrome="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
firefox="/Applications/Firefox.app/Contents/MacOS/firefox"
"${!1}" --headless --screenshot --window-size=$2,$3 "file://$(pwd)/index.html?w=$2&h=$3&f=$4"
pngtopam screenshot.png
