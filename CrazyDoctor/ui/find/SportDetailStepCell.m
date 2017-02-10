//
//  SportDetailStepCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/21.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "SportDetailStepCell.h"

@implementation SportDetailStepCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.dateLabel.textColor = [UIColor whiteColor];
    self.dateLabel.font = [UIFont systemFontOfSize:small_font_size];
    
    self.stepNumLabel.textColor = [UIColor whiteColor];
    self.stepNumLabel.font = [UIFont boldSystemFontOfSize:default_1_font_size];
    self.kmLabel.textColor = [UIColor whiteColor];
    self.kmLabel.font = [UIFont boldSystemFontOfSize:default_1_font_size];
    self.kcallLabel.textColor = [UIColor whiteColor];
    self.kcallLabel.font = [UIFont boldSystemFontOfSize:default_1_font_size];
}

- (void)renderSportDetailStepCell:(NSDictionary *)dict row:(NSInteger)row{
     NSLog(@">>>渲染数据>>>>>>>>>%@",dict);
    if (row == 0) {
        self.dateLabel.text = @"近7天";
    }else if (row == 1) {
        self.dateLabel.text = @"今天";
    }else{
        self.dateLabel.text = dict[@"date"];
    }
    self.stepNumLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"stepNum"]];
    self.kmLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"walkDistance"]];
    self.kcallLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"walkCal"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
