//
//  NavViewController.swift
//  MyTabbar
//
//  Created by shoule on 16/6/1.
//  Copyright © 2016年 bestcake. All rights reserved.
//

import UIKit

class NavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
            }
    override func pushViewController(viewController: UIViewController, animated: Bool){
        super.pushViewController(viewController, animated: true)
//        if UIApplication.sharedApplication().keyWindow?.rootViewController ==t {
//            <#code#>
//        }
        
        //用来判断push到2级界面是隐藏tabbar
        if ((UIApplication.sharedApplication().keyWindow?.rootViewController) != nil)  {
            let tabVIewCon = UIApplication.sharedApplication().keyWindow?.rootViewController as! TabBarViewController
            //            let frame=CGRectMake(, <#T##y: CGFloat##CGFloat#>, <#T##width: CGFloat##CGFloat#>, <#T##height: CGFloat##CGFloat#>)
            tabVIewCon.mytabbar.hidden=true
        }
        
    }
    override func popViewControllerAnimated(animated: Bool) -> UIViewController?{
        let viewCon = super.popViewControllerAnimated(true)
        let tabVIewCon = UIApplication.sharedApplication().keyWindow?.rootViewController as! TabBarViewController
        //用来判断pop到1级界面是显示tabbar
        print( tabVIewCon.viewControllers?.count)
        if self.viewControllers.count<=1 {
            tabVIewCon.mytabbar.hidden=false
        }
        
        
        return viewCon
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
