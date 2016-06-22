
//
//  ZEWelcomeViewController.swift
//  SwfitWeiBo
//
//  Created by lieon on 16/6/20.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class ZEWelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //1. 添加子控件
        view.addSubview(bigIV)
        view.addSubview(messageLabel)
        view.addSubview(iconView)
        // 2. 布局子控件
       bigIV.snp_makeConstraints { (make) in
        make.top.equalTo(view.snp_top)
        make.left.equalTo(view.snp_left)
        make.right.equalTo(view.snp_right)
        make.bottom.equalTo(view.snp_bottom)
        }
        
        iconView.snp_makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.centerX.equalTo(view.snp_centerX)
            make.top.equalTo(view.snp_top).offset(100)
        }
        
        messageLabel.snp_makeConstraints { (make) in
            
            make.centerX.equalTo(view.snp_centerX)
            make.top.equalTo(iconView.snp_bottom).offset(10)
        }
     // 设置用户头像
        if let url = ZEUserAccount.loadAccount()?.avatar_large {
            iconView.sd_setImageWithURL(NSURL(string: url))
        }
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // 1.执行动画
        self.iconView.snp_updateConstraints(closure: { (make) in
            make.top.equalTo(self.view.snp_top).offset(80)
        })
         UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: UIViewAnimationOptions(rawValue: 0), animations: {
             self.iconView.layoutIfNeeded()
            }) { (_) in
                // 文本动画
                 UIView.animateWithDuration(2, delay: 2.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: UIViewAnimationOptions(rawValue: 0), animations: { 
                    self.messageLabel.alpha = 1.0
                    }, completion: { (_) in
                        
                        
                        NSNotificationCenter.defaultCenter().postNotificationName(switchRootViewControllerKey,  object: self, userInfo: [boolKey:true])
                 })
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:懒加载
    private lazy var bigIV: UIImageView = UIImageView(image: UIImage(named: "ad_background"))
    private lazy var iconView:UIImageView = {
        let iv = UIImageView(image: UIImage(named:"ad_background"))
        iv.layer.cornerRadius = 50
        iv.clipsToBounds = true
        return iv
    }()
    private lazy var messageLabel :UILabel = {
        let label  = UILabel()
        label.text = "欢迎回来"
        label.sizeToFit()
        label.alpha = 0.0
        return label
    }()
}
