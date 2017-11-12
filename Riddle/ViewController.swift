//
//
//  Created by Michael Strohmeier on 11/11/17.
//  Copyright © 2017 Michael Strohmeier. All rights reserved.
//

import UIKit
import AVFoundation

//Library for the accelerometer
import CoreMotion

class ViewController: UIViewController {
    
    let altimeter = CMAltimeter()

class ViewController: UIViewController {
    
    var player:AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        do
        {
            let audioPath = Bundle.main.path(forResource: "Music", ofType: "mp3")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        }
        catch
        {
            //PROCESS ERROR
        }
        
        player.play()
        
        openCircle.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        openCircle.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2 + 200)
        view.addSubview(openCircle)
        
        closedCircle.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        closedCircle.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2 - 200)
        view.addSubview(closedCircle)
        
        label.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2)
        label.textAlignment = .center
        label.text = "Touch the dot"
        self.view.addSubview(label)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    


    
}

