//
//  ZEMainViewController.swift
//  SwfitWeiBo
//
//  Created by apple on 16/5/11.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

class ZEMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addchildViewControllers()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        addComposeBtn()
    }
    
    func comoposeBtnClick() {
        print("comoposeBtnClick")
    }
    private func addchildViewControllers()
    {
        /**
         *  从服务器加载控制器
         */
        // 获取json文件的路径
        let path = NSBundle.mainBundle().pathForResource("ViewControllers.json", ofType: nil)
        //  通过文件路径创建NSData
        if let jsonPath = path {
            let jsonData  = NSData.dataWithContentsOfMappedFile(jsonPath)
            do{
                // 用的do---catch的目的是在解析json时有可能发生异常
                // try：发生异常会跳到catch中继续执行
                // try!:发生异常程序直接崩溃
                let  dicArr = try NSJSONSerialization.JSONObjectWithData(jsonData! as! NSData, options: NSJSONReadingOptions.MutableContainers)
                print(dicArr)
                // 遍历数组，动态创建控制器和设置数据
                // 在swfit中，如果需要遍历一个数组，必须明确数据类型
                // dicArr as! [[String:String]]表示dicArr是个数组，数组中元素是个字典，字典的关键字类型是String，字典的Value类型是String
                for dict in dicArr as! [[String:String]]
                {
                    // 报错的原因是因为addOneChilidViewController的参数必须有值，但是字典的返回值是可选类型，不一定有值，所以要在后面加一个！告诉编译器一定有值，dict!["VCName"]表示字典一定有值，dict["VCName"]!表示字典的返回值一定有值
                    addOneChilidViewController(dict["VCName"]!, title: dict["Title"]!, imageName: dict["VCIcon"]!)
                }
            }
            catch
            {// 发生异常执行的代码
                // 从本地加载控制器
                addOneChilidViewController("ZEHomeTableViewController", title: "首页", imageName: "tabbar_home")
                addOneChilidViewController("ZEMessageTableViewController", title: "消息", imageName: "tabbar_message_center")
                
                
                addOneChilidViewController("ZENullViewController", title: "", imageName: "")
                addOneChilidViewController("ZEFindTableViewController", title: "发现", imageName: "tabbar_discover")
                addOneChilidViewController("ZEMeTableViewController", title: "我", imageName: "tabbar_profile")
                print(error)
                
            }
        }
        

    }
   
    private func addComposeBtn()
    {
        tabBar.addSubview(composeBtn)
        let width:CGFloat = UIScreen.mainScreen().bounds.size.width / CGFloat( childViewControllers.count)
        let height:CGFloat = 44.0
        let frame : CGRect = CGRectMake(0, 0, width, height)
        
        composeBtn.frame = CGRectOffset(frame, 2 * width, 0)
        
        
    }
    //  MARK:私有方法
    /**
     *  添加一个子控制器
     */
    private func addOneChilidViewController(childVCStr:String ,title:String ,imageName:String)
    {
        let selectedImageName:String = imageName + "_highlighted"
        // 1.动态获取命名空间(as：强制类型转换，！：一定有值)
        let ns = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        let nsm :String = String(ns)
        
        // 将字符串抓换为类
        let cls:AnyClass? = NSClassFromString(nsm + "." + childVCStr)
        //将Anyclas转化为指定的类型
        let vcls = cls as! UIViewController.Type
        let vc = vcls.init()
        print(vc)
        
        vc.tabBarItem.title = title;
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        let navi = UINavigationController.init(rootViewController: vc)
        addChildViewController(navi)
        
    }
    // MARK:懒加载
    private lazy var composeBtn:UIButton = {
        let btn = UIButton()
        btn .setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        btn.addTarget(self, action: "comoposeBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal)
        return btn
        
    }()
}
