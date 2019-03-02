# txt2px

Encode any kind of text as an image that can be decoded back to text by Netbpm tools.

Install [netbpm](http://netpbm.sourceforge.net/) first. On Mac: `brew install netbpm`

### Safari automation

These commands may help with Safari:

```
osascript -e 'tell application "Safari" to open location "'"file://$(pwd)/index.html?w=13&h=13"'"'
```

Note: `/Applications/Safari.app/Contents/MacOS/Safari` can't handle URls with queries. :-(

```
screencapture -l$(osascript -e 'tell app "Safari" to id of window 1') screenshot.png 
```

Problems with this approach: It's too brittle, and there seems to be no way to capture just the canvas area. (Of course, we could use some other tools to crop the screenshot, but... we won't.) The `-R` flag mentioned by `screencapture --help` doesn't seem to work with `l`.
