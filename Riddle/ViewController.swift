//
//
//  Created by Michael Strohmeier on 11/11/17.
//  Copyright © 2017 Michael Strohmeier. All rights reserved.
//

import UIKit
import AVFoundation
import CoreMotion //core motion to use the barometer


let closedCircle = UIImageView(image: UIImage(named: "closedCircle.png")) // Please change me later
let openCircle = UIImageView(image: UIImage(named: "openCircle.png")) // Please change me later
var inCorrectArea = true

//var closedDot

let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))

class ViewController: UIViewController {
    
    var player:AVAudioPlayer = AVAudioPlayer()
    let altimeter = CMAltimeter() //initializes the Core Motion altitude sensor

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
        
        
        //ALTITUDE
        if CMAltimeter.isRelativeAltitudeAvailable() {
            altimeter.startRelativeAltitudeUpdates(to: OperationQueue.current!, withHandler: { data, error in
                if !(error != nil) {
                    print("Relative Altitude: \(data?.relativeAltitude)")
                    print("Relative Pressure: \(data?.pressure)")
                }
            })
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        label.isHidden = false
        label.text = "Move to open circle"
        
        if let touch = touches.first {
            let position = touch.location(in: view)
            print(position)
        }
        
        // IF we touched the first dot then
        // randomly show another dot
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (!inCorrectArea) {
            // Prompt user to touch screen again
        }
        label.isHidden = false
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // if we are at the open circle do something
        if let touch = touches.first {
            let position = touch.location(in: view)
            print(position)
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    //    func generateDot() {
    //
    //        let x_cord = arc4random_uniform(self.view.frame.width - button.size)
    //        let y_cord = arc4random_uniform(self.view.frame.height - dot.size)
    //    }
    
    
}

