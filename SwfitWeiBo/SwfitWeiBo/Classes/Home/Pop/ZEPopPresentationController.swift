//
//  ZEPopPresentationController.swift
//  SwfitWeiBo
//
//  Created by apple on 16/5/17.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

class ZEPopPresentationController: UIPresentationController {
    
    
    var presentFrame:CGRect = CGRectZero
    
    /**
     *  初始化方法，用于创建转场动画的对象那
     */
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
    }
    /**
     *  即将布局子视图的时候调用
     */
    override func containerViewWillLayoutSubviews() {
//        containerView  容器视图
//        presentedView()  被展现的视图
        //修改弹出视图的大小
        
        if presentFrame == CGRectZero {
            
            presentedView()?.frame = CGRectMake(100, 56, 200, 200)
        }else{
            
            presentedView()?.frame = presentFrame
        }
        
        //containerView上添加一个蒙版
        let cover = UIButton()
        cover.frame =  containerView!.bounds;
        cover.backgroundColor = UIColor.grayColor();
        cover.alpha = 0.1;
        cover.addTarget(self, action:#selector(ZEPopPresentationController.coverClcik), forControlEvents: UIControlEvents.TouchUpInside);
        [containerView!.addSubview(cover)];
        
    }
    
    func coverClcik()
  {
     presentedViewController .dismissViewControllerAnimated(true, completion: nil)
    }
}
