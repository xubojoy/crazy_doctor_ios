//
//  PushSettingCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/19.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "PushSettingCell.h"

@implementation PushSettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.timeLabel.textColor = [ColorUtils colorWithHexString:gray_text_color];
    self.meridianLabel.textColor = [ColorUtils colorWithHexString:light_gray_text_color];
    self.downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
    
//    self.pushSwit = [[LQXSwitch alloc] initWithFrame:CGRectMake(screen_width-15-48, (45-23)/2, 48, 23) onColor:[ColorUtils colorWithHexString:common_app_text_color] offColor:[ColorUtils colorWithHexString:splite_line_color] font:[UIFont systemFontOfSize:default_font_size] ballSize:20];
//    [self.contentView addSubview:self.pushSwit];
//    [self.pushSwit addTarget:self action:@selector(pushSettingCellSwit:) forControlEvents:UIControlEventValueChanged];
}

- (void)renderPushSettingCellWithTime:(NSString *)time withMeridian:(NSString *)meridian{
    self.timeLabel.text = time;
    self.meridianLabel.text = meridian;
}

//- (void)pushSettingCellSwit:(LQXSwitch *)sender
//{
//    if ([self.delegate respondsToSelector:@selector(didPushSettingCellSwit:)]) {
//        [self.delegate didPushSettingCellSwit:sender];
//    }
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
