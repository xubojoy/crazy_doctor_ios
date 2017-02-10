//
//  CustomEmptyView.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/18.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "CustomEmptyView.h"
#import "UILabel+Block.h"
#import "FunctionUtils.h"
@implementation CustomEmptyView

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title withUnderLineTitle:(NSString *)lineTitle color:(NSString *)color withLineColor:(NSString *)withLinecolor font:(float)font withLineFont:(float)withLineFont
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CustomEmptyView" owner:self options:nil] objectAtIndex:0];
        self.frame = frame;
        CGSize rectSize = [FunctionUtils getCGSizeByString:title font:font];
        float x = (screen_width-rectSize.width)/2;
        self.remindLabel = [[UILabel alloc] init];
        self.remindLabel.font = [UIFont systemFontOfSize:font];
        self.remindLabel.textColor = [ColorUtils colorWithHexString:color];
        
        int start = (int)[title rangeOfString:[NSString stringWithFormat:@"%@",lineTitle]].location;
        NSLog(@">>>>>>>>>>开始位置>>>>>>>>>%d",start);
        int length = (int)[title rangeOfString:[NSString stringWithFormat:@"%@",lineTitle]].length;
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:title];
        [attributedText addAttribute:NSForegroundColorAttributeName value:[ColorUtils colorWithHexString:withLinecolor] range:NSMakeRange(start,length)];
        [attributedText addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:withLineFont] range:NSMakeRange(start,length)];
        self.remindLabel.attributedText = attributedText;
        self.remindLabel.textAlignment = NSTextAlignmentCenter;
        self.remindLabel.frame = CGRectMake(0, 180, screen_width, 20);
        [self addSubview:self.remindLabel];
        
        CGSize rectUnderLineLabelSize = [FunctionUtils getCGSizeByString:lineTitle font:withLineFont];
        NSArray *array = [title componentsSeparatedByString:lineTitle];
        NSString *leftStr = array[0];
        CGSize leftRectSize = [FunctionUtils getCGSizeByString:leftStr font:font];
        
//        //7.下划线测试
//        UILabel * label_Temp6 = [UILabel label_Alloc:^(UILabel *lab) {
//            lab.text = lineTitle;
//            lab.backgroundColor = [UIColor clearColor];
//            lab.textColor = [ColorUtils colorWithHexString:lighter_2_brown_color];
//            lab.font = [UIFont systemFontOfSize:small_font_size];
//            lab.textAlignment = NSTextAlignmentCenter;
//            
//            lab.frame = CGRectMake(x+rectSize.width, 180, rectUnderLineLabelSize.width, 20);
//            
//        } addView:self];
//        [label_Temp6 showUnderLine];
        
        UIView *underLine = [[UIView alloc] init];
        underLine.frame = CGRectMake(x+leftRectSize.width, 197, rectUnderLineLabelSize.width, splite_line_height);
        underLine.backgroundColor = [ColorUtils colorWithHexString:withLinecolor];
        [self addSubview:underLine];
    }
    return self;
}


- (IBAction)customEmptyBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didCustomEmptyBtnClick:)]) {
        [self.delegate didCustomEmptyBtnClick:sender];
    }
}


@end
