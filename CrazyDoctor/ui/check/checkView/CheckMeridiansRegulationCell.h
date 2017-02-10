//
//  CheckMeridiansRegulationCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/4.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Acupoint.h"
#import "PainLevelModel.h"
@interface CheckMeridiansRegulationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *MeridianBtn;

- (void)renderCheckMeridiansRegulationCell:(Acupoint *)acupoint;
- (void)cellWithData:(PainLevelModel *)model;
@end
