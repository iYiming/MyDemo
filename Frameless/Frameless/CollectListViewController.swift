//
//  CollectListViewController.swift
//  Frameless
//
//  Created by Yiming on 15/6/25.
//  Copyright (c) 2015年 Jay Stakelon. All rights reserved.
//

import UIKit

class CollectListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var delegate: ViewController?
    
    @IBOutlet weak var _closeButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var collectedListsArray: NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupNavigationBarAppearance()
        preInitParameter()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        collectedListsArray.writeToFile(collectedFilePath(), atomically: true)
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
    
    /**
    初始化参数
    */
    func preInitParameter(){
        var collectedArray = NSArray(contentsOfURL: NSURL(fileURLWithPath: collectedFilePath())!)
        
        if collectedArray?.count > 0{
            collectedListsArray = NSMutableArray(array: collectedArray!)
        }else{
            collectedListsArray = NSMutableArray()
        }
    }
    
    
    
    /**
    设置导航栏颜色
    */
    func setupNavigationBarAppearance() {
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        _closeButton.tintColor = UIColor.whiteColor()
        var font = UIFont(name: "ClearSans-Bold", size: 18)
        var textAttributes = [NSFontAttributeName: font!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    /**
    关闭
    
    :param: sender 关闭Item
    */
    @IBAction func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {
            self.delegate?.focusOnSearchBar()
        })
    }
    
    func collectedFilePath() -> String{
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! NSString
        return (documentsPath as String) + "/collect.dat"
    }
    
    //TableViewDataSource TableViewDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectedListsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("CollectCell") as! UITableViewCell
        
        var label = cell.viewWithTag(101) as! UILabel
        
        label.text = collectedListsArray[indexPath.row] as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var urlStr = collectedListsArray[indexPath.row] as! String
        self.dismissViewControllerAnimated(true, completion: {
            self.delegate?.scanSucceed(urlStr)
        })
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        collectedListsArray.removeObjectAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
}
