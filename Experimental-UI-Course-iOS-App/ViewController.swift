//
//  ViewController.swift
//  Experimental-UI-Course-iOS-App
//
//  Created by Toni Antero Karttunen on 04/02/16.
//  Copyright © 2016 Toni Antero Karttunen. All rights reserved.
//

import UIKit
import CoreMotion
import Alamofire

class ViewController: UIViewController {
    let motionManager = CMMotionManager()
    var resultView : UIView? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.resultView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.resultView!.alpha = 1.0
        self.resultView!.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        self.resultView!.backgroundColor = UIColor.redColor()
        self.view.addSubview(self.resultView!)
        
        self.startMotionUpdates()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func sendUpdateToServer() {
        let serverUrl = "http://172.20.10.2:5000"
        Alamofire.request(.POST, serverUrl)
            .responseData { response in
                print(response.result)
        }
    }

    func startMotionUpdates() {
        motionManager.deviceMotionUpdateInterval = 0.05
        
        let motionUpdateQueue = NSOperationQueue()
        motionManager.startDeviceMotionUpdatesToQueue(motionUpdateQueue, withHandler: {
            [weak self] deviceMotion, error in
            
            // Motion processing
            let limit = 2.0
            let total = fabs((deviceMotion?.userAcceleration.x)!) + fabs((deviceMotion?.userAcceleration.y)!) + fabs((deviceMotion?.userAcceleration.z)!)
            
            // If gyro/accelerometer value is higher than threshold value,
            // update UI and send a POST request to the web server
            if total > limit {
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    self?.processMotionUpdate(total)
                })
            }
        });
    }
    
    func stopMotionUpdates() {
        motionManager.stopDeviceMotionUpdates()
    }
    
    func processMotionUpdate(totalMotionValue: Double) {
        print(totalMotionValue)
        // Update UI
        let alpha = totalMotionValue / 5.0 < 1.0 ? totalMotionValue / 5.0 : 1.0
        self.resultView!.alpha = CGFloat(alpha)
        // Send a POST request to server
        self.sendUpdateToServer()
    }
}

