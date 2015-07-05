//
//  ViewController.swift
//  Weibo
//
//  Created by Yiming on 15/7/4.
//  Copyright (c) 2015年 Yiming. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UIScrollViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var refreshView: RereshView!
    @IBOutlet weak var refreshViewTopLayoutConstraint: NSLayoutConstraint!
    var showBottomLayer:Bool = true
    var hiddenBottomLayer:Bool = true
    var showMiddleLayer:Bool = true
    var hiddenMiddleLayer:Bool = true
    var showTopLayer:Bool = true
    var hiddenTopLayer:Bool = true
    
    var refreshing = false
    
    var loadingAcitivityIndicatorView: UIActivityIndicatorView?
    var showFooterLoadingView:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        settingUI()//设置界面
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //设置界面
    func settingUI(){
        let screenWidth = CGRectGetWidth(UIScreen.mainScreen().bounds)
        let screenHeight = CGRectGetHeight(UIScreen.mainScreen().bounds)
        
        loadingAcitivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        loadingAcitivityIndicatorView?.hidesWhenStopped = true
        loadingAcitivityIndicatorView?.frame = CGRectMake((screenWidth - 20)/2.0,screenHeight - 40, 20, 20)
        self.view.addSubview(loadingAcitivityIndicatorView!)
        
        println("\(view.frame.size.height)")
    }
    
    /**
    添加size动画
    
    :param: layer   要添加动画的layer
    :param: size    动画到的size
    */
    func addSizeAnimation(layer: CALayer,size: CGSize){
        var springAnimation = POPSpringAnimation(propertyNamed: kPOPLayerSize)
        springAnimation.toValue = NSValue(CGSize: size);
        springAnimation.springBounciness = 18
        layer.pop_addAnimation(springAnimation, forKey: "layerSpringAnimation")
    }
    
    /**
    添加position动画
    
    :param: layer    要添加动画的layer
    :param: position 动画到的position
    */
    func addPositionAnimation(layer: CALayer,position: CGPoint){
        var springAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPosition)
        springAnimation.toValue = NSValue(CGPoint: position);
        springAnimation.springBounciness = 18
        layer.pop_addAnimation(springAnimation, forKey: "layerSpringAnimation")
    }
    
    //UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
    
    //UIScrollViewDelegate
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        var contentOffsetY = scrollView.contentOffset.y
        
        if contentOffsetY > 0{
            return
        }
        
        if contentOffsetY < -52{
            //println("scrollViewWillBeginDecelerating:\(scrollView.contentOffset.y)")
            refreshing = true
            
            refreshView.topLayer?.pop_removeAllAnimations()
            refreshView.middleLayer?.pop_removeAllAnimations()
            refreshView.bottomLayer?.pop_removeAllAnimations()
            
            scrollView.contentInset = UIEdgeInsetsMake(62.0, 0.0, 0.0, 0.0)
            
            refreshView.topLayer?.frame = CGRectMake(121, 0, 4, 4);
            refreshView.middleLayer?.frame = CGRectMake(98, 14, 4, 4);
            refreshView.bottomLayer?.frame = CGRectMake(75, 28, 4, 4);
            refreshView.textLayer?.opacity = 0
            
            refreshViewTopLayoutConstraint.constant = 20
            
            self.addPositionAnimation(self.refreshView.topLayer!,position: CGPointMake(121, 14));
            self.addPositionAnimation(self.refreshView.middleLayer!,position: CGPointMake(98, 14));
            self.addPositionAnimation(self.refreshView.bottomLayer!,position: CGPointMake(75, 14));
            
            
            let delayTime = dispatch_time(DISPATCH_TIME_NOW,
                Int64(1 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
                    self.refreshViewTopLayoutConstraint.constant = -52
                    }, completion: { (Bool) -> Void in
                        self.refreshing = false
                        self.refreshView.topLayer!.frame = CGRectMake(98, 0, 4, 4)
                        self.refreshView.middleLayer!.frame = CGRectMake(98, 14, 4, 4)
                        self.refreshView.bottomLayer!.frame = CGRectMake(98, 28, 4, 4)
                })
            }
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        println("减速完成")
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var contentOffsetY = scrollView.contentOffset.y
        
        if contentOffsetY <= 0 {
            if refreshing{
                return;
            }
            
            self.refreshView.hidden = false
            
            refreshViewTopLayoutConstraint.constant = -contentOffsetY - 52
            
            if contentOffsetY < -30{
                self.hiddenBottomLayer = true
                if showBottomLayer{
                    showBottomLayer = false
                    
                    self.addSizeAnimation(refreshView.bottomLayer!, size: CGSizeMake(50, 4));
                    
                    refreshView.bottomLayer?.backgroundColor = UIColor(red: 64/255.0, green: 64/255.0, blue: 64/255.0, alpha: 1.0).CGColor
                }
                
                if contentOffsetY < -46{
                    self.hiddenMiddleLayer = true
                    if showMiddleLayer{
                        showMiddleLayer = false
                        
                        self.addSizeAnimation(refreshView.middleLayer!, size: CGSizeMake(50, 4));
                        
                        refreshView.middleLayer?.backgroundColor = UIColor(red: 64/255.0, green: 64/255.0, blue: 64/255.0, alpha: 1.0).CGColor
                    }
                    
                    
                    if contentOffsetY < -62{
                        self.hiddenTopLayer = true
                        if showTopLayer{
                            showTopLayer = false
                            
                            self.addSizeAnimation(refreshView.topLayer!, size: CGSizeMake(50, 4));
                            
                            refreshView.topLayer?.backgroundColor = UIColor(red: 192/255.0, green: 47/255.0, blue: 46/255.0, alpha: 1.0).CGColor
                            
                            refreshView.middleLayer?.backgroundColor = UIColor(red: 192/255.0, green: 47/255.0, blue: 46/255.0, alpha: 1.0).CGColor
                            
                            refreshView.bottomLayer?.backgroundColor = UIColor(red: 192/255.0, green: 47/255.0, blue: 46/255.0, alpha: 1.0).CGColor
                            
                            refreshView.textLayer?.foregroundColor = UIColor(red: 192/255.0, green: 47/255.0, blue: 46/255.0, alpha: 1.0).CGColor
                        }
                    }else{
                        self.showTopLayer = true
                        if hiddenTopLayer{
                            hiddenTopLayer = false
                            
                            self.addSizeAnimation(refreshView.topLayer!, size: CGSizeMake(4, 4));
                            
                            refreshView.topLayer?.backgroundColor = UIColor(red: 200/255.0, green: 200/255.0, blue: 200/255.0, alpha: 1.0).CGColor
                            
                            refreshView.middleLayer?.backgroundColor = UIColor(red: 64/255.0, green: 64/255.0, blue: 64/255.0, alpha: 1.0).CGColor
                            
                            refreshView.bottomLayer?.backgroundColor = UIColor(red: 64/255.0, green: 64/255.0, blue: 64/255.0, alpha: 1.0).CGColor
                            
                            refreshView.textLayer?.foregroundColor = UIColor(red: 64/255.0, green: 64/255.0, blue: 64/255.0, alpha: 1.0).CGColor
                        }
                    }
                    
                }else{
                    self.showMiddleLayer = true
                    if hiddenMiddleLayer{
                        hiddenMiddleLayer = false
                        
                        self.addSizeAnimation(refreshView.middleLayer!, size: CGSizeMake(4, 4));
                        
                        refreshView.middleLayer?.backgroundColor = UIColor(red: 200/255.0, green: 200/255.0, blue: 200/255.0, alpha: 1.0).CGColor
                    }
                }
            }else{
                self.showBottomLayer = true
                if hiddenBottomLayer{
                    hiddenBottomLayer = false
                    
                    self.addSizeAnimation(refreshView.bottomLayer!, size: CGSizeMake(4, 4));
                    
                    refreshView.bottomLayer?.backgroundColor = UIColor(red: 200/255.0, green: 200/255.0, blue: 200/255.0, alpha: 1.0).CGColor
                }
            }
            
            refreshView.textLayer?.opacity = Float(-contentOffsetY/62.0)
            
            /*
            var alphaBasicAnimation = POPBasicAnimation(propertyNamed: kPOPLayerOpacity)
            alphaBasicAnimation.toValue = -contentOffsetY/62.0
            refreshView.textLayer?.pop_addAnimation(alphaBasicAnimation, forKey: "alphaBasicAnimation")
            */
        }else{
            
            self.refreshView.hidden = true
            
            let screenWidth = CGRectGetWidth(UIScreen.mainScreen().bounds)
        }
        
        println("scrollView.contentOffset.y:\(scrollView.contentOffset.y)")
        println("scrollView.frame.size.height:\(scrollView.frame.size.height)")
        println("height:\(scrollView.frame.size.height + scrollView.contentOffset.y)")
        println("scrollView.contentSize.height:\(scrollView.contentSize.height)")
        
        if scrollView.contentOffset.y + scrollView.frame.size.height < scrollView.contentSize.height{
            loadingAcitivityIndicatorView?.stopAnimating()
            tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            showFooterLoadingView = false
        }else{
            tableView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);
            loadingAcitivityIndicatorView?.startAnimating()
            showFooterLoadingView = true;
        }
    }
}

