//
//  DiscoverIndexCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/25.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "DiscoverIndexCell.h"

@implementation DiscoverIndexCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLabel.layer.borderColor = [ColorUtils colorWithHexString:common_app_text_color].CGColor;
    self.titleLabel.layer.borderWidth = splite_line_height;
}

- (void)renderDiscoverIndexCellWith:(NSString *)icon title:(NSString *)title{
    [self.orderPhysiotheraprBtn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    self.titleLabel.text = title;
}

- (IBAction)orderPhysiotheraprBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didOrderPhysiotheraprBtnClick:)]) {
        [self.delegate didOrderPhysiotheraprBtnClick:sender];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
