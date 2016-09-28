//
//  GuangGaoModel.swift
//  MyTabbar
//
//  Created by shoule on 16/6/17.
//  Copyright © 2016年 bestcake. All rights reserved.
//

import UIKit

class GuangGaoModel: NSObject {
    var City = ""
    var Enable = ""
    var Id = ""
    var ImgPath = ""
    var JumpId = ""
    var JumpMenu = ""
    var Location = ""
    var PlatformType = ""
    var OrderSource = ""
    var Url = ""
    func ReturnProductModel(ProductListdic: NSDictionary) -> GuangGaoModel{
        self.City=(ProductListdic.MYobjectForKey("City"))as! String
        self.Enable=(ProductListdic.MYobjectForKey("Enable"))as! String
        self.Id=(ProductListdic.MYobjectForKey("Id"))as! String
        self.ImgPath=(ProductListdic.MYobjectForKey("ImgPath"))as! String
        self.JumpId=(ProductListdic.MYobjectForKey("JumpId"))as! String
        self.JumpMenu=(ProductListdic.MYobjectForKey("JumpMenu"))as! String
        self.Location=(ProductListdic.MYobjectForKey("Location"))as! String
        self.OrderSource=(ProductListdic.MYobjectForKey("OrderSource"))as! String
        self.PlatformType=(ProductListdic.MYobjectForKey("PlatformType"))as! String
        self.Url=(ProductListdic.MYobjectForKey("Url"))as! String
        return self;
    }
}
