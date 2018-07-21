"use strict";

class PxTxt {
  constructor(canvas, fill) {
    this.ctx = canvas.getContext('2d');
    this.img = this.ctx.createImageData(canvas.width, canvas.height);
    this.px = this.img.data;
    this.px.fill(fill);
    for (let i = 3; i < this.px.length; i += 4) this.px[i] = 0xFF; // set alpha byte
    this.ctx.putImageData(this.img, 0, 0);
    this.ix = 0;
  }

  utf8len(b) {
    return b >= 0b11110000 ? 4 : b >= 0b11100000 ? 3 : b >= 0b11000000 ? 2 : 1;
  }

  write(s) {
    // convert to UTF-8 bytes
    s = unescape(encodeURIComponent(s));
    for (let i = 0; i < s.length; i++) {
      if (this.ix % 4 === 3) this.ix++; // skip alpha byte
      let b = s.charCodeAt(i);
      if (this.ix + this.utf8len(b) > this.px.length - 1) break; // enough space for all UTF-8 bytes?
      this.px[this.ix++] = b;
    }
    this.ctx.putImageData(this.img, 0, 0);
  }
}
