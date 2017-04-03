var exec = require('child_process').exec;
var child = exec('networksetup -setwebproxystate Wi-Fi off', function(error, stdout, stderr) {
	if (error) console.log(error);
	process.stdout.write(stdout);
	process.stderr.write(stderr);
});
var child = exec('networksetup -setsecurewebproxystate Wi-Fi off', function(error, stdout, stderr) {
	if (error) console.log(error);
	process.stdout.write(stdout);
	process.stderr.write(stderr);
});