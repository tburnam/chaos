//
//  ViewController.swift

import Cocoa
import Foundation

class ViewController: NSViewController {
    

    var chaosClicked = true;
    var moreViewsClicked = false;
    var frenzyModeOn = false;
    var mode9000ButtonOn = true;
    var statusTextOn = false;
    var proxyOn = false;

    var numberOfSitesCount = 0;
    
    // Main spectreTask
    var spectreTask : Process? = nil;
    
    // Background images for main button
    @IBOutlet weak var over9000Image3: NSImageView!
    @IBOutlet weak var over9000Image2: NSImageView!
    @IBOutlet weak var over9000Image: NSImageView!
    
    @IBOutlet weak var allSitesVisitedLabel: NSTextField!
    @IBOutlet weak var mode9000: NSButton!
    @IBOutlet var urlListView: NSTextView!
    @IBOutlet weak var textView: NSScrollView!
    
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var chaosButton: NSButton!
    
    @IBOutlet weak var numberOfSitesLabel: NSTextField!
    
    @IBOutlet weak var sitesVisitedLabel: NSTextField!
    
    @IBOutlet weak var openSourceLabel: NSTextField!
    
	override func viewDidLoad() {
		super.viewDidLoad()
        
        self.allSitesVisitedLabel.isHidden = true;
        self.textView.backgroundColor = NSColor(red:0.12, green:0.12, blue:0.18, alpha:1.0);
        self.urlListView.backgroundColor = NSColor(red:0.12, green:0.12, blue:0.18, alpha:1.0);
        
        self.over9000Image.isHidden = true;
        self.over9000Image2.isHidden = true;
        self.over9000Image3.isHidden = true;
        
        self.numberOfSitesLabel.isHidden = true;
        self.statusTextOn = false;
        self.sitesVisitedLabel.isHidden = true;
        self.textView.isHidden = true;
        
        
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor(red: 0.12, green: 0.12, blue: 0.18, alpha: 1.0).cgColor

        chaosButton.image = NSImage(named: "chaosButton2")
        
        
		// Do any additional setup after loading the view.
	}

	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}

    @IBAction func closeButtonClick(_ sender: Any) {
        NSApp.terminate(self)
    }
	@IBAction func closeButtonAction(_ sender: NSButton) {
		NSApp.terminate(self)
	}

    @IBAction func chaosButtonOnClick(_ sender: Any) {
        self.allSitesVisitedLabel.isHidden = true;
        self.launChaos()
    }
    

    
// TODO: This factory relies on a specific firebase setup. Will create issue to abstract
    @IBAction func proxyButtonClick(_ sender: Any) {
        
        print("Not yet supported");
        
//        // MARK: Enter your path to "proxyMachine.js" and "proxyOff.js"
//        if (!proxyOn) {
//            launchScript(scriptPath: "/usr/local/chaos/chaosDaemonScripts/proxyMachine.js")
//            proxyOn = !proxyOn
//        }
//        else {
//            launchScript(scriptPath: "/usr/local/chaos/chaosDaemonScripts/proxyOff.js")
//            proxyOn = !proxyOn
//        }
    }
    
    @IBAction func moreViewsClick(_ sender: Any) {
        if (moreViewsClicked) {
            hackSegueToLessViews();
        }
        else {
            hackSegueToMoreViews();
        }
        moreViewsClicked = !moreViewsClicked
    }

    
    
    @IBAction func activateFrenzyModeClick(_ sender: Any) {
        if (!self.chaosClicked) {
            
            // Expose and reset
            self.numberOfSitesCount = 0;
            self.chaosClicked = !chaosClicked
            self.chaosButton.image = NSImage(named: "chaosButton2")
            self.mode9000.isHidden = false;
            self.mode9000ButtonOn = true;
            
            // Hide
            self.over9000Image.isHidden = true;
            self.over9000Image2.isHidden = true;
            self.over9000Image3.isHidden = true;
            numberOfSitesLabel.isHidden = true;
            sitesVisitedLabel.isHidden = true;
            self.titleLabel.textColor = NSColor.green;
            self.titleLabel.stringValue = "chaos";
            
            // Close
            if (spectreTask != nil) {
                print("PROCESS ID: \(spectreTask?.processIdentifier)")
                spectreTask!.terminate();
            }
        }
        else {
            self.chaosClicked = !chaosClicked
            self.frenzyModeOn = true;
            self.chaosButton.image = NSImage(named: "chaosButtonPressed3")
            self.numberOfSitesLabel.isHidden = false;
            self.numberOfSitesLabel.textColor = NSColor.green
            self.sitesVisitedLabel.isHidden = false;
            self.mode9000.isHidden = true;
            self.mode9000ButtonOn = false;
            self.numberOfSitesCount = 0;
            self.numberOfSitesLabel.stringValue = "\(self.numberOfSitesCount)"
            self.urlListView.textStorage?.mutableString.setString("")
            
            launchScript(scriptPath: "/usr/local/chaos/chaosDaemonScripts/chaosFrenzy.js")
            
            
        }
        
    }
    

    // Increments sites visited value and updates UI (fire)
    func updateCounter() {
        self.numberOfSitesCount = self.numberOfSitesCount + 1;
        self.numberOfSitesLabel.stringValue = "\(self.numberOfSitesCount)"
        
        if (numberOfSitesCount > 8500) {
            self.allSitesVisitedLabel.isHidden = false;
            self.launChaos()
        }
        
        
        if (frenzyModeOn) {
            if (self.numberOfSitesCount == 3) {
                self.over9000Image.isHidden = false;
            }
            
            if (self.numberOfSitesCount > 9) {
                self.over9000Image2.isHidden = false;
            }
            
            if (self.numberOfSitesCount > 12) {
                self.chaosButton.image = NSImage(named: "chaosPressedVegeta")
                self.over9000Image3.isHidden = false;
                self.frenzyModeOn = false;
            }
        }
    }
    
    // FUNCTION - Manual segue to console view
    func hackSegueToMoreViews() {
        self.titleLabel.stringValue = "log"
        self.chaosButton.isHidden = true;
        self.textView.isHidden = false;
        
        if (statusTextOn) {
            self.sitesVisitedLabel.isHidden = true;
            self.numberOfSitesLabel.isHidden = true;
        }
        
        if (mode9000ButtonOn) {
            self.mode9000.isHidden = true;
        }
        
        if (frenzyModeOn) {
            if (self.numberOfSitesCount >= 3) {
                self.over9000Image.isHidden = false;
            }
            
            if (self.numberOfSitesCount > 9) {
                self.over9000Image2.isHidden = false;
            }
            
            if (self.numberOfSitesCount > 12) {
                self.over9000Image3.isHidden = false;
            }
        }
        
    }
    
    // FUNCTION - Go back to home screen from console view
    func hackSegueToLessViews() {
        self.chaosButton.isHidden = false;
        self.textView.isHidden = true;
        self.titleLabel.stringValue = "chaos"
        
        
        if (statusTextOn) {
            self.sitesVisitedLabel.isHidden = false;
            self.numberOfSitesLabel.isHidden = false;
        }
        
        if (mode9000ButtonOn) {
            self.mode9000.isHidden = false;
        }
        
        if (frenzyModeOn) {
            if (self.numberOfSitesCount >= 3) {
                self.over9000Image.isHidden = true;
            }
            
            if (self.numberOfSitesCount > 9) {
                self.over9000Image2.isHidden = true;
            }
            
            if (self.numberOfSitesCount > 12) {
                self.over9000Image3.isHidden = true;
            }
        }
    }
    
    func launChaos() {
        if (!self.chaosClicked) {
            
            // Expose and reset
            self.numberOfSitesCount = 0;
            self.frenzyModeOn = false;
            self.chaosClicked = !chaosClicked
            self.chaosButton.image = NSImage(named: "chaosButton2")
            self.mode9000.isHidden = false;
            self.mode9000ButtonOn = true;
            
            // Hide
            self.over9000Image.isHidden = true;
            self.over9000Image2.isHidden = true;
            self.over9000Image3.isHidden = true;
            numberOfSitesLabel.isHidden = true;
            self.statusTextOn = false;
            sitesVisitedLabel.isHidden = true;
            self.urlListView.textStorage?.mutableString.setString("")
            
            // Close
            if (spectreTask != nil) {
                print("PROCESS ID: \(spectreTask?.processIdentifier)")
                spectreTask!.terminate();
            }
        }
        else {
            // LAUNCH
            self.chaosClicked = !chaosClicked
            self.chaosButton.image = NSImage(named: "chaosButtonPressed3")
            self.numberOfSitesLabel.isHidden = false;
            self.statusTextOn = true;
            self.numberOfSitesLabel.textColor = NSColor.green
            self.sitesVisitedLabel.isHidden = false;
            self.mode9000.isHidden = true;
            self.mode9000ButtonOn = false;
            self.numberOfSitesCount = 0;
            self.numberOfSitesLabel.stringValue = "\(self.numberOfSitesCount)"
            
            launchScript(scriptPath: "/usr/local/chaos/chaosDaemonScripts/chaos.js")
            
            
        }
    }
    // FUNCTION - Launches node script given path to script
    func launchScript(scriptPath: String) {
        
        // Create a Task instance
        let task = Process()
        self.spectreTask = task;
        let delegate = NSApplication.shared().delegate as! AppDelegate
        delegate.spectreTask = task;
        
        // Set the task parameters
        // MARK: Put your NODE v.7.7.4 OR HIGHER path here
        task.launchPath = "/Users/tylerburnam/.nvm/versions/node/v7.7.4/bin/node"
        task.arguments = [scriptPath]
        
        // Create a Pipe and make the task
        // put all the output there
        let pipe = Pipe()
        task.standardOutput = pipe
        
        let outputHandle = pipe.fileHandleForReading
        outputHandle.waitForDataInBackgroundAndNotify()
        
        
        // When new data is available
        var dataAvailable : NSObjectProtocol!
        dataAvailable = NotificationCenter.default.addObserver(forName: NSNotification.Name.NSFileHandleDataAvailable,
                                                               object
        : outputHandle, queue: nil) {  notification -> Void in
            let data = pipe.fileHandleForReading.availableData
            if data.count > 0 {
                if let str = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    print(str)
                    if (str.hasPrefix("chaos_url:")) {
                        
                        print("Site visited: \(str)")
                        
                        var cleanString = str.replacingOccurrences(of: "chaos_url:http://www.", with: "")
                        
                        cleanString = cleanString.replacingOccurrences(of: "chaos_url:http://", with: "")
                        
                        
                        
                        self.urlListView.textStorage?.append(NSAttributedString(string: "\(self.numberOfSitesCount + 1): www.\(cleanString)"))
                        self.urlListView.font = NSFont(name: "Courier", size: 8)
                        self.urlListView.textColor = NSColor.lightGray;
                        self.updateCounter()
                    }
                }
                
                // DEBUG
                print("PROCESS ID BEFORE: \(task.processIdentifier)")
                outputHandle.waitForDataInBackgroundAndNotify()
            } else {
                NotificationCenter.default.removeObserver(dataAvailable)
            }
        }
        
        // When task has finished
        var dataReady : NSObjectProtocol!
        dataReady = NotificationCenter.default.addObserver(forName: Process.didTerminateNotification,
                                                           object: pipe.fileHandleForReading, queue: nil) { notification -> Void in
                                                            print("Task terminated!")
                                                            NotificationCenter.default.removeObserver(dataReady)
        }
        
        // Launch the task
        task.launch()
    }
}

