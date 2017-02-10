//
//  IndexTopGentleView.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/18.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "IndexTopGentleView.h"

@implementation IndexTopGentleView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"IndexTopGentleView" owner:self options:nil] objectAtIndex:0];
        self.frame = frame;
        
    }
    return self;
}


@end
