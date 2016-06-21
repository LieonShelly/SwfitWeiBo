//
//  ZEOAuthViewController.swift
//  SwfitWeiBo
//
//  Created by apple on 16/5/27.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import SVProgressHUD

let switchRootViewControllerKey = "switchRootViewControllerKey"

class ZEOAuthViewController: UIViewController
{

   let  client_id = "1084921523"
   let  App_Secret = "3a3a0fdcda5849d02a4835b4ebf05974"
   let  redirect_uri	 = "https://github.com"
    
    override func loadView() {
        webView.delegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // 1. 设置导航栏 
        navigationItem.title = "李仁军微博"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "关闭", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ZEOAuthViewController.closeBtnClick))
        // 2.设置加载webview
        let urlStr = "https://api.weibo.com/oauth2/authorize?client_id=\(client_id)&redirect_uri=\(redirect_uri)"
        let url = NSURL(string: urlStr)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }
   
    func closeBtnClick()
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK : 懒加载
    private var webView :UIWebView = {
       let  wv = UIWebView()
        return wv
    }()
}

extension ZEOAuthViewController: UIWebViewDelegate
{
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool
    {
        // 1.判断是否是授权回调页面，如果不是就继续加载
        let urlStr = request.URL!.absoluteString
        if  !urlStr.hasPrefix(redirect_uri) {
            // 继续加载
            return true
        }
        
        // 判断是否授权成功
        let codeStr = "code="
        if ((request.URL!.query?.hasPrefix(codeStr)) != nil)
        {
            // 授权成功
            // 1. 取出已经授权的requestToken
            let code = request.URL!.query?.substringFromIndex(codeStr.endIndex)
            
            // 2.利用已经授权的requestToken换取AccessToken
            loadAccessToken(code!)
            
        }else{
            // 取消授权
            colse()
        }
        
        return false
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.showInfoWithStatus("正在加载中...", maskType: SVProgressHUDMaskType.Black)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        // 关闭提示
        SVProgressHUD.dismiss()
    }
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        SVProgressHUD.showErrorWithStatus("加载失败");
    }
    private func colse ()
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    private func loadAccessToken(code:String)
    {
        // 1.定义路径
        let path = "oauth2/access_token"
        // 2.封装参数
        let params = ["client_id":client_id, "client_secret":App_Secret, "grant_type":"authorization_code", "code":code, "redirect_uri":redirect_uri]
        // 3. 发送POST请求
    
        ZENetWorkTools.shareNetworkTools().POST(path, parameters: params, progress: nil, success: { (_, JSON) in
            print("JSON\(JSON)")
            let account = ZEUserAccount.init(dict: JSON as![String:AnyObject])
            print(account)
            account.loadUserInfo({ (account, error) in
                if account != nil
                {
                    account!.saveAccount()
                }
                // 发出通知
                NSNotificationCenter.defaultCenter().postNotificationName(switchRootViewControllerKey, object: false)
                return
            })
            
            
            SVProgressHUD.showInfoWithStatus("网络不给力", maskType: SVProgressHUDMaskType.Black)
            
            }) { (_, error) in
            print(error)
                
        }
        
    }
}














