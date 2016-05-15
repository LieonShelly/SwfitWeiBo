//
//  ZETitileButton.swift
//  SwfitWeiBo
//
//  Created by apple on 16/5/15.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit


class ZETitileButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(UIImage(named: "navigationbar_arrow_up"), forState: UIControlState.Normal)
        setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Selected)
        setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.sizeToFit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = titleLabel!.frame.size.width
    }
}
