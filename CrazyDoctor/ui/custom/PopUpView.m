//
//  PopUpView.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/19.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "PopUpView.h"

@implementation PopUpView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"PopUpView" owner:self options:nil] objectAtIndex:0];
        self.frame = frame;
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.3;
    }
    return self;
}

@end
