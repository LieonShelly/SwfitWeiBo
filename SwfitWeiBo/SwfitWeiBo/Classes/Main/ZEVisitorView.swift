//
//  ZEVisitorView.swift
//  SwfitWeiBo
//
//  Created by apple on 16/5/14.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import SnapKit

class ZEVisitorView: UIView {

    
    override init(frame: CGRect) {
        super.init(frame:frame)
        addSubview(backgroundImageView)
        addSubview(maskBGImageView)
        addSubview(iconview)
        addSubview(textLabel)
        addSubview(registerBtn)
        addSubview(loginBtn)
    
        // 布局子控件
        backgroundImageView.snp_makeConstraints { (make) in
            make.center.equalTo(center)
        }
        maskBGImageView.snp_makeConstraints { (make) in
            make.center.equalTo(center)
        }
        iconview.snp_makeConstraints { (make) in
            make.center.equalTo(center)
        }
        textLabel.snp_makeConstraints { (make) in
            make.top.equalTo(iconview.snp_bottom).offset(20)
            make.left.equalTo(maskBGImageView)
            make.right.equalTo(maskBGImageView)
        }
        registerBtn.snp_makeConstraints { (make) in
            make.left.equalTo(maskBGImageView)
            make.top.equalTo(textLabel.snp_bottom).offset(5)
            make.right.equalTo(loginBtn.snp_left)
        }
        
        loginBtn.snp_makeConstraints { (make) in
            make.right.equalTo(maskBGImageView)
            make.top.equalTo(textLabel.snp_bottom).offset(5)
            make.width.equalTo(registerBtn.snp_width)
            make.left.equalTo(registerBtn.snp_right)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK:懒加载控件
    // 转盘
    private lazy var backgroundImageView:UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "visitordiscover_feed_image_smallicon")
        return iv
        
    }()
    // 遮盖
    private lazy  var maskBGImageView:UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "visitordiscover_feed_mask_smallicon")
        return iv
    }()
    //  房子
    private lazy var iconview:UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "visitordiscover_feed_image_house")
        return iv
    }()
    // label
    private lazy var textLabel:UILabel = {
        let label = UILabel()
        label.text = "sdfsdfsdfsdfdfsd"
        return label
    }()
    //按钮
    private lazy var registerBtn:UIButton = {
        let btn = UIButton()
     btn.setBackgroundImage(UIImage(named:"common_button_white_disable"), forState: UIControlState.Normal)
        btn.setTitle("注册", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        return btn
    }()
    private lazy var loginBtn:UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named:"common_button_white_disable"), forState: UIControlState.Normal)
        btn.setTitle("登录", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        return btn
    }()
}
