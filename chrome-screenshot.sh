cp index.html /tmp
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --headless --screenshot --window-size=$1,$2 "file:///tmp/index.html?width=$1&height=$2"
pngtopam screenshot.png
