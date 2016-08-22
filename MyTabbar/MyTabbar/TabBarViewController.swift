//
//  TabBarViewController.swift
//  MyTabbar
//
//  Created by shoule on 16/5/27.
//  Copyright © 2016年 bestcake. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController,MYTabBarDelegate {
    var titles = NSArray();
    var imgNames = NSArray();
    var index = NSInteger();
    let mytabbar = ZTTabBar()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        self.titles =  ["活动","蛋糕商城","语音下单","购物车","我的"]
        self.imgNames = ["active","cakemall","voice-function","shopping-cart","mine",]
        
        index=0
//        self.tabBar.delegate=self;
        self.tabBar.hidden=true;
        
        mytabbar.frame=self.tabBar.frame
        mytabbar.backgroundColor=UIColor.whiteColor()
        mytabbar.delegate1=self;
        
        
        var vc=UIViewController()
        
        for i in 0..<titles.count {
            switch i {
            case 0:
                vc=ViewController()
            case 1:
                vc=oneViewController()
            case 2:
                vc=twoViewController()
            case 3:
                vc=threeViewController()
            default:
                vc=FiveViewController()
            }

            self.addImageAddTitle(titles[i] as! String ,img:imgNames[i] as! String ,vc:vc)
            mytabbar.addImageAddTitleButton(titles[i] as! String, img: imgNames[i] as! String,index:CGFloat(i))
        }
//        var array = self.tabBar.subviews
//        print(self.tabBar.subviews)
        for view in self.tabBar.subviews {
            view.removeFromSuperview()
        }
//        print(self.tabBar.subviews)
        self.view.addSubview(mytabbar)
//        self.tabBar.bringSubviewToFront(mytabbar)
//        print(self.tabBar.subviews)
//        self.addImageAddTitle()
        
//        self.addChildViewController(ViewController());
//        self.addChildViewController(oneViewController());
//        self.addChildViewController(twoViewController());
//        self.addChildViewController(threeViewController());
//        self.addChildViewController(fourViewController());
//        let tabBar = ZTTabBar()
//        // 设置代理
//        tabBar.delegate = self
//        
        // KVC：如果要修系统的某些属性，但被设为readOnly，就是用KVC，即setValue：forKey：。
        // 修改tabBar为自定义tabBar
//        self.setValue(mytabbar, forKey: "tabBar")
        
        
//        self.selectedIndex(0);
    }
    
    func selectedIndex(index: Int) {
        print(self.tabBar.subviews)
        
        let animation = CATransition()
        animation.duration=0.3
        animation.delegate=self
        animation.timingFunction=CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.type=kCATransitionPush
        if self.selectedIndex<index {
            animation.subtype=kCATransitionFromLeft
        }else{
            animation.subtype=kCATransitionFromRight
        }
        
        self.selectedIndex=index;
        self.valueForKey("_viewControllerTransitionView")?.layer.addAnimation(animation, forKey: "animation")
    }
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        let vc = self.viewControllers![self.selectedIndex]
        UIView.animateWithDuration(0.1, animations: { 
            vc.view.frame=CGRectMake(-3, 0, width, HEIGHT);
            }) { (true) in
                UIView.animateWithDuration(0.1, animations: { 
                    vc.view.frame=CGRectMake(0, 0, width, HEIGHT);
                })
        }
        
    }
///创建tabbar
    func addImageAddTitle(title:String,img:String,vc:UIViewController){
        let  nav = NavViewController(rootViewController:vc)
        vc.title=title
        nav.tabBarItem.title=title
        nav.tabBarItem.image=UIImage(named :img)
//        [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : RGBColor(123, 123, 123)} forState:UIControlStateNormal];
//        [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]} forState:UIControlStateSelected];
        nav.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.blackColor()], forState: UIControlState.Normal)
        nav.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.redColor()], forState: UIControlState.Selected)
        self.addChildViewController(nav)
        print(self.tabBar.subviews)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
