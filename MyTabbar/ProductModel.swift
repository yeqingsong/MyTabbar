//
//  ProductModel.swift
//  MyTabbar
//
//  Created by shoule on 16/6/13.
//  Copyright © 2016年 bestcake. All rights reserved.
//

import UIKit

class ProductModel: NSObject {
    var Brand = ""
    var CategoryEName = ""
    var CategoryName = ""
    var ESweet = ""
    var Ename = ""
    var FilterName = ""
    var Name = ""
    var Price = ""
    var Size = ""
    var SupplyNo = ""
    var Sweet = ""
    var ZSweet = ""

    var Id = ""
    var ImgPath = ""
    var JumpId = ""
    var JumpType = ""
    var ModuleId = ""
    var OrderSource = ""
    var SellCount = ""
    var Sort = ""
    
    func ReturnProductModel(ProductListdic: NSDictionary,ModuleInfoListdic:NSDictionary) -> ProductModel {
        //产品详细信息解析
        self.Brand=(ProductListdic.MYobjectForKey("Brand"))as! String
        self.CategoryEName=(ProductListdic.MYobjectForKey("CategoryEName"))as! String
        self.CategoryName=(ProductListdic.MYobjectForKey("CategoryName"))as! String
        self.ESweet=(ProductListdic.MYobjectForKey("ESweet"))as! String
        self.Ename=(ProductListdic.MYobjectForKey("Ename"))as! String
        self.FilterName=(ProductListdic.MYobjectForKey("FilterName"))as! String
        self.Name=(ProductListdic.MYobjectForKey("Name"))as! String
        self.Price=(ProductListdic.MYobjectForKey("Price"))as! String
        self.Size=(ProductListdic.MYobjectForKey("Size"))as! String
        self.Sweet=(ProductListdic.MYobjectForKey("Sweet"))as! String
        self.ZSweet=(ProductListdic.MYobjectForKey("ZSweet"))as! String
        self.SupplyNo=(ProductListdic.MYobjectForKey("SupplyNo"))as! String
        
        //产品的外在类别参数
        self.Id=(ModuleInfoListdic.MYobjectForKey("Id"))as! String
        self.ImgPath=(ModuleInfoListdic.MYobjectForKey("ImgPath"))as! String
        self.JumpId=(ModuleInfoListdic.MYobjectForKey("JumpId"))as! String
        self.JumpType=(ModuleInfoListdic.MYobjectForKey("JumpType"))as! String
        self.ModuleId=(ModuleInfoListdic.MYobjectForKey("ModuleId"))as! String
        self.OrderSource=(ModuleInfoListdic.MYobjectForKey("OrderSource"))as! String
        self.Sort=(ModuleInfoListdic.MYobjectForKey("Sort"))as! String
        self.SupplyNo=(ModuleInfoListdic.MYobjectForKey("SupplyNo"))as! String
        self.SellCount=(ModuleInfoListdic.MYobjectForKey("SellCount"))as! String
        return self;
        
    }
}
