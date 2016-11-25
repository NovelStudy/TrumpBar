/*
 *
 * Written by Michael Mattioli
 *
 */

import Cocoa
import AppKit

fileprivate extension NSTouchBarCustomizationIdentifier {
    
    // NSTouchBarCustomizationIdentifier objects for the instances of NSTouchBar that will be made
    static let mainBar = NSTouchBarCustomizationIdentifier("com.donaldjtrump.TrumpBar.mainBar")
    static let complimentsBar = NSTouchBarCustomizationIdentifier("com.donaldjtrump.TrumpBar.complimentsBar")
    static let conversationalBar = NSTouchBarCustomizationIdentifier("com.donaldjtrump.TrumpBar.conversationalBar")
    static let greetingsBar = NSTouchBarCustomizationIdentifier("com.donaldjtrump.TrumpBar.greetingsBar")
    
}

fileprivate extension NSTouchBarItemIdentifier {
    
    // main bar popover items
    static let complimentsPopover = NSTouchBarItemIdentifier("com.donaldjtrump.TrumpBar.mainBar.complimentsPopover")
    static let greetingsPopover = NSTouchBarItemIdentifier("com.donaldjtrump.TrumpBar.mainBar.greetingsPopover")
    static let converationalPopover = NSTouchBarItemIdentifier("com.donaldjtrump.TrumpBar.mainBar.converationalPopover")
    
    // compliments buttons
    static let congratulationsButton = NSTouchBarItemIdentifier("com.donaldjtrump.TrumpBar.complimentsBar.congratulationsButton")
    static let fantasticButton = NSTouchBarItemIdentifier("com.donaldjtrump.TrumpBar.complimentsBar.fantasticButton")
    static let reallyBeautifulButton = NSTouchBarItemIdentifier("com.donaldjtrump.TrumpBar.complimentsBar.reallyBeautifulButton")
    
    // conversational buttons
    static let haveAGoodTimeButton = NSTouchBarItemIdentifier("com.donaldjtrump.TrumpBar.greetingsBar.converationalButton.haveAGoodTimeButton")
    static let letEmTalkButton = NSTouchBarItemIdentifier("com.donaldjtrump.TrumpBar.greetingsBar.converationalButton.letEmTalkButton")
    static let yesMamButton = NSTouchBarItemIdentifier("com.donaldjtrump.TrumpBar.greetingsBar.converationalButton.yesMamButton")
    
    // greetings buttons
    static let goodEveningButton = NSTouchBarItemIdentifier("com.donaldjtrump.TrumpBar.greetingsBar.congratulationsButton.goodEveningButton")
    static let howAreYouButton = NSTouchBarItemIdentifier("com.donaldjtrump.TrumpBar.greetingsBar.congratulationsButton.howAreYouButton")
    static let watchingYouButton = NSTouchBarItemIdentifier("com.donaldjtrump.TrumpBar.greetingsBar.congratulationsButton.watchingYouButton")
    
}

class ViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func controlSound(sender: NSButton) {
        if sender.sound!.isPlaying {
            sender.sound!.stop()
        } else {
            sender.sound!.play()
        }
    }
    
}

@available(OSX 10.12.1, *)
extension ViewController : NSTouchBarDelegate {
    
    override func makeTouchBar() -> NSTouchBar? {
        let mainBar = NSTouchBar()
        mainBar.delegate = self
        mainBar.customizationIdentifier = NSTouchBarCustomizationIdentifier.mainBar
        mainBar.defaultItemIdentifiers = [.complimentsPopover, .converationalPopover, .greetingsPopover]
        return mainBar
    }
    
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItemIdentifier) -> NSTouchBarItem? {
        
        switch identifier {
            
        // setup the secondary NSTouchBar instances
        case NSTouchBarItemIdentifier.complimentsPopover,
             NSTouchBarItemIdentifier.converationalPopover,
             NSTouchBarItemIdentifier.greetingsPopover:
            
            // make the NSPopoverTouchBarItem
            let item = NSPopoverTouchBarItem(identifier: identifier)
            
            // make the secondary NSTouchBar
            let secondaryTouchBar = NSTouchBar()
            secondaryTouchBar.delegate = self
            
            // configure the NSPopoverTouchBarItem instances
            switch identifier {
            case NSTouchBarItemIdentifier.complimentsPopover:
                item.customizationLabel = "Compliments"
                item.collapsedRepresentationLabel = "Compliments"
                secondaryTouchBar.defaultItemIdentifiers = [.congratulationsButton, .fantasticButton, .reallyBeautifulButton]
            case NSTouchBarItemIdentifier.converationalPopover:
                item.customizationLabel = "Conversational"
                item.collapsedRepresentationLabel = "Conversational"
                secondaryTouchBar.defaultItemIdentifiers = [.haveAGoodTimeButton, .letEmTalkButton, .yesMamButton]
            case NSTouchBarItemIdentifier.greetingsPopover:
                item.customizationLabel = "Greetings"
                item.collapsedRepresentationLabel = "Greetings"
                secondaryTouchBar.defaultItemIdentifiers = [.goodEveningButton, .howAreYouButton, .watchingYouButton]
            default:
                return nil
            }
            
            // set the secondary NSTouchBar and return the NSTouchBarItem
            item.pressAndHoldTouchBar = secondaryTouchBar
            item.popoverTouchBar = secondaryTouchBar
            return item
        
        // setup the buttons for each secondary NSTouchBar instance
        case NSTouchBarItemIdentifier.congratulationsButton,
             NSTouchBarItemIdentifier.fantasticButton,
             NSTouchBarItemIdentifier.reallyBeautifulButton,
             NSTouchBarItemIdentifier.haveAGoodTimeButton,
             NSTouchBarItemIdentifier.letEmTalkButton,
             NSTouchBarItemIdentifier.yesMamButton,
             NSTouchBarItemIdentifier.goodEveningButton,
             NSTouchBarItemIdentifier.howAreYouButton,
             NSTouchBarItemIdentifier.watchingYouButton:
            
            // make the NSCustomTouchBarItem
            let item = NSCustomTouchBarItem(identifier: identifier)
            let itemButton = NSButton(title: "", target: self, action: #selector(controlSound))
            var soundFile: String
            
            // set the button's title and lookup the associated sound file
            switch identifier {
            case NSTouchBarItemIdentifier.congratulationsButton:
                itemButton.title = "Congratulations!"
                soundFile = Bundle.main.path(forResource: "Congratulations", ofType: "mp3")!
            case NSTouchBarItemIdentifier.fantasticButton:
                itemButton.title = "Fantastic!"
                soundFile = Bundle.main.path(forResource: "Fantastic", ofType: "mp3")!
            case NSTouchBarItemIdentifier.reallyBeautifulButton:
                itemButton.title = "You're really beautiful"
                soundFile = Bundle.main.path(forResource: "Really_beautiful", ofType: "mp3")!
            case NSTouchBarItemIdentifier.haveAGoodTimeButton:
                itemButton.title = "Have a good time"
                soundFile = Bundle.main.path(forResource: "Have_a_good_time", ofType: "mp3")!
            case NSTouchBarItemIdentifier.letEmTalkButton:
                itemButton.title = "Let 'em talk"
                soundFile = Bundle.main.path(forResource: "Let_em_talk", ofType: "mp3")!
            case NSTouchBarItemIdentifier.yesMamButton:
                itemButton.title = "Yes mam"
                soundFile = Bundle.main.path(forResource: "Yes_mam", ofType: "mp3")!
            case NSTouchBarItemIdentifier.goodEveningButton:
                itemButton.title = "Good evening"
                soundFile = Bundle.main.path(forResource: "Good_evening", ofType: "mp3")!
            case NSTouchBarItemIdentifier.howAreYouButton:
                itemButton.title = "How are you?"
                soundFile = Bundle.main.path(forResource: "How_are_you", ofType: "mp3")!
            case NSTouchBarItemIdentifier.watchingYouButton:
                itemButton.title = "Watching you"
                soundFile = Bundle.main.path(forResource: "Watching_you", ofType: "mp3")!
            default:
                return nil
            }
            
            // set the button's sound and color
            itemButton.sound = NSSound(contentsOfFile: soundFile, byReference: false)
            itemButton.bezelColor = NSColor.red
            
            // set the NSTouchBarItem's view and return it
            item.view = itemButton
            return item
            
        default:
            return nil
        }
        
    }
    
}
