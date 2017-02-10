//
//  UserSleepDetailCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/8/18.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "UserSleepDetailCell.h"

@implementation UserSleepDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.weekLabel.textColor = [UIColor whiteColor];
    self.weekLabel.font = [UIFont systemFontOfSize:small_font_size];
    
    self.sleepLabel.textColor = [UIColor whiteColor];
    self.sleepLabel.font = [UIFont systemFontOfSize:14];
}
- (void)renderUserSleepDetailCell:(NSDictionary *)dict row:(NSInteger)row{
    if (row == 0) {
        self.weekLabel.text = @"近7天";
    }else if (row == 1) {
        self.weekLabel.text = @"今天";
    }else{
        self.weekLabel.text = dict[@"date"];
    }
    
//    NSLog(@">>>>>>>>>>渲染的赌局>>>>>>>>%@",dict);
    
   int sleepTime = [[dict objectForKey:@"sleepTimeTotal"] intValue];
    int hour = sleepTime / 60; //3小时
    int minremains = sleepTime % 60; //余数，20分钟
    
    NSString *realStepStr= [NSString stringWithFormat:@"%d小时%d分",hour,minremains];
    int start = (int)[realStepStr rangeOfString:[NSString stringWithFormat:@"%@",@"小时"]].location;
    NSLog(@">>>>>>>>>>开始位置>>>>>>>>>%d",start);
    int length = (int)[realStepStr rangeOfString:[NSString stringWithFormat:@"%@",@"小时"]].length;
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:realStepStr];
    [attributedText addAttribute:NSForegroundColorAttributeName value:[ColorUtils colorWithHexString:@"#efd6bc"] range:NSMakeRange(start,length)];
    [attributedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(start,length)];
    
    int start1 = (int)[realStepStr rangeOfString:[NSString stringWithFormat:@"%@",@"分"]].location;
    NSLog(@">>>>>>>>>>开始位置>>>>>>>>>%d",start);
    int length1 = (int)[realStepStr rangeOfString:[NSString stringWithFormat:@"%@",@"分"]].length;
    NSMutableAttributedString *attributedText1 = [[NSMutableAttributedString alloc] initWithAttributedString:attributedText];
    [attributedText1 addAttribute:NSForegroundColorAttributeName value:[ColorUtils colorWithHexString:@"#efd6bc"] range:NSMakeRange(start1,length1)];
    [attributedText1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(start1,length1)];
    
    self.sleepLabel.attributedText = attributedText1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
