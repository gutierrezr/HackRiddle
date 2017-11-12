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
var rectangle = UIImageView(image: UIImage(named: "rectangle.png"))
var breathingCircle = UIImageView(image: UIImage(named: "breathingCircle.png"))

var background = UIImageView(image: UIImage(named: "bambooBackground.jpg"))

var touchedCircle = false
var activeDotGame = false

var randomCorner = arc4random_uniform(4) + 1
var currentCorner = arc4random_uniform(4) + 1

var score = 0
var seconds = 300

var timer = Timer()

let label = UILabel(frame: CGRect(x: 0, y: 0, width: 600, height: 60))
var label2 = UILabel(frame: CGRect(x: 0, y: 0, width: 600, height: 60))

class ViewController: UIViewController {
    
    @IBOutlet var startButtonOutlet: UIButton!
    @IBAction func startButton(_ sender: UIButton) {
        startDotGame()
    }
    
    @IBOutlet var logoOutlet: UIImageView!
    
    var player:AVAudioPlayer = AVAudioPlayer()
    let altimeter = CMAltimeter() //initializes the Core Motion altitude sensor

    override func viewDidLoad() {
        super.viewDidLoad()
    
        do
        {
            let audioPath = Bundle.main.path(forResource: "ZenMusic", ofType: "mp3")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        }
        catch
        {
            //PROCESS ERROR
        }
        
        player.play()
        
        background.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        background.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2)
        view.addSubview(background)
        background.isHidden = false
        
        openCircle.frame = CGRect(x: 0, y: 0, width: 75, height: 75)
        openCircle.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2 + 200)
        view.addSubview(openCircle)
        openCircle.isHidden = true
        
        closedCircle.frame = CGRect(x: 0, y: 0, width: 75, height: 75)
        closedCircle.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2)
        view.addSubview(closedCircle)
        closedCircle.isHidden = true
        
        rectangle.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        rectangle.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2)
        view.addSubview(rectangle)
        self.view.bringSubview(toFront: rectangle)
        
        breathingCircle.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        breathingCircle.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2)
        view.addSubview(closedCircle)
        breathingCircle.isHidden = true
        
        label.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2 - 100)
        label.textAlignment = .center
        label.text = "Touch to getAway"
        self.view.addSubview(label)
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 40.0, weight: UIFont.Weight.black)
        // UIFont.boldSystemFont(ofSize: 37.0)
        
        label2.center = CGPoint(x: self.view.frame.width / 2, y: label2.frame.height)
        label2.textAlignment = .center
        label2.text = String(score)
        self.view.addSubview(label2)
        label2.isHidden = true
        label2.font = UIFont.systemFont(ofSize: 50.0, weight: UIFont.Weight.black)
        
        startButtonOutlet.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        startButtonOutlet.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2)
        
        
        //ALTITUDE
        if CMAltimeter.isRelativeAltitudeAvailable() {
            altimeter.startRelativeAltitudeUpdates(to: OperationQueue.current!, withHandler: { data, error in
                if !(error != nil) {
                    print(data!.relativeAltitude)
                }
            })
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        label.isHidden = true
        
        if (!activeDotGame) {
            startDotGame()
            return
        }
        
        if (activeDotGame) {
            print(score)
            
            if (score > 0) {
                label.isHidden = true
            } else {
                label.isHidden = false
            }
            
            
            if let touch = touches.first {
                let position = touch.location(in: view)
                let x_touch = position.x
                let y_touch = position.y
                
                let x_closed = closedCircle.center.x
                let y_closed = closedCircle.center.y
                let r_closed = closedCircle.frame.width / 2
                
                if (pow(x_touch - x_closed, 2) + pow(y_touch - y_closed, 2) <= pow(r_closed, 2)) {
                    print("I AM IN THE CIRCLE")
                    openCircle.isHidden = false
                    label.isHidden = true
                    randomizeCorner()
                    touchedCircle = true
                    
                }
            }
        }
        
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
            
            if (touchedCircle) {
                closedCircle.center = CGPoint(x: position.x, y: position.y)
            }
            
            if ((pow(x_touch - x_open, 2) + pow(y_touch - y_open, 2) <= pow(r_open, 2)) && touchedCircle == true) {
                print("YOU SCORED A POINT")
                score += 1
                
                // VIBRATE
                AudioServicesPlayAlertSound(UInt32(kSystemSoundID_Vibrate))
                
                label2.isHidden = false
                label2.text = String(score)
                
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
    

    func startDotGame() {
        activeDotGame = true
        rectangle.isHidden = true
        closedCircle.isHidden = false
        startButtonOutlet.isHidden = true
        label.text = "Touch and Drag"
    }
    
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}

