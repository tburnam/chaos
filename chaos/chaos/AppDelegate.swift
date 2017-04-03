//
//  AppDelegate.swift

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    
    

	let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
	let popover = NSPopover()
	var eventMonitor: EventMonitor?
    var spectreTask: Process?
    
    
    var icon = resizeImage(image: NSImage(named: "StatusBarButtonImage")!, w: 18, h:18)

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		
		if let button = statusItem.button {
			button.image = icon
			button.action = #selector(AppDelegate.togglePopover(_:))
		}
		
		let mainViewController = NSStoryboard(name: "Main", bundle: nil).instantiateController(withIdentifier: "ViewControllerId") as! ViewController
		
		popover.contentViewController = mainViewController
		eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [unowned self] event in
			if self.popover.isShown {
				self.closePopover(event)
			}
		}
		eventMonitor?.start()
        spectreTask = nil;
	}

	func applicationWillTerminate(_ aNotification: Notification) {
        if (spectreTask != nil) {
            spectreTask?.terminate();
        }
	}

	func togglePopover(_ sender: AnyObject?) {
		if popover.isShown {
			closePopover(sender)
		} else {
			showPopover(sender)
		}
	}
	
	func showPopover(_ sender: AnyObject?) {
		if let button = statusItem.button {
			popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
		}
		eventMonitor?.start()
	}
	
	func closePopover(_ sender: AnyObject?) {
		popover.performClose(sender)
		eventMonitor?.stop()
	}
    

}

func resizeImage(image: NSImage, w: Int, h: Int) -> NSImage {
    let destSize = NSMakeSize(CGFloat(w), CGFloat(h))
    let newImage = NSImage(size: destSize)
    newImage.lockFocus()
    image.draw(in: NSMakeRect(0, 0, destSize.width, destSize.height), from: NSMakeRect(0, 0, image.size.width, image.size.height), operation: NSCompositeSourceOver, fraction: CGFloat(1))
    newImage.unlockFocus()
    newImage.size = destSize
    return NSImage(data: newImage.tiffRepresentation!)!
}

