//
//  ZTTabBar.swift
//  MyTabbar
//
//  Created by shoule on 16/5/27.
//  Copyright © 2016年 bestcake. All rights reserved.
//

import UIKit

protocol MYTabBarDelegate {
    func selectedIndex(index: Int)
}


class ZTTabBar: UIView {
    
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        self.backgroundColor = UIColor.whiteColor()
//        fatalError("init(coder:) has not been implemented")
//    }
    var delegate1: MYTabBarDelegate?
    var lastSelectButton = MYButton()
    ///滑动色块view
    let colorView = UIView()
    
    
    
    func addImageAddTitleButton(title:String,img:String,index:CGFloat) {
        
        
        //新建一个按钮用来记录image图片
        let button = MYButton(type: UIButtonType.Custom)
        button.frame=CGRectMake(index*width/5, 0, width/5, 49)
        button.addTarget(self, action:#selector(dianji), forControlEvents: UIControlEvents.TouchUpInside)
        button.tag=Int(index)
        button.selectImage=img+"_red"
        button.defaultImage=img
       
        
        //image图片
        let x = (width/5-22)/2
        let image = UIImageView(frame:CGRectMake(x, 4, 22, 22))
        
        image.tag=10+Int(index)
        
        
        //label
        let label = UILabel(frame:CGRectMake(0, 30, width/5 , 19))
        label.text=title
        label.font=UIFont.systemFontOfSize(13.0)
        label.textAlignment=NSTextAlignment.Center
        label.tag=20+Int(index)
        
        
        if Int(index)==0 {
            image.image=UIImage(named: button.selectImage as String)
            button.selected=true;
            lastSelectButton=button;
            label.textColor = RGBA(255, g: 255, b: 255, a: 1)
            //滑动色块
            colorView.frame=button.frame
            colorView.backgroundColor=RGBA(161, g: 127, b: 74, a: 1)
            self.addSubview(colorView)
        }else{
            label.textColor = RGBA(80, g: 80, b: 80, a: 1)
            image.image=UIImage(named: img)
        }
        self.addSubview(button)
        button.addSubview(image)
        button.addSubview(label)
        
        
    }
    func dianji(sender:MYButton)  {
//        print(sender.tag);
//        print("165451");
        if lastSelectButton==sender {
            return
        }
        //更改image图片
        let lastImageView = lastSelectButton.viewWithTag(lastSelectButton.tag+10) as! UIImageView
        lastImageView.image=UIImage(named: lastSelectButton.defaultImage as String)
        
        let nowImageView = sender.viewWithTag(sender.tag+10) as! UIImageView
        nowImageView.image=UIImage(named: sender.selectImage as String)
        

        //更改label字体颜色
        let lastLabel = lastSelectButton.viewWithTag(lastSelectButton.tag+20) as! UILabel
        lastLabel.textColor = RGBA(51, g: 51, b: 51, a: 1)
        
        let nowLabel = sender.viewWithTag(sender.tag+20) as! UILabel
        nowLabel.textColor = RGBA(255, g: 255, b: 255, a: 1)
        UIView.animateWithDuration(0.2) { 
            self.colorView.frame=sender.frame
        }
        
        delegate1?.selectedIndex(sender.tag)
        lastSelectButton=sender;
    }
    
}
















