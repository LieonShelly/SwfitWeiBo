//
//  ZEPopverAnimator.swift
//  SwfitWeiBo
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 lieon. All rights reserved.
//  自定义一个类来专门负责转场动画

import UIKit

let ZEPopverAnimatorWillShow = "ZEPopverAnimatorWillShow"
let ZEPopverAnimatorWillDismiss = "ZEPopverAnimatorWillDismiss"


class ZEPopverAnimator: NSObject, UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning

{
    var isPresent :Bool = false
    /**
     *  通过外部设置菜单的大小
     */
    var presentFrame:CGRect = CGRectZero
    
    
    // 实现代理方法，告诉系统谁来实现转场动画(ZEPopPresentationController)(继承自UIPresentationController)
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController?
    {
        let pc = ZEPopPresentationController(presentedViewController: presented,presentingViewController:presenting)
        pc.presentFrame = presentFrame
        return pc
    }
    
    // MARK:只要实现了一下方法，那么系统自带的动画方法就没有了，所有东西都需要程序员自己来实现
    /**
     *  告诉系统谁来负责Modal展现的动画
     */
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        isPresent = true
    NSNotificationCenter.defaultCenter().postNotificationName(ZEPopverAnimatorWillShow, object: self)
        return self
    }
   
    /**
     *  告诉系统谁来负责modal消失的动画
     */
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
        
        
    {
        isPresent = false
        NSNotificationCenter .defaultCenter().postNotificationName(ZEPopverAnimatorWillDismiss, object: self)
        return self
    }
    
    // MARK: UIViewControllerAnimatedTransitioning
    /**
     *  返回动画时长，
     *
     *  @param UIViewControllerContextTransitioning? 上下文，里面保存了所有的参数
     *
     */
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval
    {
        return 0.5
    }
    
    /**
     *  告诉系统如何动画
     *
     *  @param UIViewControllerContextTransitioning 上下文，里面保存了所有的参数
     *
     *
     */
    func animateTransition(transitionContext: UIViewControllerContextTransitioning)
    {
        
        if isPresent {
            // 1. 拿到展现的视图
            let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
            toView?.transform = CGAffineTransformMakeScale(1.0, 0)
            
            // 注意一定要将视图添加到容器视图中
            transitionContext.containerView()?.addSubview(toView!)
            
            // 设置锚点
            toView?.layer.anchorPoint = CGPointMake(0.5, 0)
            
            //2.执行动画
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
                //2.1清空transform
                toView?.transform = CGAffineTransformIdentity;
                
            }) { (_) in
                //2.2动画执行完毕一定要告诉系统
                transitionContext.completeTransition(true)
            }
        }else{
            // 关闭
            let  fromeView = transitionContext.viewForKey(UITransitionContextFromViewKey)
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
                // 注意：由于CGFloat是不准确的，所以写0.0会没有动画的
                fromeView?.transform = CGAffineTransformMakeScale(1.0, 0.00001)
                }, completion: { (_) in
                    transitionContext.completeTransition(true)
            })
            
            
        }
        
        
    }
}
    
