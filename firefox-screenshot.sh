"/Applications/Firefox.app/Contents/MacOS/firefox" --headless --screenshot --window-size=$1,$2 "file://$(pwd)/index.html?width=$1&height=$2"
pngtopam screenshot.png
