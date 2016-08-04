//
//  ZEModel.swift
//  SwfitWeiBo
//
//  Created by lieon on 16/8/4.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import ObjectMapper

class ZEModel: Mappable {

    
    var debugDescription: String {
        var str = "\n"
        let properties = Mirror(reflecting: self).children
        for c in properties {
            if let name = c.label {
                str += name + ": \(c.value)\n"
            }
        }
        return str
    }
    
     init() {
        
    }
    
    // MARK: Mappable
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        
    }
}