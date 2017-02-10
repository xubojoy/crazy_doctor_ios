//
//  DashLineView.h
//  VideoPlayerTest
//
//  Created by xubojoy on 15/7/2.
//  Copyright (c) 2015年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashLineView : UIView
{
    CGFloat dashLineWidth;//虚线粗细宽度
}
//虚线颜色
@property (strong, nonatomic)UIColor *dashLineColor;

-(void)setLineColor:(UIColor *)lineColor LineWidth:(CGFloat)lineWidth;

@end
