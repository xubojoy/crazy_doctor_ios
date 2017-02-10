//
//  SportResultRankCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/25.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserSharkeyData.h"
@interface SportResultRankCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *rankIndexLabel;

@property (weak, nonatomic) IBOutlet UIImageView *userImgView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *userGenderImgView;

@property (weak, nonatomic) IBOutlet UILabel *stepNumLabel;

@property (weak, nonatomic) IBOutlet UIView *downLine;


- (void)renderSportResultRankCell:(UserSharkeyData *)userSharkeyData;

@end
