//
//  UserSportRankCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/25.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "UserSportRankCell.h"

@implementation UserSportRankCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.userImgView.layer.cornerRadius = self.userImgView.frame.size.width/2;
    self.userImgView.layer.masksToBounds = YES;
    
    self.userNameLabel.textColor = [UIColor whiteColor];
    self.userRankLabel.textColor = [ColorUtils colorWithHexString:@"#efd6bc"];
    self.stepNumLabel.textColor = [ColorUtils colorWithHexString:@"#faefde"];
    
}

- (void)renderUserSportRankCell:(SharkeySort *)sharkeySort{
    self.userNameLabel.text = sharkeySort.name;
    [self.userImgView sd_setImageWithURL:[NSURL URLWithString:sharkeySort.avatarUrl] placeholderImage:[UIImage imageNamed:@""]];
    
    if (sharkeySort.userGender == 1) {
        self.userGenderIngView.image = [UIImage imageNamed:@"icon_s_man"];
    }else{
        self.userGenderIngView.image = [UIImage imageNamed:@"icon_s_woman"];
    }
    
    self.userRankLabel.text = [NSString stringWithFormat:@"第%d名",sharkeySort.orderInx];
    self.stepNumLabel.text = [NSString stringWithFormat:@"%d",sharkeySort.step];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
