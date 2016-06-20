//
//  ZEUserAccount.swift
//  SwfitWeiBo
//
//  Created by lieon on 16/6/10.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

class ZEUserAccount: NSObject ,NSCoding {

    /// 用于调用access_token，接口获取授权后的access token。
    var access_token: String?
    /// access_token的生命周期，单位是秒数。
    var expires_in: NSNumber?{
        didSet{
            // 根据过期的秒数, 生成真正地过期时间
            expires_Date = NSDate(timeIntervalSinceNow: expires_in!.doubleValue)
            print(expires_Date)
        }
    }
    /// 当前授权用户的UID。
    var uid:String?
    
    // 保存用户过期时间
    var expires_Date:NSDate?
    // 用户头像地址(大图)
    var avatar_large:String?
    // 用户昵称
    var screen_name:String?
    
    var remind_in:String?
    
    override init() {
        
    }
    
    init(dict:[String:AnyObject])
    {
        super.init()
        setValuesForKeysWithDictionary(dict)
        
        
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    // 打印对象
    override var description: String
    {
        // 定义属性数组
        let properties = ["","",""]
        // 根据属性数组，将属性转换为字典
        let dict = self.dictionaryWithValuesForKeys(properties)
        // 将字典转换为字符串
        return "\(dict)"
        
        
        
    }
    
    func loadUserInfo(finished:(account:ZEUserAccount?,error:NSError?)->())
    {
        assert(access_token != nil," 没有授权")
        
        let path = "2/users/show.json"
        let  params = ["access_token":access_token!, "uid":uid!]
        
        ZENetWorkTools .shareNetworkTools().GET(path, parameters: params, success: { (_, JSON) in
            
            // 1.判断字典是否有值
            if  let dic = JSON as? [String:AnyObject]
            {
                self.screen_name = dic["screen_name"] as? String
                self.avatar_large = dic["avatar_large"] as? String
                // 回调用户信息
                finished(account: self, error: nil)
            }
            }) { (_, error) in
                print("error")
                // 回调错误信息
                finished(account: nil, error: error)
        }
    }
    // MARK:- 保存和读取数据模型
    // 保存数据模型
    func saveAccount()
    {
        NSKeyedArchiver.archiveRootObject(self, toFile: "account.plist".cacheDir())
    }
    
    //  加载数据模型
    static var account: ZEUserAccount?
    
    class func loadAccount() -> ZEUserAccount?
    {
        if account != nil {
            return account!
        }
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
        let filePath = (path as NSString).stringByAppendingPathComponent("account.plist")
        print("filePath \(filePath)")
         account =
        NSKeyedUnarchiver.unarchiveObjectWithFile("account.plist".cacheDir()
        ) as? ZEUserAccount
        
        // 3.判断授权信息是否过期
        // 2020-09-08 03:49:39                       2020-09-09 03:49:39
        if account?.expires_Date?.compare(NSDate()) == NSComparisonResult.OrderedAscending
        {
            // 已经过期
            return nil
        }
        
        
        return account
    }
    
    class func userLogin() ->Bool
    {
        return (ZEUserAccount.loadAccount() != nil)
    }
    
    // MARK:- NSCoding
    // 将对象写入文件
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey:"access_token")
        aCoder.encodeObject(expires_in, forKey: "expires_in")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(expires_Date, forKey: "expires_Date")
        aCoder.encodeObject(screen_name, forKey: "screen_name")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
        
        aCoder.encodeObject(remind_in, forKey: "remind_in")
    }
    
    // 从文件中获取对象
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expires_in = aDecoder.decodeObjectForKey("expires_in") as? NSNumber
        uid = aDecoder.decodeObjectForKey("uid") as? String
        expires_Date = aDecoder.decodeObjectForKey("expires_Date") as? NSDate
        screen_name = aDecoder.decodeObjectForKey("screen_name")  as? String
        avatar_large = aDecoder.decodeObjectForKey("avatar_large")  as? String
        remind_in = aDecoder.decodeObjectForKey("remind_in")  as? String

    }
}
