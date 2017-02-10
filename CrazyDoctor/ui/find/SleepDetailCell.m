//
//  SleepDetailCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/25.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "SleepDetailCell.h"

@implementation SleepDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLabel.textColor = [ColorUtils colorWithHexString:@"#faefde"];
    self.timeLongLabel.textColor = [UIColor whiteColor];
    self.deepSleepTimeLabel.textColor = [ColorUtils colorWithHexString:@"#faefde"];
}

- (void)renderSleepDetailCellWithSleepDetail:(SleepDetail *)sleepDetail{
    int deephour = (int)sleepDetail.deep / 60; //3小时
    int deepminremains = (int)sleepDetail.deep % 60; //余数，20分钟
    if (deepminremains == 0) {
        self.timeLongLabel.text = [NSString stringWithFormat:@"%d小时00分钟",deephour];
    }else{
        self.timeLongLabel.text = [NSString stringWithFormat:@"%d小时%d分钟",deephour,deepminremains];
    }

    NSString *startDateStr = [DateUtils dateStringWithFromLongLongInt:sleepDetail.sleepStartMinutes];
    NSLog(@">>>>>>深睡开始时间>>>>>>>>%@",startDateStr);
    NSArray *startDateArray = [startDateStr componentsSeparatedByString:@" "];
    
    NSString *endDateStr = [DateUtils dateStringWithFromLongLongInt:sleepDetail.sleepEndMinutes];
    NSLog(@">>>>>>浅睡开始时间>>>>>>>>%@",endDateStr);
    NSArray *endDateArray = [endDateStr componentsSeparatedByString:@" "];
    self.deepSleepTimeLabel.text = [NSString stringWithFormat:@"%@-%@",startDateArray[1],endDateArray[1]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
