//
//  ReadyForTongueDiagnosisBottomView.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/25.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "ReadyForTongueDiagnosisBottomView.h"

@implementation ReadyForTongueDiagnosisBottomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ReadyForTongueDiagnosisBottomView" owner:self options:nil] objectAtIndex:0];
        self.frame = frame;
        
        self.upLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
        self.okBtn.tag = okBtn_tag;
        self.noRemindBtn.tag = noRemindBtn_tag;
        
        self.okBtn.layer.cornerRadius = 2;
        self.okBtn.layer.masksToBounds = YES;
        
        self.noRemindBtn.layer.borderWidth = splite_line_height;
        self.noRemindBtn.layer.borderColor = [ColorUtils colorWithHexString:lighter_2_brown_color].CGColor;
        self.noRemindBtn.backgroundColor = [UIColor clearColor];
        self.noRemindBtn.layer.cornerRadius = 2;
        self.noRemindBtn.layer.masksToBounds = YES;
        [self.noRemindBtn setTitleColor:[ColorUtils colorWithHexString:lighter_2_brown_color] forState:UIControlStateNormal];
        
        [self.okBtn setTitleColor:[ColorUtils colorWithHexString:white_text_color] forState:UIControlStateNormal];
        UIImage *norImage = [UIImage imageNamed:@"btn_login_pre"];
        [self.okBtn setBackgroundImage:[ImageUtils resizableBgImage:norImage] forState:UIControlStateNormal];
    }
    return self;
}

- (IBAction)ReadyForTongueDiagnosisBottomViewBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didReadyForTongueDiagnosisBottomViewBtnClick:)]) {
        [self.delegate didReadyForTongueDiagnosisBottomViewBtnClick:sender];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
