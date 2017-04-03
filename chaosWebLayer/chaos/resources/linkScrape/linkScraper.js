var page = require('webpage').create();
var fs = require('fs');
var system = require('system');
var args = system.args;

var path = 'pages/page' + args[1] + '.txt';

page.open('http://5000best.com/websites/' + args[1], function(status) {
	page.includeJs("http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js", function() {
		var content = page.evaluate(function() {
			return $('a')
				.map(function() {
					return this.href;})
				.get()
				.join();
		});
		fs.write(path, content, 'w');
		phantom.exit()
	});
});