//
//  ViewController.swift
//  Fate
//
//  Created by Emily Jewik on 8/26/18.
//  Copyright © 2018 Emily Jewik. All rights reserved.
//

import UIKit
import AVFoundation

class TextViewController: UIViewController , UIGestureRecognizerDelegate{
    
    //read text data
    
//    let file = "file.txt" //this is the file. we will write to and read from it
//
//    let text = "some text" //just a text
//
//    let path = Bundle.main.path(forResource: "data", ofType: "txt") // file path for file "data.txt"
//    var text = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)!
    
    
    
    
   
    
    var counter = 0
    var textArray: [String] = []
    var player: AVAudioPlayer?
    var isTapEnabled = true
    
    @IBOutlet weak var storyTextView: UITextView!
    //change
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let data = try Data(contentsOf:url)
//        let attibutedString = try NSAttributedString(data: data, documentAttributes: nil)
//        let fullText = attibutedString.string
//        let readings = fullText.components(separatedBy: CharacterSet.newlines)
//        for line in readings { // do not use ugly C-style loops in Swift
//            let clientData = line.components(separatedBy: "\t")
//            dictClients["FirstName"] = "\(clientData)"
//            arrayClients.append(dictClients)
        
//        if let path = Bundle.main.path(forResource: "TestStory", ofType: "rtf") {
//            do {
//                let data = try String(contentsOfFile: path, encoding: .)
        
//                let attibutedString = try NSAttributedString(data: data, documentAttributes: nil)
//                        let fullText = attibutedString.string
//                        let readings = fullText.components(separatedBy: CharacterSet.newlines)
//                        for line in readings { // do not use ugly C-style loops in Swift
//                            let clientData = line.components(separatedBy: "\t")
//                            dictClients["FirstName"] = "\(clientData)"
//                            arrayClients.append(dictClients)
//                }
                
                
//                textArray = data.components(separatedBy: "(new)")
//                //textArray = myStrings.(separator: "(new)")
//            } catch {
//                print(error)
//                print("not working")
//            }
//        }
        
        if let rtfPath = Bundle.main.url(forResource: "TestStory", withExtension: "rtf") {
            do {
                let attributedStringWithRtf: NSAttributedString = try NSAttributedString(url: rtfPath, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.rtf], documentAttributes: nil)
                
                let textString = attributedStringWithRtf.string.replacingOccurrences(of: "\\n", with: "\n")
                textArray = textString.components(separatedBy: "(new)")
                //self.storyTextView.attributedText = attributedStringWithRtf
            } catch let error {
                print("Got an error \(error)")
            }
        }
        
        
       let textViewRecognizer = UITapGestureRecognizer()
        //problems: tap gesture recognizer not de-enabling
        //text view does not respond to tap
        //also music still plays when back pressed
        
       textViewRecognizer.addTarget(self, action: #selector(tappedTextView(_:)))
        
        //tap.delegate = self // This is not required
        
        
        storyTextView.addGestureRecognizer(textViewRecognizer)
        
        textViewRecognizer.delegate = self
        playSound(soundName: "PenitentFeelings", extensionString: "mp3")
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if isTapEnabled  {
            return true
        }
        else {
            return false
        }
    }
    
    
    
    
    @objc func tappedTextView(_ sender: UITapGestureRecognizer) {
 
        isTapEnabled = true
        var c : Character? = nil
        
        if counter < textArray.count {
        isTapEnabled = false
         storyTextView.text = ""
         var iter = textArray[counter].makeIterator()          // Swift 4
         var characterCounter = textArray[counter].count

        let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            // why does it skip over timer once?
            if let c = iter.next()
            {
            
            
            
                self.isTapEnabled = false
                
            self.storyTextView.text = "\(self.storyTextView.text!)\(c)" //hits istapenabled, then character, then counter, then istapenabled, why not gesturerecognizershouldbegin?
            print(c)
                
                
            }
            else {
                self.isTapEnabled = true
            }
           // self.isTapEnabled = true
            
//            if c == nil { //but need current iter value...
//            self.isTapEnabled = true // c error: outside of scope?
//            //}
            
            })
        
        
          
        counter += 1
        }

        
        isTapEnabled = false
        
    }
   
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue)
    {
        
    }


}

extension TextViewController {
    
    
    func playSound( soundName: String , extensionString: String ) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: extensionString) else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

//extension UITextView {
//
//    func animate(newText: String, characterDelay: TimeInterval) {
//
//        DispatchQueue.main.sync {
//
//            self.text = ""
//
//            for (index, character) in newText.characters.enumerated() {
//
//                DispatchQueue.main.asyncAfter(deadline: .now() + characterDelay * Double(index)) {
//                    self.text?.append(character) // animation function is running at same time
//
//                    print("characterDelay \(characterDelay) index \(index)")
//                }
//            }
//        }
//    }

//    func animate(newText: String, characterDelay: TimeInterval) {
//        var a: Int?
//
//        let group = DispatchGroup()
//        group.enter()
//
//        DispatchQueue.main.async {
//            a = 1
//
//            self.text = ""
//
//            for (index, character) in newText.characters.enumerated() {
//
//                DispatchQueue.main.asyncAfter(deadline: .now() + characterDelay * Double(index)) {
//                    self.text?.append(character) // animation function is running at same time
//
//                    print("characterDelay \(characterDelay) index \(index)")
//                }
//            }
//
//            group.leave()
//        }
//
//        // does not wait. But the code in notify() gets run
//        // after enter() and leave() calls are balanced
//
//        group.notify(queue: .main) {
//            print("done")
//        }
//    }
//
//
//
//}

//    func animate(newText: String, characterDelay: TimeInterval) {
//        var a: Int?
//
//        let group = DispatchGroup()
//        group.enter()
//
//        // avoid deadlocks by not using .main queue here
//        DispatchQueue.global {
//            a = 1
//            group.leave()
//        }
//
//        // wait ...
//        group.wait()
//
//        // ... and return as soon as "a" has a value
//        return a
//}

//func animate(newText: String, characterDelay: TimeInterval) {
//    var a: Int?
//
//    let group = DispatchGroup()
//    group.enter()
//
//    DispatchQueue.main.async {
//        a = 1
//
//        self.text = ""
//
//        for (index, character) in newText.characters.enumerated() {
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + characterDelay * Double(index)) {
//                self.text?.append(character) // animation function is running at same time
//
//                print("characterDelay \(characterDelay) index \(index)")
//            }
//        }
//
//        group.leave()
//    }
//
//    // does not wait. But the code in notify() gets run
//    // after enter() and leave() calls are balanced
//
//    group.notify(queue: .main) {
//        print(a)
//    }
//}
//

//func myFunction() -> Int? {
//    var a: Int?
//
//    let group = DispatchGroup()
//    group.enter()
//
//    // avoid deadlocks by not using .main queue here
//    DispatchQueue.global(attributes: .qosDefault).async {
//        a = 1
//        group.leave()
//    }
//
//    // wait ...
//    group.wait()
//
//    // ... and return as soon as "a" has a value
//    return a
//}
