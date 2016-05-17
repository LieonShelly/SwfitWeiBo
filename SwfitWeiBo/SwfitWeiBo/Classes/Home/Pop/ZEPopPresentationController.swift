//
//  ZEPopPresentationController.swift
//  SwfitWeiBo
//
//  Created by apple on 16/5/17.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

class ZEPopPresentationController: UIPresentationController {
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
        presentedView()?.frame = CGRectMake(100, 56, 200, 200)
        
        //containerView上添加一个蒙版
         
    }
}
