//
//  ViewController.swift
//  MyTabbar
//
//  Created by shoule on 16/5/27.
//  Copyright © 2016年 bestcake. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    let tableView = UITableView()
    let dataArray = NSMutableArray()
    let titleArray = NSMutableArray()
    var imageArray = NSMutableArray()
    let scrollView = UIScrollView()
    var timer : NSTimer?
    var num = 1
    var contentOffsetX = CGFloat(0.0)
    var count = 0;
    
    let wself : ViewController?=nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor=UIColor.redColor()
        self.tableView.delegate=self
        self.tableView.dataSource=self
        self.tableView.frame=CGRectMake(0, 0, width, HEIGHT)
        self.tableView.backgroundColor=UIColor.whiteColor()
        tableView.showsVerticalScrollIndicator = false
        self.view.addSubview(tableView)
        self.tableView.tableFooterView=UIView()
        ///创建scrollView
        self.createScrollView()
        self.getdata()
        ///获取广告数据
        self.getAdvertisingData()
        
        //        for i in 1...100 {
        //            let str = "这就是帅气的数字"+String(i)
        //            dataArray.addObject(str)
        //        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        timer=NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector:#selector(timeChange) , userInfo: nil, repeats: true)
    }
    
    
    func getAdvertisingData () {
        let dic = NSMutableDictionary()
        dic.setObject("上海", forKey: "City")
        dic.setObject("ios", forKey: "platformtype")
        dic.setObject(locationString(), forKey: "timestamp")
        dic.setObject("1", forKey: "location")
        dic.setObject("app", forKey: "platformType")
        //        [dic setObject:[Utils locationString] forKey:@"timestamp"];
        dic.setObject(versionnum(), forKey: "versionnum")
        let  json1 = json(dic)
        
        let sign = md5String((json1 as String)+"12345678")
        
        let  schttpClient = SCHttpClient()
        
        schttpClient.SoapTheRequest(json1 as String, sign: sign, soapAction: KGetAdvertisingMainListurl, macthingElement: KGetAdvertisingMainListmaching, method: KGetAdvertisingMainListmethod, URL: AdvertisingWebServicesURL) { (soapResults) in
            print(soapResults)
            let arr = soapResults.objectForKey("Data")
            for dic1 in arr as! NSArray{
                let model = GuangGaoModel().ReturnProductModel(dic1 as! NSDictionary)
                self.imageArray.addObject(model)
            }
            self.scrollView.contentSize=CGSizeMake(CGFloat(self.imageArray.count+1)*width, 0)
            self.addImage()
        }
    }
    
    func addImage(){
        for i in 0...imageArray.count {
            let view = UIView()
            view.frame=CGRectMake(CGFloat(i)*width, 0, width, width*318/375)
            view.tag=i;
            view.clipsToBounds=true;
            scrollView.addSubview(view)
            let imageView = UIImageView()
            var model : GuangGaoModel?
            if i==0 {
                model = imageArray[imageArray.count-1] as? GuangGaoModel
            }else{
                model = imageArray[i-1] as? GuangGaoModel
            }
            imageView.frame=CGRectMake(0, 0, width, width*318/375)
            
            imageView.sd_setImageWithURL(NSURL(string: model!.ImgPath ), placeholderImage: nil)
            view.addSubview(imageView)
            
        }
        
        //        timer?.invalidate()
        //        timer=nil;
        scrollView.setContentOffset(CGPointMake(width, 0), animated: false)
        
        let view = scrollView.viewWithTag(1)
        view?.bounds=CGRectMake(0, 0, width, width*318/375)
        scrollView.bringSubviewToFront(view!)
        //        tableView.reloadData()
        
        
    }
    
    func createScrollView(){
        self.scrollView.frame=CGRectMake(0, 0, width, width*318/375)
        scrollView.delegate=self;
        scrollView.tag=100;
        scrollView.pagingEnabled=true;
        
        //        let wid = CGFloat(imageArray.count)*width
        tableView.tableHeaderView=scrollView
        
    }
    func timeChange() {
        
        //        print(num)
        if imageArray.count==0 {
            return
        }
        //        if num==0 {
        //            scrollView.setContentOffset(CGPointMake(width, 0), animated: true)
        //        }else{
        //
        //        }
        scrollView.setContentOffset(CGPointMake(CGFloat(num)*width, 0), animated: true)
        //        if num%imageArray.count==0 {
        //            scrollView.setContentOffset(CGPointMake(CGFloat(num%imageArray.count)*width, 0), animated: false)
        //        }else{
        //            scrollView.setContentOffset(CGPointMake(CGFloat(num%imageArray.count)*width, 0), animated: true)
        //        }
        
        
        //        if num==6 {
        //            let view = scrollView.viewWithTag(0)
        //            scrollView.bringSubviewToFront(view!)
        //        }else{
        //            let view = scrollView.viewWithTag(num)
        //            scrollView.bringSubviewToFront(view!)
        //        }
        
        num += 1
        
        
    }
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        //        [myTimer setFireDate:[NSDate distantFuture]];
        //        暂停定时器
        timer?.invalidate()
        timer=nil
        if scrollView.tag==100 {
            print(num)
            
            
            //            if num==0||num==4 {
            //
            //            }else{
            //                num = num%imageArray.count - 1
            //            }
            
            
        }
        
    }
    //    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    //        self.performSelector(#selector(startTime), withObject: nil, afterDelay: 3)
    //    }
    //    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
    //        self.performSelector(#selector(startTime), withObject: nil, afterDelay: 3)
    //    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //        print(scrollView.contentOffset.x);
        //        if scrollView.tag==100 && timer==nil {
        //            let xx = scrollView.contentOffset.x
        //            if xx>=1656.0||xx<=0.0 {
        //                return
        //            }
        //            ///左右滑动
        //            if xx>=contentOffsetX {
        //
        //                if num==4 {
        //                     print(num)
        //                }else{
        //                    num = num%imageArray.count + 1
        //                }
        //
        //            }else{
        //                if num==0 {
        //                     print(num)
        //                }else{
        //                    num = num%imageArray.count - 1
        //                }
        //            }
        //            print(num)
        //        }
        
        
        print(num)
        if scrollView.tag==100 {
            
            //            // 如果当前页是第0页就跳转到数组中最后一个地方进行跳转
            //            if num == 0 {
            //                scrollView.setContentOffset(CGPointMake(width, 0), animated: false)
            //                num=1;
            //            }else if num == imageArray.count+2 {
            //                // 如果是第最后一页就跳转到数组第一个元素的地点
            //                scrollView.setContentOffset(CGPointMake(0, 0), animated: false);
            //                num=0;
            //            }
            //            //            self.performSelector(#selector(startTime), withObject: nil, afterDelay: 3)
            
            
            let page = scrollView.contentOffset.x / scrollView.frame.size.width;
            print(page)
            
            if page>CGFloat(imageArray.count) {
                scrollView.setContentOffset(CGPointMake(0, 0), animated: false)
                num=0;
            }else if page<0 {
                scrollView.setContentOffset(CGPointMake(width*CGFloat(imageArray.count), 0), animated: false)
                num=imageArray.count-1;
            }
        }
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        
        //        if scrollView.tag==100 {
        //            let page = scrollView.contentOffset.x / scrollView.frame.size.width;
        //            // 如果当前页是第0页就跳转到数组中最后一个地方进行跳转
        //            if page == 0 {
        //                 scrollView.setContentOffset(CGPointMake(CGFloat(num%imageArray.count)*width, 0), animated: false)
        //            }else if page == CGFloat(imageArray.count + 2){
        //                // 如果是第最后一页就跳转到数组第一个元素的地点
        //                 scrollView.setContentOffset(CGPointMake(width, 0), animated: false);
        //            }
        ////            self.performSelector(#selector(startTime), withObject: nil, afterDelay: 3)
        //        }
        let page = scrollView.contentOffset.x / scrollView.frame.size.width;
        num = NSInteger(page)
        print(num)
        //        let point = scrollView.contentOffset
        //        contentOffsetX = point.x
        self.startTime(scrollView)
        //        self.performSelector(#selector(startTime), withObject: scrollView, afterDelay: 2)
    }
    func startTime(scrollView:UIScrollView){
        //开启定时器
        //        timer?.fireDate=NSDate.distantPast()
        //        let point = scrollView.contentOffset
        //        if contentOffsetX==point.x {
        timer=nil
        timer?.invalidate()
        if timer==nil {
            timer=NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector:#selector(timeChange) , userInfo: nil, repeats: true)
            //            }else{
            //                //            timer=nil
            //                //            timer?.invalidate()
            //                //            timer=NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector:#selector(timeChange) , userInfo: nil, repeats: true)
            //            }
        }
        
        
        
    }
    func getdata () {
        let dic = NSMutableDictionary()
        self.dataArray.removeAllObjects()
        dic.setObject("上海", forKey: "City")
        dic.setObject("ios", forKey: "platformtype")
        dic.setObject(locationString(), forKey: "timestamp")
        //        [dic setObject:[Utils locationString] forKey:@"timestamp"];
        dic.setObject(versionnum(), forKey: "versionnum")
        let  json1 = json(dic)
        
        let sign = md5String((json1 as String)+"12345678")
        
        let  schttpClient = SCHttpClient()
        
        schttpClient.SoapTheRequest(json1 as String, sign: sign, soapAction: KGetHomePageModuleListurl, macthingElement: KGetHomePageModuleListmaching, method: KGetHomePageModuleListmethod, URL: AdvertisingWebServicesURL) { (soapResults) in
            print(soapResults)
            let arr=soapResults.objectForKey("Data")
            for dic in arr as! NSArray{
                let ModuleInfoListArr=NSMutableArray()
                let arr1 = dic.objectForKey("ModuleInfoList")
                for dic1 in arr1 as! NSArray{
                    let dic2 = dic1.objectForKey("HomePageProductList")
                    let product = ProductModel().ReturnProductModel(dic2 as! NSDictionary, ModuleInfoListdic: dic1 as! NSDictionary)
                    ModuleInfoListArr.addObject(product)
                }
                self.titleArray.addObject(dic.objectForKey("Title")!)
                self.dataArray.addObject(ModuleInfoListArr)
            }
            self.tableView.reloadData()
        }
        print(self.dataArray)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let arr = dataArray[section];
        if section==1 {
            return arr.count-1
        }
        return arr.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataArray.count;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch (indexPath.section) {
        case 0:
            return  128*width/375.0;
            
        case 1:
            if (indexPath.row==0) {
                return   226*width/375.0;
            }
            return  170*width/375.0;
        case 2:
            return  226*width/375.0;
        case 3:
            return  344*width/375.0;
        default: return 0;
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let array = dataArray[indexPath.section] as! NSArray;
        var cell : TableViewCell?
        if indexPath.section==0 {
            cell  = tableView.dequeueReusableCellWithIdentifier("freeCell") as? TableViewCell
            
            if (cell == nil) {
                cell=NSBundle.mainBundle().loadNibNamed("TableViewCell", owner: nil, options: nil)[0] as? TableViewCell
            }
            
            let product :ProductModel = array[indexPath.row] as! ProductModel
            
            //            cell!.sec1Image1.sd_setImageWithURL(NSURL(string: product.ImgPath), placeholderImage: nil)
            cell?.sec1Image1.sd_setImageWithURL(NSURL(string: product.ImgPath), placeholderImage: nil, options: SDWebImageOptions.RetryFailed, progress: { ( receivedSize, expectedSize) in
                //                showHMProgressView((cell?.sec1Image1)!, Progress: CGFloat(receivedSize/expectedSize) )
                }, completed: nil)
        }else if indexPath.section==1{
            
            if indexPath.row==0 {
                cell=NSBundle.mainBundle().loadNibNamed("TableViewCell", owner: nil, options: nil)[1] as? TableViewCell
                let product0 :ProductModel = array[0] as! ProductModel
                let product1 :ProductModel = array[1] as! ProductModel
                cell!.sec2Image1.sd_setImageWithURL(NSURL(string: product0.ImgPath), placeholderImage: nil)
                cell!.sec2Image2.sd_setImageWithURL(NSURL(string: product1.ImgPath), placeholderImage: nil)
            }else{
                cell  = tableView.dequeueReusableCellWithIdentifier("stormCell") as? TableViewCell
                
                if (cell == nil) {
                    cell=NSBundle.mainBundle().loadNibNamed("TableViewCell", owner: nil, options: nil)[2] as? TableViewCell
                }
                
                let product :ProductModel = array[indexPath.row+1] as! ProductModel
                
                cell!.sec2Image3.sd_setImageWithURL(NSURL(string: product.ImgPath), placeholderImage: nil)
            }
            
        }else if indexPath.section==2{
            cell  = tableView.dequeueReusableCellWithIdentifier("choiceCell") as? TableViewCell
            
            if (cell == nil) {
                cell=NSBundle.mainBundle().loadNibNamed("TableViewCell", owner: nil, options: nil)[3] as? TableViewCell
            }
            
            let product :ProductModel = array[indexPath.row] as! ProductModel
            
            cell?.sec3Image1.sd_setImageWithURL(NSURL(string: product.ImgPath), placeholderImage: nil)
        }else if indexPath.section==3{
            cell  = tableView.dequeueReusableCellWithIdentifier("comboCell") as? TableViewCell
            
            if (cell == nil) {
                cell=NSBundle.mainBundle().loadNibNamed("TableViewCell", owner: nil, options: nil)[4] as? TableViewCell
            }
            
            let product :ProductModel = array[indexPath.row] as! ProductModel
            
            cell!.comboImage1.sd_setImageWithURL(NSURL(string: product.ImgPath), placeholderImage: nil)
        }
        
        
        cell?.selectionStyle=UITableViewCellSelectionStyle.None;
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //        self.getdata()
        //        self.navigationController?.pushViewController(childViewController(), animated: true)
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleLabel = UILabel();
        titleLabel.text=self.titleArray[section] as? String;
        titleLabel.frame=CGRectMake(0, 0, width, 44);
        titleLabel.backgroundColor=UIColor.whiteColor()
        return titleLabel;
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

