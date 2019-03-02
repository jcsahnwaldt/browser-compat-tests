#!/bin/sh

set -e

if [ -z "$1" ]
then
  echo "usage: $0 browser width height text char"
  echo "    browser is required and must be 'chrome' or 'firefox'"
  echo "    other arguments are optional"
  exit 1
fi

chrome="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
firefox="/Applications/Firefox.app/Contents/MacOS/firefox"

width=${2:-15}
height=${3:-10}
text="$4"
fill=${5:-%20}

url="file://$(pwd)/test.html?width=$width&height=$height&text=$text&fill=$fill"

rm -f screenshot.png

"${!1}" --headless --screenshot --window-size="$width,$height" "$url"

pngtopam screenshot.png | tail -n +4
