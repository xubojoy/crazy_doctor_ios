//
//  UserCenterCommonCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/20.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "UserCenterCommonCell.h"

@implementation UserCenterCommonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
}

- (void)renderUserCenterCommonCellWithIcon:(NSString *)icon withTitle:(NSString *)title showLine:(BOOL)show showRightArrow:(BOOL)showRightArrow{
    self.iconImageView.image = [UIImage imageNamed:icon];
    self.titleLabel.text = title;
    if (show) {
        self.downLine.hidden = NO;
    }else{
        self.downLine.hidden = YES;
    }
    
    if (showRightArrow) {
        self.rightArrowImgView.hidden = NO;
    }else{
        self.rightArrowImgView.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
