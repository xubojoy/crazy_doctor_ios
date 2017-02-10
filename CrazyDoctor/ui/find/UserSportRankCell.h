//
//  UserSportRankCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/25.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharkeySort.h"
@interface UserSportRankCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userImgView;


@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *userRankLabel;


@property (weak, nonatomic) IBOutlet UIImageView *userGenderIngView;

@property (weak, nonatomic) IBOutlet UILabel *stepNumLabel;


- (void)renderUserSportRankCell:(SharkeySort *)sharkeySort;


@end
