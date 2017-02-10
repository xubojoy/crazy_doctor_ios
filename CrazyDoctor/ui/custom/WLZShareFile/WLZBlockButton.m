//
//  WLZBlockButton.m
//  WLZShareView
//
//  Created by lijiarui on 15/11/11.
//  Copyright © 2015年 lijiarui qq:81995383. All rights reserved.
//

#import "WLZBlockButton.h"
#import <QuartzCore/QuartzCore.h>
@implementation WLZBlockButton


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}


- (void)touchAction:(id)sender{
    _block(self);
    
    
}


@end
