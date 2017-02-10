//
//  WLZShareItem.m
//  WLZShareView
//
//  Created by lijiarui on 15/11/11.
//  Copyright © 2015年 lijiarui qq:81995383. All rights reserved.
//

#import "WLZShareItem.h"

@implementation WLZShareItem


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self subviewsInit];
    }
    return self;
}

- (void)subviewsInit
{
//    _logoImageView = [[UIImageView alloc]init];
//    _logoImageView.backgroundColor = [UIColor clearColor];
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:default_font_size];
    _titleLabel.textColor = [ColorUtils colorWithHexString:black_text_color];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _itemButton = [[WLZBlockButton alloc]init];
      _itemButton.backgroundColor = [UIColor clearColor];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self setUpViews];
}


- (void)setUpViews
{
//    _logoImageView.frame = CGRectMake((self.frame.size.width-54)/2, 0, 54, 54);
//    [self addSubview:_logoImageView];
    _itemButton.frame = CGRectMake((self.frame.size.width-54)/2, 0, 54, 54);
    [self addSubview:_itemButton];

    _titleLabel.frame = CGRectMake(0, CGRectGetMaxY(_itemButton.frame)+13, self.frame.size.width, 20);
    [self addSubview:_titleLabel];
    [self bringSubviewToFront:_itemButton];
}




@end
