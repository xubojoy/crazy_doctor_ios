//
//  SleepDetailCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/25.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SleepDetail.h"
@interface SleepDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLongLabel;

@property (weak, nonatomic) IBOutlet UILabel *deepSleepTimeLabel;

- (void)renderSleepDetailCellWithSleepDetail:(SleepDetail *)sleepDetail;

@end
