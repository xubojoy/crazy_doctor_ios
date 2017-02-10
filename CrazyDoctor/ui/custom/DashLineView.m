//
//  DashLineView.m
//  VideoPlayerTest
//
//  Created by xubojoy on 15/7/2.
//  Copyright (c) 2015年 xubojoy. All rights reserved.
//

#import "DashLineView.h"

@implementation DashLineView

-(void)setLineColor:(UIColor *)lineColor LineWidth:(CGFloat)lineWidth{
    _dashLineColor = lineColor;
    dashLineWidth = lineWidth;
}

- (void)drawRect:(CGRect)rect {
    if (dashLineWidth < self.frame.size.height) {
        //获得处理的上下文
        CGContextRef context =UIGraphicsGetCurrentContext();
        //开始一个起始路径
        CGContextBeginPath(context);
        //设置线条粗细宽度
        CGContextSetLineWidth(context, dashLineWidth);
        //设置线条的颜色
        CGContextSetStrokeColorWithColor(context, _dashLineColor.CGColor);
        //lengths说明虚线如何交替绘制,lengths的值{4，4}表示先绘制4个点，再跳过4个点，如此反复
        CGFloat lengths[] = {3,3};
        //画虚线
        CGContextSetLineDash(context, 0, lengths,2);
        //设置开始点的位置
        CGContextMoveToPoint(context, 0.0, 0.0);
        //设置终点的位置
        CGContextAddLineToPoint(context,0.0,self.frame.size.height);
        //开始绘制虚线
        CGContextStrokePath(context);
        //封闭当前线路
//        CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathEOFillStroke);
    }
}



@end
