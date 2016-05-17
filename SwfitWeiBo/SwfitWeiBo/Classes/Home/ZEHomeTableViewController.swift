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

}


extension ZEHomeTableViewController:UIViewControllerTransitioningDelegate
{
    // 实现代理方法，告诉系统谁来实现转场动画
     func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController?
     {
        return ZEPopPresentationController(presentedViewController: presented,presentingViewController:presenting)
    }
}

