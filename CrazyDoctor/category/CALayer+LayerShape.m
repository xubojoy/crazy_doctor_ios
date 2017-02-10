//
//  CALayer+LayerShape.m
//  CA2
//
//  Created by lx on 16/3/19.
//  Copyright (c) 2016年 Beyond. All rights reserved.
//

#import "CALayer+LayerShape.h"
#import <UIKit/UIKit.h>
#define kBaseWAndH 100.0

@implementation CALayer (LayerShape)


+ (CALayer *)heartLayerMaskWith:(CGRect)bounds{
    
    CGFloat scale = bounds.size.width/kBaseWAndH;
    

    CAShapeLayer *layer = [CAShapeLayer new];
    
    CGMutablePathRef path = CGPathCreateMutable();
    

    CGPathMoveToPoint(path, NULL, bounds.size.width/2.0, bounds.size.height/5.0);
    CGPathAddCurveToPoint(path, NULL, bounds.size.width/5.0+5*scale, -21*scale, -33*scale, bounds.size.height/3.0+8*scale, bounds.size.width/2.0, bounds.size.height-8*scale);
    
    CGPathAddCurveToPoint(path, NULL, bounds.size.width+33*scale, bounds.size.height/3.0+8*scale, bounds.size.width/5.0*4.0-5*scale, -21*scale, bounds.size.width/2.0, bounds.size.height/5.0);
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.path = path;
    layer.bounds = bounds;
    layer.position = CGPointMake(bounds.size.width/2, bounds.size.height/2);
    CGPathRelease(path);
    return layer;
}
@end
