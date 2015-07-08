//
//  QRScanView.swift
//  Frameless
//
//  Created by Yiming on 15/6/25.
//  Copyright (c) 2015年 Jay Stakelon. All rights reserved.
//

import UIKit

class QRScanView: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        var screenBounds = UIScreen.mainScreen().bounds
        var screenWidth = CGRectGetWidth(screenBounds);
        var screenHeight = CGRectGetHeight(screenBounds);
        
        
        //画出一个带有透明度的灰色视图
        var context: CGContextRef = UIGraphicsGetCurrentContext();
        CGContextSetRGBFillColor(context, 40.0/255, 40.0/255, 40.0/255, 0.5);
        CGContextFillRect(context, screenBounds);
        
        //扫描区域
        var scanRectWidth = screenWidth/6.0 * 4;
        var scanRect = CGRectMake(screenWidth/6.0, (screenHeight - scanRectWidth)/2.0, scanRectWidth, scanRectWidth);
        
        //清空扫描区域
        CGContextClearRect(context, scanRect);
        
        //为扫描区域画边框
        CGContextSetRGBStrokeColor(context, 1, 1, 1, 1);
        CGContextSetLineWidth(context, 1);
        CGContextAddRect(context, scanRect);
        CGContextStrokePath(context);
        
        //画四个边角
        CGContextSetLineWidth(context, 2);
        CGContextSetRGBStrokeColor(context, 158/255.0, 131/255.0, 232/255.0, 1);//绿色
        
        //左上角
        var leftTopPointsA = [
            CGPointMake(scanRect.origin.x, scanRect.origin.y),
            CGPointMake(scanRect.origin.x + 15, scanRect.origin.y)
        ];
        CGContextAddLines(context, leftTopPointsA, 2);
        
        var leftTopPointsB = [
            CGPointMake(scanRect.origin.x, scanRect.origin.y),
            CGPointMake(scanRect.origin.x, scanRect.origin.y + 15)
        ];
        CGContextAddLines(context, leftTopPointsB, 2);
        
        //左下角
        var leftBottomPointsA = [
            CGPointMake(scanRect.origin.x, scanRect.origin.y + scanRect.size.height),
            CGPointMake(scanRect.origin.x, scanRect.origin.y + scanRect.size.height - 15)
        ];
        CGContextAddLines(context, leftBottomPointsA, 2);
        
        var leftBottomPointsB = [
            CGPointMake(scanRect.origin.x, scanRect.origin.y + scanRect.size.height),
            CGPointMake(scanRect.origin.x + 15, scanRect.origin.y + scanRect.size.height)
        ];
        CGContextAddLines(context, leftBottomPointsB, 2);
        
        
        //右上角
        var rightTopPoinsA = [
            CGPointMake(scanRect.origin.x + scanRect.size.width, scanRect.origin.y),
            CGPointMake(scanRect.origin.x + scanRect.size.width - 15, scanRect.origin.y)
        ];
        CGContextAddLines(context, rightTopPoinsA, 2);
        
        var rightTopPointsB = [
            CGPointMake(scanRect.origin.x + scanRect.size.width, scanRect.origin.y),
            CGPointMake(scanRect.origin.x + scanRect.size.width, scanRect.origin.y + 15)
        ];
        CGContextAddLines(context, rightTopPointsB, 2);
        
        
        //右下角
        var rightBottomPoinsA = [
            CGPointMake(scanRect.origin.x + scanRect.size.width,scanRect.origin.y + scanRect.size.height),
            CGPointMake(scanRect.origin.x + scanRect.size.width - 15, scanRect.origin.y + scanRect.size.height)
        ];
        CGContextAddLines(context,rightBottomPoinsA, 2);
        
        var rightBottomPointsB = [
            CGPointMake(scanRect.origin.x + scanRect.size.width, scanRect.origin.y + scanRect.size.height),
            CGPointMake(scanRect.origin.x + scanRect.size.width, scanRect.origin.y + scanRect.size.height - 15)
        ];
        CGContextAddLines(context,rightBottomPointsB, 2);
        
        
        CGContextStrokePath(context);
    }
    

}
