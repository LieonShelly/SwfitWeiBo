//
//  UIBarButtonItem+Category.swift
//  SwfitWeiBo
//
//  Created by apple on 16/5/15.
//  Copyright © 2016年 lieon. All rights reserved.
//  UIBarButtonItem的分类

import Foundation
import UIKit

extension UIBarButtonItem{
    
    // 如果在func前加class相当于OC中+
    class func creatBarButtonItem(imageName:String,target:AnyObject?,action:Selector?) -> UIBarButtonItem
    {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: imageName+"_highlighted"), forState: UIControlState.Highlighted)
        btn.addTarget(target, action: action!, forControlEvents: UIControlEvents.TouchUpInside)
        btn .sizeToFit()
        return UIBarButtonItem.init(customView: btn)
        
    }
}