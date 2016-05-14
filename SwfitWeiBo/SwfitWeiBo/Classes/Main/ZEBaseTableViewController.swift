

//
//  ZEBaseTableViewController.swift
//  SwfitWeiBo
//
//  Created by apple on 16/5/14.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

class ZEBaseTableViewController: UITableViewController {

    var userLogin = false
    
    override func loadView() {
        userLogin ? super.loadView() : setUpBaseView()
    }
   
    private func setUpBaseView()
    {
        view = ZEVisitorView()
        view.backgroundColor = UIColor.whiteColor()
    }
}
