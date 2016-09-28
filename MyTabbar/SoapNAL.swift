//
//  SoapNAL.swift
//  MyTabbar
//
//  Created by shoule on 16/6/3.
//  Copyright © 2016年 bestcake. All rights reserved.
//

import UIKit
//typealias SCHttpSuccessBlock = (AnyObject) -> ()

class SoapNAL: NSObject ,NSXMLParserDelegate{
//创建单例类
    
    class var shared: SoapNAL {
        return Inner.instance
    }
    struct Inner {
        static let instance = SoapNAL()
    }
    var soapBlock :SCHttpSuccessBlock?
    var xmlParser = NSXMLParser()
    var _MacthingElement = NSString()
    var _soapResults = NSMutableString()
    var elementFound = Bool()
    func parserSoapXML(soapData:NSMutableData, maching:NSString, block:SCHttpSuccessBlock){
        self.soapBlock=block;
        _MacthingElement=maching;
        xmlParser=NSXMLParser.init(data: soapData)
        xmlParser.delegate=self;
        xmlParser.parse()
    }
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
//        print(_soapResults)
        if (elementName == _MacthingElement) {
//            if (isIOS7) {
//                if (!_soapResults) {
//                    _soapResults = [[NSMutableString alloc] init];
//                }
//            }else{
//                _soapResults = [[NSMutableString alloc] init];
//            }
            _soapResults = NSMutableString ();
            self.elementFound = true;
        }
    }
    func parser(parser: NSXMLParser, foundCharacters string: String) {
//        print(_soapResults)
        if (elementFound) {

            _soapResults.appendString(string)
            //        NSLog(@"%@",_soapResults);
        }else{
//            [_soapResults appendString:@""];//超时或请求数据为空
            _soapResults.appendString("")
        }
//        print(_soapResults)
    }
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        self.soapBlock!(_soapResults);
        elementFound = false;
        // 强制放弃解析
        xmlParser.abortParsing()
    }
    func parserDidEndDocument(parser: NSXMLParser) {
        if (_soapResults == "") {
//            print(_soapResults)
        }
    }
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        if (_soapResults == "") {
//            print(_soapResults)
        }
    }
    
    
    
    
    
    
    
    
}