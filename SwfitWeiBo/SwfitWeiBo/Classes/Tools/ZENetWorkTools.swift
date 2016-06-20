//
//  ZENetWorkTools.swift
//  SwfitWeiBo
//
//  Created by apple on 16/5/31.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import AFNetworking

class ZENetWorkTools: AFHTTPSessionManager {
    
    static let tools :ZENetWorkTools = {
        let url = NSURL(string:"https://api.weibo.com/")
        let tool = ZENetWorkTools(baseURL:url)
        
        // 设置AFN能够接受的数据类型
        tool.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript", "text/plain") as? Set<String>
        return tool
    }()
    
    class func shareNetworkTools() -> ZENetWorkTools
    {
        return tools
    }
}
