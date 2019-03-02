# txt2px

JavaScript class that encodes text (UTF-8 bytes) as pixels (RGB bytes) in a [https://developer.mozilla.org/en-US/docs/Web/API/Canvas_API](canvas). The canvas data can be downloaded by taking a screenshot and decoded back to text by [Netpbm](http://netpbm.sourceforge.net/) tools.

### Usage

Install Netpbm first. On macOS: `brew install netpbm`

Load `index.html?w=13&h=13&f=%20` in your browser, make a screenshot of the canvas area, save the screenshot as a PNG file `screenshot.png`, and decode the text with `pngtopam screenshot.png`.

### Chrome / Firefox automation

Chrome and Firefox have almost the same command line interface for headless mode. These commands should work on macOS:

```sh
"/Applications/Firefox.app/Contents/MacOS/firefox" --headless --screenshot --window-size=13,13 "file://$(pwd)/index.html?w=13&h=13&f=%20"
pngtopam screenshot.png
```

```sh
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --headless --screenshot --window-size=13,13 "file://$(pwd)/index.html?w=13&h=13&f=%20"
pngtopam screenshot.png
```

### Safari automation

These commands may help with Safari:

```
osascript -e 'tell application "Safari" to open location "'"file://$(pwd)/index.html?w=13&h=13&f=%20"'"'
```

Note: `/Applications/Safari.app/Contents/MacOS/Safari` can't handle URLs with queries. :-(

```
screencapture -l$(osascript -e 'tell app "Safari" to id of window 1') screenshot.png 
```

Problems with this approach: It's too brittle, and there seems to be no way to capture just the canvas area. (Of course, we could use some other tools to crop the screenshot, but... ough.) The `-R` flag mentioned by `screencapture --help` doesn't seem to work with `l`.

### Background

My original goal was to enable a script to start a browser, run some JavaScript in the browser, and get result messages from the browser, but without having to install tools like Selenium. I thought it should be easy to pass data from the browser back to the script, e.g. by saving a file somewhere, or by letting the script access the current DOM, but I didn't find a portable way to do anything like that.

But there's a flag (portable between Chrome and Firefox) to make a screenshot in headless mode, so I wrote a bit of JavaScript code that encodes UTF-8 bytes as pixels. Decoding the pixels is pretty simple because [Netpbm's PAM format](http://netpbm.sourceforge.net/doc/pam.html) has basically the same format as [JavaScript's ImageData.data](https://developer.mozilla.org/en-US/docs/Web/API/ImageData/data) byte array.

The only slight difficulty is the alpha channel - the screenshot is encoded as a [PNG](https://en.wikipedia.org/wiki/Portable_Network_Graphics) without an alpha channel. With any opacity less than 100%, the RGB values are altered, and the resulting text is garbled. The fix is pretty simple though: just set all alpha channel bytes to `0xFF` (100% opacity).
