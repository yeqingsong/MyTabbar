//
//  SCHttpClient.swift
//  MyTabbar
//
//  Created by shoule on 16/6/2.
//  Copyright © 2016年 bestcake. All rights reserved.
//

import UIKit
typealias SCHttpSuccessBlock = (AnyObject) -> ()

class SCHttpClient: NSObject,NSURLConnectionDataDelegate,NSURLSessionDelegate,NSURLSessionDataDelegate {
    
    var _machingElement = String()
    var soapData = NSMutableData()
    class var shared: SCHttpClient {
        return Inner.instance
    }
    struct Inner {
        static let instance = SCHttpClient()
    }
    var successBlock : SCHttpSuccessBlock?
    
    func SoapTheRequest(json:String ,sign:String ,soapAction:String ,macthingElement:String, method:String, URL:String , sucess:SCHttpSuccessBlock ) {
        _machingElement=macthingElement
        //创建SOAP信息

        let soapMsg = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"+"<soap:Envelope "+"xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "+"xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "+"xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"+"<soap:Body>"+"<\(method) xmlns=\"http://tempuri.org/\">"+"<json>\(json)</json>"+"<sign>\(sign)</sign>"+"</\(method)>"+"</soap:Body>"+"</soap:Envelope>"
        
//        "<?xml version=\"1.0\" encoding=\"utf-8\"?> \n <soap:Envelope \n xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" \n xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" \n xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"> \n <soap:Body> \n <\(method) xmlns=\"http://tempuri.org/\"> \n <json>\(json)</json> \n <sign>\(sign)</sign> \n </\(method)> \n </soap:Body> \n </soap:Envelope>"
//        let request = NSMutableURLRequest(URL: NSURL(string: URL)!)
//        let len = HTTPBody.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        
        
        
        let request = NSMutableURLRequest()
        request.URL=NSURL(string: URL)
        let msgLength = NSString(format: "%d" ,(NSString(string: soapMsg).length))
//        let msgLength = soapMsg.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        // 添加请求的详细信息，与请求报文前半部分的各字段对应
        request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue(String(msgLength), forHTTPHeaderField: "Content-Length")
        request.addValue(soapAction, forHTTPHeaderField: "SOAPAction")
//        request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod="POST"
        request.timeoutInterval=30
        ///这里的4是什么意思
        request.HTTPBody=soapMsg.dataUsingEncoding(NSUTF8StringEncoding)
        
        let manager = AFURLSessionManager.init(sessionConfiguration: NSURLSessionConfiguration.defaultSessionConfiguration());
        manager.responseSerializer=AFHTTPResponseSerializer();
        manager.dataTaskWithRequest(request) { (response, object, error) in
            if error==nil {
                let data:NSData = object as! NSData;
                SoapNAL.sharedInstance.parserSoapXML(data , maching: macthingElement) { (parserXML) in
                    let mstr = parserXML as! NSMutableString
                    let str="null"
                    var substr = mstr.rangeOfString(str)
                    while(substr.location != NSNotFound) {
                        //                [mstr replaceCharactersInRange:substr withString:@"\"\""];
                        mstr.replaceCharactersInRange(substr, withString: "\"\"")
                        substr = mstr.rangeOfString(str);
                    }
                    let str3="(\"\")"
                    var substr3 = mstr.rangeOfString(str3)
                    while(substr3.location != NSNotFound) {
                        //                [mstr replaceCharactersInRange:substr withString:@"\"\""];
                        mstr.deleteCharactersInRange(mstr.rangeOfString(str3))
                        substr3 = mstr.rangeOfString(str3);
                    }
                    let data1111=mstr.dataUsingEncoding(NSUTF8StringEncoding)
                    let result=try?NSJSONSerialization.JSONObjectWithData(data1111!, options: [])
                    sucess(result!)
                }

            }else{
                print("Error: %@, %@, %@", error, response, object);
            }
            }.resume();
        
        
        
//       //使用NSURLSession
//        let Session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: self, delegateQueue: NSOperationQueue())
//        soapData=NSMutableData();
//        Session.dataTaskWithRequest(request).resume()
//        
//        
//        
////        print(soapMsg)
/////使用NSURLConnection
////        let connection = NSURLConnection(request: request, delegate: self)
////        if ((connection) != nil) {
////            soapData=NSMutableData();
////        }
//        
//        
//        
//        self.successBlock = sucess
    }
    
    
//    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveResponse response: NSURLResponse, completionHandler: (NSURLSessionResponseDisposition) -> Void) {
//        print(completionHandler);
//        print("didReceiveResponse,\(response),\n \(dataTask)")
////        completionHandler = NSURLSessionResponseDisposition.Allow
//        
//        
//    }
    
    //这个方法与上面注释的方法只能存在一个,上面的方法优先级高于本方法同时存在会执行上面的方法
//    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
//        soapData!.appendData(data)
//        
//        SoapNAL.sharedInstance.parserSoapXML(soapData!, maching: _machingElement) { (parserXML) in
//            let mstr = parserXML as! NSMutableString
//            let str="null"
//            var substr = mstr.rangeOfString(str)
//            while(substr.location != NSNotFound) {
//                //                [mstr replaceCharactersInRange:substr withString:@"\"\""];
//                mstr.replaceCharactersInRange(substr, withString: "\"\"")
//                substr = mstr.rangeOfString(str);
//            }
//            let str3="(\"\")"
//            var substr3 = mstr.rangeOfString(str3)
//            while(substr3.location != NSNotFound) {
//                //                [mstr replaceCharactersInRange:substr withString:@"\"\""];
//                mstr.deleteCharactersInRange(mstr.rangeOfString(str3))
//                substr3 = mstr.rangeOfString(str3);
//            }
//            let data1111=mstr.dataUsingEncoding(NSUTF8StringEncoding)
//            let result=try?NSJSONSerialization.JSONObjectWithData(data1111!, options: [])
//            self.successBlock?(result!)
//        }
//    }
//    
//    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
//        print(error)
//    }
    
    
    
    
//    //刚收到请求
//    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
//        soapData!.length=0
//        //        print("收到Response:\(response.MIMEType!)")
//        //将NSURLResponse对象转换成NSHTTPURLResponse对象
////        let Response = response as! NSHTTPURLResponse
////        let status = Response.statusCode
//        //        print("\(status)")
////        if (status >= 400) {
////            let msg="{\"Status\":400,\"Msg\":\"请求失败\",\"Data\":null}"
////            ClosureFunc(msg)
////        }
////        soapData = NSMutableData()
//    }
//    //拼接请求
//    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
//        soapData!.appendData(data)
//        
//        SoapNAL.shared.parserSoapXML(soapData!, maching: _machingElement) { (parserXML) in
//            let mstr = parserXML as! NSMutableString
//            let str="null"
//            var substr = mstr.rangeOfString(str)
//            while(substr.location != NSNotFound) {
////                [mstr replaceCharactersInRange:substr withString:@"\"\""];
//                mstr.replaceCharactersInRange(substr, withString: "\"\"")
//                substr = mstr.rangeOfString(str);
//            }
//            let str3="(\"\")"
//            var substr3 = mstr.rangeOfString(str3)
//            while(substr3.location != NSNotFound) {
//                //                [mstr replaceCharactersInRange:substr withString:@"\"\""];
//                mstr.deleteCharactersInRange(mstr.rangeOfString(str3))
//                substr3 = mstr.rangeOfString(str3);
//            }
//            let data1111=mstr.dataUsingEncoding(NSUTF8StringEncoding)
//            let result=try?NSJSONSerialization.JSONObjectWithData(data1111!, options: [])
//           self.successBlock?(result!)
//        }
//    }
//    //请求完成
//    func connectionDidFinishLoading(connection: NSURLConnection) {
//        
//    }
//    //请求失败
//    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
//        
//    }
    
}
