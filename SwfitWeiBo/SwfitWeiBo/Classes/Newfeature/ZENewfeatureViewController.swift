//
//  ZENewfeatureViewController.swift
//  SwfitWeiBo
//
//  Created by lieon on 16/6/20.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

let reuseIdentifier = "ZENewfeatureViewCell"

class ZENewfeatureViewController: UICollectionViewController {

    // 页面的个数
  private  let pageCout = 4
    private var layout: UICollectionViewFlowLayout = ZENewfeatureLayout()
    
    init  () {
      super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // 1.注册一个cell 
        collectionView?.registerClass(ZENewfeatureViewCell.self, forCellWithReuseIdentifier:reuseIdentifier)
    }
 
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageCout
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ZENewfeatureViewCell
    
        cell.imageIndex = indexPath.item
        return cell
        
    }
    
    // 完全显示一个cell之后调用
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        // 传递给我们的是上一页的索引
        //        print(indexPath)
        
        // 1.拿到当前显示的cell对应的索引
        let path = collectionView.indexPathsForVisibleItems().last!
        print(path)
        if path.item == (pageCout - 1)
        {
            // 2.拿到当前索引对应的cell
            let cell = collectionView.cellForItemAtIndexPath(path) as! ZENewfeatureViewCell
            // 3.让cell执行按钮动画
            cell.startBtnAnimation()
        }
    }

}




private class ZENewfeatureLayout:UICollectionViewFlowLayout{
    
    // 准备布局
    private override func prepareLayout()
    {
      //  1.设置layout
        itemSize = UIScreen.mainScreen().bounds.size
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = UICollectionViewScrollDirection.Horizontal
        // 设置collectionView的属性
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.bounces = false
        collectionView?.pagingEnabled = true
    }
}


// Swift中一个文件中是可以定义多个类的
// 如果当前类需要监听按钮的点击方法, 那么当前类不是是私有的
private class ZENewfeatureViewCell:UICollectionViewCell
{
    /// 保存图片的索引
    // Swift中被private休息的东西, 如果是在同一个文件中是可以访问的
   private var imageIndex: Int?
    {
    didSet{
        iconView.image = UIImage(named: "new_feature_\(imageIndex! + 1)")
    }
    }
    
    /**
     让按钮做动画
     */
    func startBtnAnimation()
    {
        startButton.hidden = false
        
        // 执行动画
        startButton.transform = CGAffineTransformMakeScale(0.0, 0.0)
        startButton.userInteractionEnabled = false
        
        // UIViewAnimationOptions(rawValue: 0) == OC knilOptions
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
            // 清空形变
            self.startButton.transform = CGAffineTransformIdentity
            }, completion: { (_) -> Void in
                self.startButton.userInteractionEnabled = true
        })
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 1.初始化UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(){
        // 1.添加子控件到contentView上
        contentView.addSubview(iconView)
        contentView.addSubview(startButton)
        
        // 2.布局子控件的位置
        iconView.snp_makeConstraints { (make) in
            make.top.equalTo(contentView.snp_top)
            make.left.equalTo(contentView.snp_left)
            make.right.equalTo(contentView.snp_right)
            make.bottom.equalTo(contentView.snp_bottom)
        }
        
        startButton.snp_makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(44)
            make.centerX.equalTo(contentView.snp_centerX)
            make.bottom.equalTo(contentView.snp_bottom).offset(-160)
        }
    }
 
    @objc func customBtnClick()
    {
        //        print("-----")
        // 去主页, 注意点: 企业开发中如果要切换根控制器, 最好都在appdelegate中切换
        NSNotificationCenter.defaultCenter().postNotificationName(switchRootViewControllerKey,  object: self, userInfo: [boolKey:true])
    }
    
    private lazy var iconView = UIImageView()
    private lazy var startButton: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "new_feature_button"), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "new_feature_button_highlighted"), forState: UIControlState.Highlighted)
        
        btn.hidden = true
        btn.addTarget(self, action:#selector(ZENewfeatureViewCell.customBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
}