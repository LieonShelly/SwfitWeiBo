//
//  ZENameQRCodeViewController.swift
//  SwfitWeiBo
//
//  Created by apple on 16/5/27.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

class ZENameQRCodeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.创建相框
         view .addSubview(icon)
        
        // 2.设置标题
         navigationItem.title = "我的名片";
        
        // 3.生成二维码
        let qrCodeImgae = creatQRCodeImage()
        
        // 4.将生成的二维码添加到相册中
        icon.image = qrCodeImgae
        
    }
    
    // MARK:懒加载
    private lazy var icon : UIImageView = {
        let iv = UIImageView()
        iv.center = self.view.center
        iv.bounds = CGRectMake(0, 0, 300, 300)
        iv.backgroundColor = UIColor.redColor()
        self.view.backgroundColor = UIColor.whiteColor()
        return iv;
        
    }()
    
    private func creatQRCodeImage()->UIImage
    {
        // 1.创建滤镜
        let filter = CIFilter(name:"CIQRCodeGenerator" )
        
        //2. 还原滤镜的默认属性
        filter?.setDefaults()
        
        //3.设置需要生成的二维码的数据
        filter?.setValue("lirenjun".dataUsingEncoding(NSUTF8StringEncoding), forKey: "inputMessage")
        
        // 4.从滤镜中取出生成二维码的数据
        let  ciImage = filter?.outputImage
        
        let  bgImage = createNonInterpolatedUIImageFormCIImage(ciImage!, size: 300)
        
        // 5.创建一个头像
        let icon = UIImage(named: "nange")
        
        //6.合成图片(将二维码和头像进行合并)
        let newImage = cgreatImage(bgImage,iconImage: icon!)
        
        // 7.返回生成好的二维码
        return newImage
    }
    
    /**
     根据CIImage生成指定大小的高清UIImage
     
     :param: image 指定CIImage
     :param: size    指定大小
     :returns: 生成好的图片
     */
    private func createNonInterpolatedUIImageFormCIImage(image: CIImage, size: CGFloat) -> UIImage
    {
        let extent:CGRect = CGRectIntegral(image.extent)
        let scale:CGFloat = min(size/CGRectGetWidth(image.extent), size/CGRectGetHeight(extent))
        
        // 1.创建bitmap;
        let width = CGRectGetWidth(extent) * scale
        let height = CGRectGetHeight(extent) * scale
        let cs: CGColorSpaceRef = CGColorSpaceCreateDeviceGray()!
        let bitmapRef = CGBitmapContextCreate(nil, Int(width), Int(height), 8, 0, cs, 0)!
        
        let context = CIContext(options: nil)
        let bitmapImage: CGImageRef = context.createCGImage(image, fromRect: extent)
        
        CGContextSetInterpolationQuality(bitmapRef,  CGInterpolationQuality.None)
        CGContextScaleCTM(bitmapRef, scale, scale);
        CGContextDrawImage(bitmapRef, extent, bitmapImage);
        
        // 2.保存bitmap到图片
        let scaledImage: CGImageRef = CGBitmapContextCreateImage(bitmapRef)!
        
        return UIImage(CGImage: scaledImage)
    }
    
    /**
     *  将二维码和头像进行合并
     */
    func cgreatImage(qrImgae:UIImage, iconImage:UIImage) -> UIImage
    {
        // 1.开启图片上下文
        UIGraphicsBeginImageContext(qrImgae.size)
        // 2. 绘制背景图片
        qrImgae.drawInRect(CGRect(origin: CGPointZero,size: qrImgae.size))
        // 3.绘制头像
        let width:CGFloat = 50
        let height:CGFloat = width
        let x  = (qrImgae.size.width - width) * 0.5
        let y = (qrImgae.size.height - height) * 0.5
        iconImage.drawInRect(CGRectMake(x, y, width, height))
        // 4.取出绘制好的图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        // 5.关闭上下文
        UIGraphicsEndImageContext()
        // 6.返回合成好的图片
        return newImage
        
    }
}
