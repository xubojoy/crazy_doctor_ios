//
//  CheckMeridiansRegulationCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/4.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "CheckMeridiansRegulationCell.h"

@implementation CheckMeridiansRegulationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.MeridianBtn.layer.borderWidth = splite_line_height;
    self.MeridianBtn.layer.borderColor = [ColorUtils colorWithHexString:@"#b9976c"].CGColor;
    [self.MeridianBtn setTitleColor:[ColorUtils colorWithHexString:gray_text_color] forState:UIControlStateNormal];
}

- (void)renderCheckMeridiansRegulationCell:(Acupoint *)acupoint{
    if ([NSStringUtils isNotBlank:acupoint.name]) {
        [self.MeridianBtn setTitle:acupoint.name forState:UIControlStateNormal];
    }
}

- (void)cellWithData:(PainLevelModel *)model{
    if (model.isSelected) {
        [self.MeridianBtn setBackgroundColor:[ColorUtils colorWithHexString:common_app_text_color]];
        [self.MeridianBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        [self.MeridianBtn setBackgroundColor:[ColorUtils colorWithHexString:white_text_color]];
        [self.MeridianBtn setTitleColor:[ColorUtils colorWithHexString:gray_text_color] forState:UIControlStateNormal];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
