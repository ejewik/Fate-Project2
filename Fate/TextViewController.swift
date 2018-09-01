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
    
    var counter = 0
    let textArray: [String] = [ "\n\n\n     One shot. Two shots. \n     The blasts echo off of the walls." , "\n\n\n     Why am I running?" ]
    var player: AVAudioPlayer?
    var isTapEnabled = true
    
    @IBOutlet weak var storyTextView: UITextView!
    //change
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
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

        
        if counter < textArray.count {
     //   isTapEnabled = false
         storyTextView.text = ""
         var iter = textArray[counter].makeIterator()          // Swift 4
         var characterCounter = textArray[counter].count

        let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            // why does it skip over timer once?
            if let c = iter.next()
            {
                
            self.storyTextView.text = "\(self.storyTextView.text!)\(c)" //hits istapenabled, then character, then counter, then istapenabled, why not gesturerecognizershouldbegin?
            print(c)
                
            }
           // self.isTapEnabled = true
            
            if iter. == nil { //but need current iter value...
                self.isTapEnabled = true
            }
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
