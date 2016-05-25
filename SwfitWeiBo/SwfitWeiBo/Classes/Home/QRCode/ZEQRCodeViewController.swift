//
//  ZEQRCodeViewController.swift
//  SwfitWeiBo
//
//  Created by apple on 16/5/19.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import AVFoundation

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
        //1.开始冲击波动画
        startAnimation()
        
        //2.开始扫描
        startScan()
    }
    
    /**
     *  开始动画
     */
    private func startAnimation ()
    {
        
        scanLineTopCons.constant  = -self.containerHeightCons.constant;
        scanLine.layoutIfNeeded()
     UIView.animateWithDuration(1) {
            //1.修改约束
           self.scanLineTopCons.constant = self.containerHeightCons.constant
            // 2.设定动画的指定次数
        UIView.setAnimationDuration(1000)
        // 3.强制更新界面
        self.scanLine.layoutIfNeeded()
        }
    }
    
    
    // MARK: - UITabBarDelegate
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        if tabBar.selectedItem?.tag == 1{
            containerHeightCons.constant = 300
        }else{
            containerHeightCons.constant = 200
        }
        self.scanLine.layer .removeAllAnimations()
        startAnimation()
    }
    
    /** 扫描二维码
     */
    func startScan()
    {
        // 1.判断是否能够将输入添加到会话中
        if !session.canAddInput(deviceInput) {
            return
        }
        // 2.判断是否是能够将输出添加到会话中
        if !session.canAddOutput(output) {
            return
        }
        // 3.将输入和输出都添加会话中
        session.addInput(deviceInput)
        session.addOutput(output)
        
        // 4.设置输出能够解析的数据类型
        // 注意：设置能够解析的数据类型，一定要在输出对像添加到会话后设置，否则会报错
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        
        // 5.设置输出对象的代理，只要解析成功就会通知代理
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        
        //  添加预览图层
        view.layer.insertSublayer(previewLayer, atIndex: 0)
        // 6.告诉session开始扫描
        session.startRunning()
    }
    
    // MARK: - 懒加载
    //会话
    private lazy var session:AVCaptureSession = {
        AVCaptureSession()
    }()
    
    // 拿到输入设备
    private lazy var deviceInput:AVCaptureDeviceInput? = {
        // 获取摄像头
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        do{
            // 创建输入对象
            let input = try AVCaptureDeviceInput(device:device)
            return input
            
        }catch
        {
            print(error)
            return nil
        }
    }()
    
    // 拿到输出对象
    private lazy var output:AVCaptureMetadataOutput = {
        AVCaptureMetadataOutput()
    }()
    
    // 创建预览图层
    private lazy var previewLayer:AVCaptureVideoPreviewLayer = {
        let layer = AVCaptureVideoPreviewLayer(session:self.session)
        layer.frame = UIScreen.mainScreen().bounds
        return layer
    }()
    
}

extension ZEQRCodeViewController:AVCaptureMetadataOutputObjectsDelegate
{
    // 只要解析到数据就会调用
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        print(metadataObjects.last?.stringValue)
    }
}