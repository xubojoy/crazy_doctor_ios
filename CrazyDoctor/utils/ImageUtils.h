//
//  ImageUtils.h
//  styler
//
//  Created by System Administrator on 13-5-23.
//  Copyright (c) 2013年 mlzj. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ImageUtils : NSObject

+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

+(UIImage*) MTDContextCreateRoundedMask:(CGRect) rect tl:(CGFloat)radius_tl tr:(CGFloat) radius_tr bl:(CGFloat) radius_bl br:(CGFloat) radius_br;
+(UIImage *)imageFromImage:(UIImage *)image andEdgeInsets:(UIEdgeInsets)edgeInsets;

+(UIImage *)createPureColorImage:(CGSize)size andColor:(UIColor *)color;

+ (UIImage *)resizableBgImage:(UIImage *)image;
@end
