//
//  CALayer+LayerShape.h
//  CA2
//
//  Created by lx on 16/3/19.
//  Copyright (c) 2016年 Beyond. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (LayerShape)

+ (CALayer*)heartLayerMaskWith:(CGRect)bounds;
@end
