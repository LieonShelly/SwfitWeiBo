//
//  ZEHomeTableViewController.swift
//  SwfitWeiBo
//
//  Created by apple on 16/5/14.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

class ZEHomeTableViewController: ZEBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
   // 1.判断是否登录
        if !userLogin {
            visistiorView?.setupBaseView(true, imageName: "visitordiscover_feed_image_house", text: "关注一些人，回到这里看看有什惊喜")
            return;
        }
    // 2.设置导航栏
        setupNavi()
    }
    
   // MARK:内部控制方法
    /**
     *  设置导航栏
     */
    private func setupNavi()
    {
        navigationItem.leftBarButtonItem = UIBarButtonItem.creatBarButtonItem("navigationbar_friendattention", target: self, action: #selector(ZEHomeTableViewController.leftBarButtonItemClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem.creatBarButtonItem("navigationbar_pop", target: self, action: #selector(ZEHomeTableViewController.rightBarButtonItemClick))
        
        let btn = ZETitileButton()
        btn.setTitle("lieonlee ", forState: UIControlState.Normal)
        btn.addTarget(self, action: #selector(ZEHomeTableViewController.titilBtnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        navigationItem.titleView = btn
        
    }
    
    // MARK:按钮的点击
     func leftBarButtonItemClick()
    {
        print(#function)
    }
    
    func rightBarButtonItemClick()
    {
        
        print(#function)
    }
    
    func titilBtnClick(btn:ZETitileButton)
    {
        btn.selected = !btn.selected
        let sb = UIStoryboard(name: "PopViewController",bundle: nil)
        let  vc = sb.instantiateInitialViewController()
        // 设置转场动画的代理
        // 默认情况下，modal会移除控制器的view，替换为当前弹出的view
        // 自定义转场，那么就不会移除当前控制器的View
        vc?.transitioningDelegate = self
        
        vc?.modalPresentationStyle = UIModalPresentationStyle.Custom;
        presentViewController(vc!, animated: true, completion: nil)
        
    }

    var isPresent:Bool = false
    
}


extension ZEHomeTableViewController:UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning
    
    
{
    
    // 实现代理方法，告诉系统谁来实现转场动画(ZEPopPresentationController)(继承自UIPresentationController)
     func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController?
     {
        
        return ZEPopPresentationController(presentedViewController: presented,presentingViewController:presenting)
    }
    
  // MARK:只要实现了一下方法，那么系统自带的动画方法就没有了，所有东西都需要程序员自己来实现
    /**
     *  告诉系统谁来负责Modal展现的动画
     */
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
      isPresent = true
        return self
    }
    
    /**
     *  告诉系统谁来负责modal消失的动画
     */
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    

    {
        isPresent = false
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
            UIView.animateWithDuration(0.5, animations: {
                //2.1清空transform
                toView?.transform = CGAffineTransformIdentity;
                
            }) { (_) in
                //2.2动画执行完毕一定要告诉系统
                transitionContext.completeTransition(true)
            }
        }else{
            // 关闭
            let  fromeView = transitionContext.viewForKey(UITransitionContextFromViewKey)
            UIView.animateWithDuration(0.5, animations: { 
                // 注意：由于CGFloat是不准确的，所以写0.0会没有动画的
                fromeView?.transform = CGAffineTransformMakeScale(1.0, 0.00001)
                }, completion: { (_) in
                    transitionContext.completeTransition(true)
            })
            
            
        }
      
        
    }
}


