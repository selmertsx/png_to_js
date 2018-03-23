var fs = require('fs'),
    PNG = require('pngjs').PNG;

fs.createReadStream('hoge.png')
  .pipe(new PNG({
    filterType: 0
  }))
  .on('parsed', function() {
    console.log(this.data);
  });

