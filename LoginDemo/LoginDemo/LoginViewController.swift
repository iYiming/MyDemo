//
//  LoginViewController.swift
//  LoginDemo
//
//  Created by Yiming on 15/7/8.
//  Copyright (c) 2015年 Yiming. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func loginButtonClicked(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "showLoginViewController")
        
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
}
