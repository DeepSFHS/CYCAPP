//
//  ViewFour.swift
//  MKMapViewSample
//
//  Created by Deepankar Joshi on 6/4/17.
//  Copyright © 2017 koogawa. All rights reserved.
//

import UIKit
import Alamofire

class ViewFour: UIViewController {
    var comment = ""
    
    
    @IBOutlet weak var text: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func wc(_ sender: Any) {
        comment = text.text
        print (comment)
        var usercomment:[String:String] = ["userComment":comment]
        print (usercomment)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
