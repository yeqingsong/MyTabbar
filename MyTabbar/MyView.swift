//
//  MyView.swift
//  MyTabbar
//
//  Created by shoule on 16/7/13.
//  Copyright © 2016年 bestcake. All rights reserved.
//

import UIKit


class MyView: UIView {
    var progress1  :CGFloat = 0.0
    
    func setProgress(progress:CGFloat) {
        self.drawRect(self.frame)
        progress1 = progress
        if (progress==1) {//加载完成时移除
            self.removeFromSuperview()
        }
    }
    override func drawRect(rect: CGRect) {
        print("asdadasdqqqqqwwwwwwww");
        let ctx = UIGraphicsGetCurrentContext();
        
        // 2.拼接路径
        let center = self.center;
        let radius = 25.0 - 2.0;
        let startA = 0;
        let endA = 0 + double_t(progress1) * M_PI * 2;
//        let path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
//        let path = UIBezierPath(arcCenter: center, radius: CGFloat(radius), startAngle: CGFloat(startA), endAngle: CGFloat(endA), clockwise: true);
       CGContextAddArc(ctx, self.center.x, self.center.y, CGFloat(radius), CGFloat(startA), CGFloat(endA), 0)
        
//        CGContextSetLineCap(ctx,CGLineCap.Round );
        
        CGContextSetLineWidth(ctx, 4);
        // 3.把路径添加到上下文
        CGContextSetStrokeColorWithColor(ctx,
                                         UIColor.redColor().CGColor);//创建颜色
//        CGContextAddPath(ctx, path.CGPath);
        CGContextDrawPath(ctx, CGPathDrawingMode.Stroke)
        
        // 4.把上下文渲染到视图
        CGContextStrokePath(ctx);
    }
}
