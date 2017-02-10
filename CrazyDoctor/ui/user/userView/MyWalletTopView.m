//
//  MyWalletTopView.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/6/27.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "MyWalletTopView.h"

@implementation MyWalletTopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"MyWalletTopView" owner:self options:nil] objectAtIndex:0];
        self.frame = frame;
        
    }
    return self;
}

@end
