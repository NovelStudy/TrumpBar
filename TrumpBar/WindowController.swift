//
//  WindowController.swift
//  TrumpBar
//
//  Created by Michael Mattioli on 11/23/16.
//  Copyright © 2016 Michael Mattioli. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    @available(OSX 10.12.1, *)
    override func makeTouchBar() -> NSTouchBar? {
        guard let viewController = contentViewController as? ViewController else {
            return nil
        }
        return viewController.makeTouchBar()
    }
    
}
