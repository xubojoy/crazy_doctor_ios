//
//  SportResultRankCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/25.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "SportResultRankCell.h"

@implementation SportResultRankCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
    
    self.userImgView.layer.cornerRadius = self.userImgView.frame.size.width/2;
    self.userImgView.layer.masksToBounds = YES;
    
    self.stepNumLabel.textColor = [ColorUtils colorWithHexString:@"#ca7e5c"];
}
- (void)renderSportResultRankCell:(UserSharkeyData *)userSharkeyData{
    self.userNameLabel.text = userSharkeyData.name;
    [self.userImgView sd_setImageWithURL:[NSURL URLWithString:userSharkeyData.avatarUrl] placeholderImage:[UIImage imageNamed:@""]];
    
    if (userSharkeyData.userGender == 1) {
        self.userGenderImgView.image = [UIImage imageNamed:@"icon_s_man"];
    }else{
        self.userGenderImgView.image = [UIImage imageNamed:@"icon_s_woman"];
    }
    self.rankIndexLabel.text = [NSString stringWithFormat:@"%d",userSharkeyData.orderInx];
    self.stepNumLabel.text = [NSString stringWithFormat:@"%d",userSharkeyData.step];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
