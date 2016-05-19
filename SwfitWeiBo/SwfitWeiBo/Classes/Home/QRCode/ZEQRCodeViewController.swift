//
//  ZEQRCodeViewController.swift
//  SwfitWeiBo
//
//  Created by apple on 16/5/19.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

class ZEQRCodeViewController: UIViewController,UITabBarDelegate {
    // 冲击波
    @IBOutlet weak var scanLine: UIImageView!
    // 容器
    @IBOutlet weak var container: UIView!
    // 容器的高度约束
    @IBOutlet weak var containerHeightCons: NSLayoutConstraint!
    
    // 冲击波的顶部约束
    @IBOutlet weak var scanLineTopCons: NSLayoutConstraint!
    @IBOutlet weak var tabBar: UITabBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    tabBar.selectedItem = tabBar.items![0]
    tabBar.delegate = self
    }
   
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        scanLineTopCons.constant  = -self.containerHeightCons.constant;
        scanLine.layoutIfNeeded()
        startAnimation()
        
    }
    
    private func startAnimation ()
    {
        UIView.setAnimationDuration(10000)
        UIView.animateWithDuration(1) {
            self.scanLineTopCons.constant = self.containerHeightCons.constant
            
            self.scanLine .layoutIfNeeded()
        }
    }
    
    // MARK:UITabBarDelegate
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        if tabBar.selectedItem?.tag == 1{
            containerHeightCons.constant = 300
        }else{
            containerHeightCons.constant = 200
        }
        self.scanLine.layer .removeAllAnimations()
        startAnimation()
    }

}
