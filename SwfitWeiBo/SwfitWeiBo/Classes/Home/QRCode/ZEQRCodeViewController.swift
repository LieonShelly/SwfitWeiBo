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
    
    @IBOutlet weak var resultLabel: UILabel!
    
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
    // 创建用于绘制边线的图层
    private lazy var drawLayer:CAShapeLayer = {
       
        let layer = CAShapeLayer()
        layer.lineWidth = 4
        layer.strokeColor = UIColor.redColor().CGColor
        layer.fillColor = nil
        self.previewLayer.addSublayer(layer)
        return layer
    }()
    
   
}

extension ZEQRCodeViewController:AVCaptureMetadataOutputObjectsDelegate
{
    // 只要解析到数据就会调用
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        //
        clearPath()
        
        // 1.获取扫描到的数据
        print(metadataObjects.last?.stringValue)
        resultLabel.text = metadataObjects.last?.stringValue
        // 2.获取扫描到的二维码的位置
        // 2.1 转换坐标
        for object in metadataObjects
        {
            // 2.1.1 判断当前获取的数据，是否是机器可识别的类型
            if object is AVMetadataMachineReadableCodeObject
            {
                // 2.1.2 将坐标转化为界面可识别的坐标
                let codeObject = previewLayer.transformedMetadataObjectForMetadataObject(object as! AVMetadataObject) as! AVMetadataMachineReadableCodeObject
                // 2.1.3 绘制图形
                drawCorners(codeObject)
                
            }
        }
    }
    
    private func drawCorners(codeObject:AVMetadataMachineReadableCodeObject)
    {
        if codeObject.corners.isEmpty
        {
            return
        }
        let  path = UIBezierPath()
        var point = CGPointZero
        var index:Int = 0
        // 1.1移动到第一个点
        CGPointMakeWithDictionaryRepresentation((codeObject.corners[index++] as! CFDictionaryRef), &point)
        path.moveToPoint(point)
        // 1.2 移动到其他的点
        while index < codeObject.corners.count {
            CGPointMakeWithDictionaryRepresentation((codeObject.corners[index++] as! CFDictionaryRef), &point)
            path.addLineToPoint(point)
            
           
        }
        
         path .closePath()
        drawLayer.path = path.CGPath
        
        
        
        
        
    }
    
    /**
     *   清空边线
     */
    private func clearPath()
    {
        drawLayer.path = nil
    }
}