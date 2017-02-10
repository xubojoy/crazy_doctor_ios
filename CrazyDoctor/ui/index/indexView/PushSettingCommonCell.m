//
//  PushSettingCommonCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/19.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "PushSettingCommonCell.h"

@implementation PushSettingCommonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLabel.textColor = [ColorUtils colorWithHexString:common_content_color];
    self.timeLabel.textColor = [ColorUtils colorWithHexString:gray_text_color];
    self.downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
    
    self.pushSwit = [[LQXSwitch alloc] initWithFrame:CGRectMake(screen_width-15-48, (49-23)/2, 48, 23) onColor:[ColorUtils colorWithHexString:common_app_text_color] offColor:[ColorUtils colorWithHexString:splite_line_color] font:[UIFont systemFontOfSize:default_font_size] ballSize:20];
    [self.pushSwit addTarget:self action:@selector(didPushCommonCellSwit:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.pushSwit];
    
}

- (void)didPushCommonCellSwit:(LQXSwitch *)sender
{
    if ([self.delegate respondsToSelector:@selector(didPushCommonCellSwit:)]) {
        [self.delegate didPushCommonCellSwit:sender];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
