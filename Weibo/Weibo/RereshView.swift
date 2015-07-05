//
//  RereshView.swift
//  Weibo
//
//  Created by Yiming on 15/7/4.
//  Copyright (c) 2015年 Yiming. All rights reserved.
//

import UIKit

@IBDesignable class RereshView: UIView {
    var topLayer: CALayer?
    var middleLayer: CALayer?
    var bottomLayer: CALayer?
    var textLayer: CATextLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()//设置
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
        
        setup()//设置
    }

    /**
    设置
    */
    func setup(){
        topLayer = CALayer()
        topLayer!.backgroundColor = UIColor(red: 200/255.0, green: 200/255.0, blue: 200/255.0, alpha: 1.0).CGColor
        topLayer!.frame = CGRectMake(98, 0, 4, 4)
        topLayer!.cornerRadius = 2
        self.layer.addSublayer(topLayer)
        
        
        middleLayer = CALayer()
        middleLayer!.backgroundColor = UIColor(red: 200/255.0, green: 200/255.0, blue: 200/255.0, alpha: 1.0).CGColor
        middleLayer!.frame = CGRectMake(98, 14, 4, 4)
        middleLayer!.cornerRadius = 2
        self.layer.addSublayer(middleLayer)
        
        bottomLayer = CALayer()
        bottomLayer!.backgroundColor = UIColor(red: 200/255.0, green: 200/255.0, blue: 200/255.0, alpha: 1.0).CGColor
        bottomLayer!.frame = CGRectMake(98, 28, 4, 4)
        bottomLayer!.cornerRadius = 2
        self.layer.addSublayer(bottomLayer)
        
        textLayer = CATextLayer()
        textLayer!.foregroundColor = UIColor(red: 64/255.0, green: 64/255.0, blue: 64/255.0, alpha: 1.0).CGColor
        textLayer!.fontSize = 10
        textLayer!.contentsScale = UIScreen.mainScreen().scale
        textLayer!.string = "REFRESH"
        textLayer!.opacity = 0
        textLayer!.frame = CGRectMake(75, 62, 50, 20)
        self.layer.addSublayer(textLayer)
    }
}
