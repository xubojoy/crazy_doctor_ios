//
//  MyWalletCommonCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/6/27.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "MyWalletCommonCell.h"

@implementation MyWalletCommonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLabel.font = [UIFont systemFontOfSize:big_font_size];
}

- (void)renderUserCenterCommonCellWithIcon:(NSString *)icon withTitle:(NSString *)title{
    self.iconImageView.image = [UIImage imageNamed:icon];
    self.titleLabel.text = title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
