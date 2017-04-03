var admin = require("firebase-admin");

var serviceAccount = require("./chaos-e3f81-firebase-adminsdk-pr6ql-c0a7dda093.json");

admin.initializeApp({
	credential: admin.credential.cert(serviceAccount),
	databaseURL: "https://chaos-e3f81.firebaseio.com"
});


var i = 0;
admin.database().ref('/proxies').once('value').then((snapshot) => {
	var ips = []
	var ports = []
	snapshot.forEach((childSnapshot) => {
		var childKey = childSnapshot.key;
		var childData = childSnapshot.val();
		ips.push(childKey)
		ports.push(childData.port)
	});
	var ipIndex = ips[getRandomInt(0, ips.length)]
	var portIndex = ports[getRandomInt(0, ips.length)]
	
	console.log(ipIndex.replace(/-/g, "."))

	var exec = require('child_process').exec;
	var child = exec('networksetup -setsecurewebproxy "Wi-Fi" ' + 	ipIndex.replace(/-/g, ".") + " " + portIndex, function(error, stdout, stderr) {
		if (error) console.log(error);
		process.stdout.write(stdout);
		process.stderr.write(stderr);
	});
	
	var child2 = exec('networksetup -setwebproxy "Wi-Fi" ' + 	ipIndex.replace(/-/g, ".") + " " + portIndex, function(error, stdout, stderr) {
		if (error) console.log(error);
		process.stdout.write(stdout);
		process.stderr.write(stderr);
	});
});

function getRandomInt(min, max) {
	return Math.floor(Math.random() * (max - min + 1)) + min;
}




