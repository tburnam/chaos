"use strict";

const phantom = require('phantom');


(async function() {

    var fs = require('fs');
    var urls = fs.readFileSync('/usr/local/chaos/sites.txt').toString().split("\n");
    shuffle(urls)

    // const urls = [
    //     'https://stackoverflow.com/',
    //     'http://google.com/',
    //     'http://yahoo.com/'
    // ]

    const instance = await phantom.create(['--ignore-ssl-errors=yes', '--load-images=false'], {
        phantomPath: '/usr/local/bin/spectrejs'
    })
    const page = await instance.createPage();

    let broswerSetting = await setBrowser(page);


    // EARLY OUT
    process.stdin.resume();

    function exitHandler(options, err) {
        if (options.cleanup) {
            console.log('cleaning');
        }
        if (err) {
            console.log(err.stack);
        }

        if (options.exit) {
            instance.exit()
            process.exit();
        }
    }

    process.on('exit', exitHandler.bind(null, {
        cleanup: true
    }));
    process.on('SIGINT', exitHandler.bind(null, {
        exit: true
    }));
    process.on('uncaughtException', exitHandler.bind(null, {
        exit: true
    }));


    // Loop through random URLs
    for (var url in urls) {
        var status = await page.open(urls[url]);

        // Send stdout the key
        console.log("chaos_url:" + urls[url])
    }

    // Clean up after URLs exhausted
    await instance.exit();
}());

// Set browser settings
async function setBrowser(page) {

    // ----------------------------- USER AGENT
    const userAgents = ["Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36",
        "Mozilla/5.0 (Macintosh; Int Mac OS X 10_12_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36",
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11; rv:33.0) Gecko/20100101 Firefox/33.0",
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36"
    ]
    var userAgent = userAgents[getRandomInt(0, 4)]
    await page.setting('userAgent', userAgent)


    // ----------------------------- VIEW PORT
    var width = getRandomInt(650, 1300);
    var height = getRandomInt(600, 1250);
    await page.property('viewportSize', {
        width: width,
        height: height
    });

    // ----------------------------- LISTENERS
    /*
      onAlert = onConfirm = onPrompt in order to
       slow down pop-up exiting (confirmed method
       of bot detection)
    */
    await page.property('onAlert', function() {
        for (var i = 0; i < 1e8; i++) {}
        return null
    });
    await page.property('onConfirm', function() {
        for (var i = 0; i < 1e8; i++) {}
        return null
    });
    await page.property('onPrompt', function() {
        for (var i = 0; i < 1e8; i++) {}
        return null
    });

    return true;
}

function shuffle(a) {
    var x, y, z;
    for (z = a.length; z; z--) {
        x = Math.floor(Math.random() * z);
        y = a[z - 1];
        a[z - 1] = a[x];
        a[x] = y;
    }
}

function sleep(milliseconds) {
    var start = new Date().getTime();
    for (var i = 0; i < 1e7; i++) {
        if ((new Date().getTime() - start) > milliseconds) {
            break;
        }
    }
}
//
function getRandomInt(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}
