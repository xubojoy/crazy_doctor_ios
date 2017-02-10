//
//  CollFirst.m
//  豆果美食
//
//  Created by 张琦 on 16/3/31.
//  Copyright © 2016年 张琦. All rights reserved.
//

#import "CollFirst.h"
@interface CollFirst ()
@property (nonatomic, strong) UILabel *labelTitle;
@end
@implementation CollFirst

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (screen_width-40) / 3, 40)];
    self.labelTitle.backgroundColor = [UIColor whiteColor];
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    self.labelTitle.textColor = [ColorUtils colorWithHexString:gray_text_color];
    self.labelTitle.layer.borderWidth = splite_line_height;
    self.labelTitle.layer.borderColor = [ColorUtils colorWithHexString:@"#b9976c"].CGColor;
    [self.contentView addSubview:self.labelTitle];
}

- (void)setName:(NSString *)name {
    _name = name;
    self.labelTitle.text = self.name;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
//    [self.labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(0);
//    }];
}

- (void)renderCollFirst:(BOOL)show{
    if (show) {
        [self.labelTitle setBackgroundColor:[ColorUtils colorWithHexString:common_app_text_color]];
        self.labelTitle.textColor = [UIColor whiteColor];
        
    }else{
        [self.labelTitle setBackgroundColor:[ColorUtils colorWithHexString:white_text_color]];
        self.labelTitle.textColor = [ColorUtils colorWithHexString:gray_text_color];
    }
}

@end
