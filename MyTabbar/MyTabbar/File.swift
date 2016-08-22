//
//  File.swift
//  MyTabbar
//
//  Created by shoule on 16/5/31.
//  Copyright © 2016年 bestcake. All rights reserved.
//

import UIKit
let HEIGHT = UIScreen.mainScreen().bounds.size.height
let width = UIScreen.mainScreen().bounds.size.width
func RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat)->UIColor {return UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: a)}

//cs测试
//let Url = "http://api.cs.bestcake.com/"
////仿真
//let Url = "http://api.test.bestcake.com/"
////正式
let Url = "http://api.bestcake.com/"




let ActivityURL = Url+"Activities.svc?wsdl"
let WebServicesURL = Url+"Member.svc?wsdl"
let CompanyServicesURL = Url+"Company.svc?wsdl"
let MessageWebServicesURL = Url+"Message.svc?wsdl"
let OrderWebServicesURL = Url+"Order.svc?wsdl"
let ProductWebServicesURL = Url+"Product.svc?wsdl"
let HdProductWebServicesURL = Url+"Product.svc?wsdl"
let JZBWebServicesURL = Url+"MemberAccount.svc?wsdl"
let ZcWebServicesURL = Url+"Crowdfunding.svc?wsdl"
let DeliveryCloudWebServicesURL = Url+"DeliveryCloud.svc?wsdl"
let WeChatWebServicesURL = Url+"WeChatAttest.svc?wsdl"
let TaskURL = Url+"Task.svc?wsdl"
let ReceiveActivityURL = Url+"ReceiveActivity.svc?wsdl"
let DeliveryWebServicesURL = Url+"Delivery.svc?wsdl"
let AdvertisingWebServicesURL = Url+"Advertising.svc?wsdl"
let ShoppingCartWebServicesURL = Url+"ShoppingCart.svc?wsdl"

//活动列表
let KGetHomePageModuleListurl = "http://tempuri.org/IAdvertising/NewGetHomePageModuleList"
let KGetHomePageModuleListmethod = "NewGetHomePageModuleList"
let KGetHomePageModuleListmaching = "NewGetHomePageModuleListResult"

//查询广告表
let KGetAdvertisingMainListurl = "http://tempuri.org/IAdvertising/NewGetAdvertisingMainList"
let KGetAdvertisingMainListmethod = "NewGetAdvertisingMainList"
let KGetAdvertisingMainListmaching = "NewGetAdvertisingMainListResult"


 func md5String(str:String) -> String{
//    let cStr = (str as NSString).cStringUsingEncoding(NSUTF8StringEncoding)
//    let buffer = UnsafeMutablePointer<CUnsignedChar>.alloc(16)
//    let strLen = CC_LONG(str.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
//    CC_MD5(cStr,strLen, buffer)
//    let md5String = NSMutableString()
//    for i in 0 ..< 16{
//        md5String.appendFormat("%02X", buffer[Int(i)])
//    }
//    buffer.destroy();
////    free(buffer)
//    
//    return md5String as String;
    
    let cStr = str.cStringUsingEncoding(NSUTF8StringEncoding)
    let strLen = CC_LONG(str.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
    let DigestLen = Int(CC_MD5_DIGEST_LENGTH)
    let result = UnsafeMutablePointer<CUnsignedChar>.alloc(DigestLen)
    CC_MD5(cStr!, strLen, result)
    let hash = NSMutableString()
    for i in 0..<DigestLen {
        hash.appendFormat("%02x", result[i])
    }
    result.dealloc(DigestLen)
    return String(format: hash as String)
}
func json(dic:NSMutableDictionary) -> NSString{
    var paramsString = NSMutableString()
    var str = NSString()
    let jsonData = try!NSJSONSerialization.dataWithJSONObject(dic, options: NSJSONWritingOptions.PrettyPrinted)
    paramsString = NSMutableString.init(data: jsonData, encoding: NSUTF8StringEncoding)!
    str = paramsString.stringByReplacingOccurrencesOfString("\n", withString: "" )
    str = str.stringByReplacingOccurrencesOfString("\\", withString: "" )
    
//    let str1 = str.stringByReplacingOccurrencesOfString("\\", withString: "")
    print(str)
    print(NSString(string: str))
    return NSString(string: str) ;
    
}
func locationString() -> String{
    let date = NSDate(timeIntervalSinceNow:0)
    let dateformatter = NSDateFormatter();
    dateformatter.dateFormat="yyyy-MM-dd hh:mm:ss"
    let locationString = dateformatter.stringFromDate(date)
    return locationString;
}
//版本号
func versionnum()->String
{
//          [[NSBundle mai.nBundle]objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
    let versionnum1 = NSBundle.mainBundle().objectForInfoDictionaryKey(kCFBundleVersionKey as String)
    
   return versionnum1 as! String
}
func showHMProgressView(currentView:UIImageView, Progress:CGFloat)  {
    let myview = MyView()
    myview.bounds=currentView.bounds
    myview.setProgress(Progress)
    currentView.addSubview(myview);
}















