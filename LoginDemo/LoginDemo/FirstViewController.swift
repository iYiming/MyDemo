//
//  ViewController.swift
//  LoginDemo
//
//  Created by Yiming on 15/7/8.
//  Copyright (c) 2015年 Yiming. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var switchControl: UISwitch!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        switchControl.on = NSUserDefaults.standardUserDefaults().boolForKey("showLoginViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func switchChanged(sender: AnyObject) {
        var switchControl = sender as! UISwitch
        
        NSUserDefaults.standardUserDefaults().setBool(switchControl.on, forKey: "showLoginViewController")
        
        if switchControl.on{
            var mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
              var loginNavViewController = mainStoryboard.instantiateViewControllerWithIdentifier("LoginNavViewController") as! UINavigationController
            self.tabBarController?.presentViewController(loginNavViewController, animated: true, completion: { () -> Void in
                
            })
        }
    }
}

