//
//  BHotCityCell.m
//  Bee
//
//  Created by 林洁 on 16/1/13.
//  Copyright © 2016年 Lin. All rights reserved.
//

#import "BHotCityCell.h"
#import "BAddressHeader.h"


@implementation BHotCityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier array:(NSArray *)cities{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = BG_CELL;
        NSLog(@">>>>>>>>>>cities>>>>>>>>%@",cities);
        [self initButtons:cities];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Event Response
- (void)buttonClick:(UIButton*)button{
    self.buttonClickBlock(button);
}

- (void)buttonWhenClick:(void (^)(UIButton *))block{
    self.buttonClickBlock = block;
}

#pragma mark - init
- (void)initButtons:(NSArray*)cities{
    for (int i = 0; i < [cities count]; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(15 + (i % 3) * (BUTTON_WIDTH + 15), 15 + (i / 3) * (15 + BUTTON_HEIGHT), BUTTON_WIDTH, BUTTON_HEIGHT);
        self.city = cities[i];
        if ([NSStringUtils isNotBlank:self.city.name]) {
           [button setTitle:self.city.name forState:UIControlStateNormal];
        }
        button.titleLabel.font = [UIFont systemFontOfSize:16.0];
        button.tintColor = [UIColor blackColor];
        button.backgroundColor = [UIColor whiteColor];
        button.layer.borderColor = [ColorUtils colorWithHexString:common_app_text_color].CGColor;
        button.layer.borderWidth = splite_line_height;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
    }
}


@end
