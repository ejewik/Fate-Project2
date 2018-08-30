//
//  ViewController.swift
//  Fate
//
//  Created by Emily Jewik on 8/26/18.
//  Copyright © 2018 Emily Jewik. All rights reserved.
//

import UIKit
import AVFoundation

class TextViewController: UIViewController {
    
    var counter = 0
    let textArray: [String] = [ "One shot. Two shots." , "The sounds echo through the halls." ]
    var player: AVAudioPlayer?
    
    @IBOutlet weak var storyTextView: UITextView!
    //change
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.navigationController?.isNavigationBarHidden = false 
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        //tap.delegate = self // This is not required
        view.addGestureRecognizer(tap)
        
        playSound(soundName: "PenitentFeelings", extensionString: "mp3")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {

//        var currentText = textArray[counter]
//
//        let middle = currentText.index(currentText.startIndex, offsetBy: currentText.characters.count / 2)
//
//        for index in letters.characters.indices {
//
//            // to traverse to half the length of string
//            if index == middle { break }  // s, t, r
//
//            print(textArray[counter][index])  // s, t, r, i, n, g
//        }
//
        
        
        
       
         var iter = textArray[counter].makeIterator()          // Swift 4
         var characterCounter = textArray[counter].count
//        while let c = iter.next() {
//            print(c)
//        }

        //let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: <#T##(Timer) -> Void#>)
       
//        let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
//            let c = iter.next()
//           // storyTextView.text.append
//            }})
        
        let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            
            if let c = iter.next()
            {
                
            self.storyTextView.text = "\(self.storyTextView.text!)\(c)"
            print(c)
                
            }
            //print(self.storyTextView.text)
            })
        
//        if counter < textArray.count {
//            storyTextView.text = textArray[counter] //
//            storyTextView.animate(newText: storyTextView.text ?? textArray[counter], characterDelay: 0.1)
//        counter += 1
//
//
//        }
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
