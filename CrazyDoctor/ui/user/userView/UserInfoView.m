//
//  UserInfoView.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/20.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "UserInfoView.h"

@implementation UserInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"UserInfoView" owner:self options:nil] objectAtIndex:0];
        self.frame = frame;
        
        self.userIconImgView.layer.cornerRadius = self.userIconImgView.frame.size.width/2;
        self.userIconImgView.layer.masksToBounds = YES;
        
        //7.下划线测试
        UILabel * label_Temp6 = [UILabel label_Alloc:^(UILabel *lab) {
            lab.text = @"链接硬件";
            lab.backgroundColor = [UIColor clearColor];
            lab.textColor = [ColorUtils colorWithHexString:common_app_text_color];
            lab.font = [UIFont boldSystemFontOfSize:small_font_size];
            lab.textAlignment = NSTextAlignmentLeft;
            
            lab.frame = CGRectMake(92, 49, 100, 20);
            
        } addView:self];
        [label_Temp6 showUnderLine];
        
        self.connectHardwareBtn.tag = connect_hardware_tag;
        self.nextBtn.tag = next_btn_tag;
    }
    return self;
}

- (void)renderUserInfoViewWithUser:(User *)user{
    
    NSLog(@">>>>>>>>user.avatarUrl>>>>%@",user.avatarUrl);
    [self.userIconImgView sd_setImageWithURL:[NSURL URLWithString:user.avatarUrl] placeholderImage:[UIImage imageNamed:@"icon_head_nor"]];
    if ([NSStringUtils isNotBlank:user.name]) {
        self.userNameLabel.text = user.name;
    }
    
}

- (IBAction)userInfoViewBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didUserInfoViewBtnClick:)]) {
        [self.delegate didUserInfoViewBtnClick:sender];
    }
}



@end
