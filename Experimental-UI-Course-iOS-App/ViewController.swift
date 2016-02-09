//
//  ViewController.swift
//  Experimental-UI-Course-iOS-App
//
//  Created by Toni Antero Karttunen on 04/02/16.
//  Copyright © 2016 Toni Antero Karttunen. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.greenColor()
        
        for i in 0...21 {
            print(i)
            Alamofire.request(.POST, "http://172.20.10.2:5000")
                .responseData { response in
                    print(response.request)
                    print(response.response)
                    print(response.result)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

