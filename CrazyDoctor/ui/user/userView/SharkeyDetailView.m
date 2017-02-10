//
//  SharkeyDetailView.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/27.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "SharkeyDetailView.h"

@implementation SharkeyDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"SharkeyDetailView" owner:self options:nil] objectAtIndex:0];
        self.frame = frame;
        
    }
    return self;
}

@end
