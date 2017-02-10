//
//  SectionHeaderViewCollectionReusableView.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/18.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "SectionHeaderViewCollectionReusableView.h"

@implementation SectionHeaderViewCollectionReusableView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createViews];
    }
    return self;
}

-(void)createViews
{
    _titleLabel = [[UILabel alloc]init];
    [self addSubview:_titleLabel];
    
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(0, 0, screen_width-150-15-10, 20);
    _titleLabel.font = [UIFont systemFontOfSize:10];
    _titleLabel.textColor = [ColorUtils colorWithHexString:light_gray_text_color];
}

@end
