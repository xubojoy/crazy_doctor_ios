//
//  RefreshUIView.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/21.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "RefreshUIView.h"

@implementation RefreshUIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"RefreshUIView" owner:self options:nil] objectAtIndex:0];
        self.frame = frame;
        self.reLoadDataBtn.layer.cornerRadius = 2;
        self.reLoadDataBtn.layer.borderWidth = splite_line_height;
        self.reLoadDataBtn.layer.borderColor = [ColorUtils colorWithHexString:common_app_text_color].CGColor;
        [self.reLoadDataBtn setTitleColor:[ColorUtils colorWithHexString:common_app_text_color] forState:UIControlStateNormal];
        self.titleLabel.textColor = [ColorUtils colorWithHexString:light_gray_text_color];
    }
    return self;
}

- (IBAction)reLoadDataBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didReLoadDataBtnClick:)]) {
        [self.delegate didReLoadDataBtnClick:sender];
    }
}

@end
