//
//  ZEStatus.swift
//  SwfitWeiBo
//
//  Created by lieon on 16/6/24.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

class ZEStatus: NSObject
{
    /**微博创建时间*/
    var created_at:String?
    /**微博ID*/
    var id:Int = 0
    /**微博信息内容*/
    var text:String?
    /**微博来源*/
    var source:String?
    /**配图数组*/
    var pic_urls :[[String:AnyObject]]?;
    
    /**
     *  加载微博数据（类方法）
     */
    class func loadStatuses(finished:(models:[ZEStatus]?,error:NSError?)->())
    {
        let path = "2/statuses/home_timeline.json"
        let params = ["access_token": ZEUserAccount.loadAccount()!.access_token!]
        ZENetWorkTools.shareNetworkTools().GET(path, parameters: params, progress: nil, success: { (_, JSON) in
            print(JSON)
            // 1.取出statuses key对应的数组 (存储的都是字典)
            // 2.遍历数组, 将字典转换为模型
            let models = dictArrayToModelArray(JSON!["statuses"] as! [[String:AnyObject]])
            finished(models: models, error: nil)
            }) { (_, error) in
                finished(models: nil, error: error)
        }
        
    }
    /**
     将字典数组转换为模型数组
     */
    
   class func dictArrayToModelArray(list:[[String:AnyObject]]) -> [ZEStatus]
    {
        var models = [ZEStatus]()
        for dict in list {
            models.append(ZEStatus(dict: dict))
        }
        return models
        
    }
    
    /**
     字典转模型
     */
    init(dict:[String:AnyObject])
    {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }

    // 打印当前模型
    var properties = ["created_at", "id", "text", "source", "pic_urls"]
    override var description: String {
        let dict = dictionaryWithValuesForKeys(properties)
        return "\(dict)"
    }
    
}
