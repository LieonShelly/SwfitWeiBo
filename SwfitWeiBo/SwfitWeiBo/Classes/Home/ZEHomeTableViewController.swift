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
    }

}
