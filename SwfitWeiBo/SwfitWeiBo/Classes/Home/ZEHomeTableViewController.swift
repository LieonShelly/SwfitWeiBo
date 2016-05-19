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
        // 3.注册通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ZEHomeTableViewController.change), name: ZEPopverAnimatorWillShow, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ZEHomeTableViewController.change), name: ZEPopverAnimatorWillDismiss, object: nil)
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    //MARK:通知相关
    func change()
    {
        let titleBtn  = navigationItem.titleView as! ZETitileButton
        titleBtn.selected = !titleBtn.selected
        
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
        let qr   = UIStoryboard(name:"QRCode",bundle: nil).instantiateInitialViewController()
        presentViewController(qr!, animated: true, completion: nil)
        
        
        print(#function)
    }
    
    func titilBtnClick(btn:ZETitileButton)
    {
        let sb = UIStoryboard(name: "PopViewController",bundle: nil)
        let  vc = sb.instantiateInitialViewController()
        // 设置转场动画的代理
        // 默认情况下，modal会移除控制器的view，替换为当前弹出的view
        // 自定义转场，那么就不会移除当前控制器的View
        vc?.transitioningDelegate = popVerAnimator;
        vc?.modalPresentationStyle = UIModalPresentationStyle.Custom;
        presentViewController(vc!, animated: true, completion: nil)
        
    }
   
    // MARK:懒加载
    // 一定要定义一个属性，来保存转场对象，否则会报错
    private  lazy var  popVerAnimator:ZEPopverAnimator = {
        let popVerAnimator = ZEPopverAnimator()
        popVerAnimator.presentFrame = CGRectMake(100, 56, 200,200)
        return popVerAnimator
    }()
    
}


