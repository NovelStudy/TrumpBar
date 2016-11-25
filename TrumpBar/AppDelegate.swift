//
//  AppDelegate.swift
//  TrumpBar
//
//  Created by Michael Mattioli on 11/23/16.
//  Copyright © 2016 Michael Mattioli. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        // opt-in for allowing our instance of the NSTouchBar class to be customized throughout the app
        if ((NSClassFromString("NSTouchBar")) != nil) {
            if #available(OSX 10.12.1, *) {
                NSApplication.shared().isAutomaticCustomizeTouchBarMenuItemEnabled = true
            }
        }
        
    }
    
}


