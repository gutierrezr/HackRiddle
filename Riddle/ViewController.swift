//
//
//  Created by Michael Strohmeier on 11/11/17.
//  Copyright © 2017 Michael Strohmeier. All rights reserved.
//


/*
 
 %$#%$#%$#$%%#%#%##%#%#%#%#%#%#%#$%#@$$@#%#@$@$@$$$$@$%#%#%#%
 WE WANT TO DO SOMETHING WHEN THE SCORE REACHES 10
 %$#^%$%^#$%^$@%^#^&%#^&$#%$&^#%$^#$#%^#$@%^$@^%#$@%#^$@#%^$&
 
 */

import UIKit
import AVFoundation
import CoreMotion //core motion to use the barometer


var closedCircle = UIImageView(image: UIImage(named: "closedCircle.png"))
var openCircle = UIImageView(image: UIImage(named: "openCircle.png"))
var touchedCircle = false

var randomCorner = arc4random_uniform(4) + 1
var currentCorner = arc4random_uniform(4) + 1

var score = 0

let label = UILabel(frame: CGRect(x: 0, y: 0, width: 600, height: 21))

class ViewController: UIViewController {
    @IBOutlet var logoOutlet: UIImageView!
    
    var player:AVAudioPlayer = AVAudioPlayer()
    var Inhale:AVAudioPlayer = AVAudioPlayer()
    var Exhale:AVAudioPlayer = AVAudioPlayer()
    
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
        closedCircle.center = CGPoint(x: self.view.frame.width / 2 - self.view.frame.width / 4, y: self.view.frame.height / 2 - self.view.frame.height / 4)
        view.addSubview(closedCircle)
        
        label.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2)
        label.textAlignment = .center
        label.text = "Touch the dot"
        self.view.addSubview(label)
        
        
        //ALTITUDE//
        //
        //  Created by Michael Strohmeier on 11/11/17.
        //  Copyright © 2017 Michael Strohmeier. All rights reserved.
        //
        
        
        /*
         
         %$#%$#%$#$%%#%#%##%#%#%#%#%#%#%#$%#@$$@#%#@$@$@$$$$@$%#%#%#%
         WE WANT TO DO SOMETHING WHEN THE SCORE REACHES 10
         %$#^%$%^#$%^$@%^#^&%#^&$#%$&^#%$^#$#%^#$@%^$@^%#$@%#^$@#%^$&
         
         */
        
        import UIKit
        import AVFoundation
        import CoreMotion //core motion to use the barometer
        
        
        var closedCircle = UIImageView(image: UIImage(named: "closedCircle.png"))
        var openCircle = UIImageView(image: UIImage(named: "openCircle.png"))
        var touchedCircle = false
        
        var randomCorner = arc4random_uniform(4) + 1
        var currentCorner = arc4random_uniform(4) + 1
        
        var score = 0
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 600, height: 21))
        
        class ViewController: UIViewController {
            @IBOutlet var logoOutlet: UIImageView!
            
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
                closedCircle.center = CGPoint(x: self.view.frame.width / 2 - self.view.frame.width / 4, y: self.view.frame.height / 2 - self.view.frame.height / 4)
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
                
                print(score)
                
                if (score > 0) {
                    label.isHidden = true
                } else {
                    label.isHidden = false
                }
                
                label.text = "click and drag to move the circle"
                
                openCircle.isHidden = false
                
                if let touch = touches.first {
                    let position = touch.location(in: view)
                    let x_touch = position.x
                    let y_touch = position.y
                    
                    let x_closed = closedCircle.center.x
                    let y_closed = closedCircle.center.y
                    let r_closed = closedCircle.frame.width / 2
                    
                    if (pow(x_touch - x_closed, 2) + pow(y_touch - y_closed, 2) <= pow(r_closed, 2)) {
                        print("I AM IN THE CIRCLE")
                        randomizeCorner()
                        touchedCircle = true
                    }
                }
                
                // IF we touched the first dot then
                // randomly show another dot
            }
            
            override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
                
                openCircle.isHidden = true
                touchedCircle = false
                //        label.isHidden = false
            }
            
            
            override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
                // if we are at the open circle do something
                if let touch = touches.first {
                    let position = touch.location(in: view)
                    let x_touch = position.x
                    let y_touch = position.y
                    
                    let x_open = openCircle.center.x
                    let y_open = openCircle.center.y
                    let r_open = openCircle.frame.width / 2
                    
                    if ((pow(x_touch - x_open, 2) + pow(y_touch - y_open, 2) <= pow(r_open, 2)) && touchedCircle == true) {
                        print("YOU SCORED A POINT")
                        score += 1
                        
                        currentCorner = randomCorner
                        
                        closedCircle.center = CGPoint(x: openCircle.center.x, y: openCircle.center.y)
                        openCircle.isHidden = true
                        touchedCircle = false
                    }
                }
            }
            
            
            
            override func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
                
            }
            
            
            func randomizeCorner() {
                
                repeat {
                    randomCorner = arc4random_uniform(4) + 1
                } while (currentCorner == randomCorner)
                
                switch randomCorner {
                case 1:
                    openCircle.center = CGPoint(x: self.view.frame.width / 2 - self.view.frame.width / 4, y: self.view.frame.height / 2 - self.view.frame.height / 4)
                case 2:
                    openCircle.center = CGPoint(x: self.view.frame.width / 2 + self.view.frame.width / 4, y: self.view.frame.height / 2 - self.view.frame.height / 4)
                case 3:
                    openCircle.center = CGPoint(x: self.view.frame.width / 2 - self.view.frame.width / 4, y: self.view.frame.height / 2 + self.view.frame.height / 4)
                case 4:
                    openCircle.center = CGPoint(x: self.view.frame.width / 2 + self.view.frame.width / 4, y: self.view.frame.height / 2 + self.view.frame.height / 4)
                default:
                    print("Something went wrong")
                }
            }
            
            
            
            
        }
        

        if CMAltimeter.isRelativeAltitudeAvailable() {
            altimeter.startRelativeAltitudeUpdates(to: OperationQueue.current!, withHandler: { data, error in
                if !(error != nil) {
                    print(data!.relativeAltitude)
                }
            })
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print(score)
        
        if (score > 0) {
            label.isHidden = true
        } else {
            label.isHidden = false
        }
        
        label.text = "click and drag to move the circle"
        
        openCircle.isHidden = false
        
        if let touch = touches.first {
            let position = touch.location(in: view)
            let x_touch = position.x
            let y_touch = position.y
            
            let x_closed = closedCircle.center.x
            let y_closed = closedCircle.center.y
            let r_closed = closedCircle.frame.width / 2
            
            if (pow(x_touch - x_closed, 2) + pow(y_touch - y_closed, 2) <= pow(r_closed, 2)) {
                print("I AM IN THE CIRCLE")
                randomizeCorner()
                touchedCircle = true
            }
        }
        
        // IF we touched the first dot then
        // randomly show another dot
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        openCircle.isHidden = true
        touchedCircle = false
//        label.isHidden = false
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // if we are at the open circle do something
        if let touch = touches.first {
            let position = touch.location(in: view)
            let x_touch = position.x
            let y_touch = position.y
            
            let x_open = openCircle.center.x
            let y_open = openCircle.center.y
            let r_open = openCircle.frame.width / 2
            
            if ((pow(x_touch - x_open, 2) + pow(y_touch - y_open, 2) <= pow(r_open, 2)) && touchedCircle == true) {
                print("YOU SCORED A POINT")
                score += 1
                
                currentCorner = randomCorner

                closedCircle.center = CGPoint(x: openCircle.center.x, y: openCircle.center.y)
                openCircle.isHidden = true
                touchedCircle = false
            }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    //INHALE AND EXHALE AUDIO
    
    /*
 
     do
     {
     let audioPath = Bundle.main.path(forResource: "INHALE", ofType: "mp3")
     try Inhale = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
     }
     catch
     {
     //PROCESS ERROR
     }
     
     
    do
    {
    let audioPath = Bundle.main.path(forResource: "EXHALE", ofType: "mp3")
    try Exhale = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
    }
    catch
    {
    //PROCESS ERROR
    }
    */
    
    
    
    

    //    func generateDot() {
    //
    //        let x_cord = arc4random_uniform(self.view.frame.width - button.size)
    //        let y_cord = arc4random_uniform(self.view.frame.height - dot.size)
    //    }
    
    
}

