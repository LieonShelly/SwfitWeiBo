//
//  ZEVisitorView.swift
//  SwfitWeiBo
//
//  Created by apple on 16/5/14.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import SnapKit

// swfit中定义协议必须遵守NSObjectProtocol
protocol ZEVisitorViewDelegate:NSObjectProtocol{
    // 注册回调
    func registerBtnWillClick()
    //登录回调
    func loginBtnWillClick()
    
}
class ZEVisitorView: UIView {

   weak var delegate :ZEVisitorViewDelegate?
    
    
    func setupBaseView(isHome:Bool,imageName:String,text:String)
    {
        backgroundImageView.hidden = !isHome
        iconview.image = UIImage(named: imageName)
        textLabel.text = text
        if isHome {
            startAnimation()
        }
    }
    
    // MARK:按钮的点击
    func loginBtnClick()
    {
        delegate?.loginBtnWillClick()
    }
    
    func registerBtnClick()
    {
      delegate?.registerBtnWillClick()
    }
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
            make.left.equalTo(self)
            make.bottom.equalTo(self)
            make.right.equalTo(self)
        }
        iconview.snp_makeConstraints { (make) in
            make.center.equalTo(center)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).inset(20)
        }
        textLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.snp_centerY).offset(80)
            make.centerX.equalTo(iconview)
            make.width.equalTo(300)
        }
        registerBtn.snp_makeConstraints { (make) in
        
        make.right.equalTo(textLabel.snp_centerX).offset(-20)
            make.top.equalTo(textLabel.snp_bottom).offset(5)
            make.width.equalTo(100)
        }
        
        loginBtn.snp_makeConstraints { (make) in
            make.left.equalTo(textLabel.snp_centerX).offset(20)
            make.top.equalTo(textLabel.snp_bottom).offset(5)
            make.width.equalTo(100)
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
        iv.contentMode = UIViewContentMode.ScaleAspectFit
//        iv.backgroundColor = UIColor.greenColor()
        iv.image = UIImage(named: "visitordiscover_feed_image_house")
        return iv
    }()
    // label
    private lazy var textLabel:UILabel = {
        let label = UILabel()
        label.text = "sdfsdfsdfsdfdfsd"
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.darkGrayColor()
        return label
    }()
    //按钮
    private lazy var registerBtn:UIButton = {
        let btn = UIButton()
     btn.setBackgroundImage(UIImage(named:"common_button_white_disable"), forState: UIControlState.Normal)
        btn.setTitle("注册", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        btn.addTarget(self, action:"registerBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
    private lazy var loginBtn:UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named:"common_button_white_disable"), forState: UIControlState.Normal)
        btn.setTitle("登录", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        btn.addTarget(self, action:"loginBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
    
    //MARK:内部控制方法
    func startAnimation() {
        // 创建动画
        let animation = CABasicAnimation()
        
        // 设置动画的一些属性
        animation.keyPath = "transform.rotation"
        animation.toValue = 2 * M_PI
        animation.repeatCount = MAXFLOAT
        animation.duration = 20
        // 动画完成则移除动画（默认为true）
        animation.removedOnCompletion = false
        // 将动画添加到图层上
        backgroundImageView.layer .addAnimation(animation, forKey: nil)
    }
}
