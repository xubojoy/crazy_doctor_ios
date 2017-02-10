//
//  BRecentCityCell.m
//  Bee
//
//  Created by 林洁 on 16/1/12.
//  Copyright © 2016年 Lin. All rights reserved.
//

#import "BRecentCityCell.h"
#import "BAddressHeader.h"

@implementation BRecentCityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cityArray:(NSMutableArray *)cities{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = BG_CELL;
        if (cities.count > 3) {
//            NSMutableArray *choseArray = [FunctionUtils getRandomDataArray:cities chooseNum:3];
            [cities removeObjectsInRange:NSMakeRange(0, (cities.count-3))];
            [self renderBRecentCityCellWithRecentArray:cities];
        }else{
            [self renderBRecentCityCellWithRecentArray:cities];
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Event Response
- (void)buttonWhenClick:(void (^)(UIButton *))block{
    self.buttonClickBlock = block;
}

- (void)buttonClick:(UIButton*)button{
    self.buttonClickBlock(button);
}

- (void)renderBRecentCityCellWithRecentArray:(NSMutableArray *)array{
    for (int i = 0; i < [array count]; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(15 + (i % 3) * (BUTTON_WIDTH + 15), 15 + (i / 3) * (15 + BUTTON_HEIGHT), BUTTON_WIDTH, BUTTON_HEIGHT);
        [button setTitle:array[i] forState:UIControlStateNormal];
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
