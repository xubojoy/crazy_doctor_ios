//
//  TopReCheckView.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/20.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "TopReCheckView.h"

@implementation TopReCheckView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"TopReCheckView" owner:self options:nil] objectAtIndex:0];
        self.frame = frame;
        self.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
        self.dayCountLbel.layer.borderWidth = splite_line_height;
        self.dayCountLbel.layer.borderColor = [ColorUtils colorWithHexString:common_app_text_color].CGColor;
        self.dayCountLbel.layer.masksToBounds = YES;
        self.dayCountLbel.textColor = [ColorUtils colorWithHexString:light_gray_text_color];
        self.dayCountLbel.font = [UIFont boldSystemFontOfSize:smaller_font_size];
        self.dayCountLbel.text = @"  距离上次检查已经n天";
        self.dayCountLbel.backgroundColor = [UIColor whiteColor];
        
        [self.reCkeckBtn setBackgroundColor:[ColorUtils colorWithHexString:common_app_text_color]];
        [self.reCkeckBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return self;
}

- (void)renderTopReCheckView:(NSString *)str{
    
    NSTimeInterval dayCountTime = [DateUtils getUTCFormateDate:str];
    
    int month=((int)dayCountTime)/(3600*24*30);
    int days=((int)dayCountTime)/(3600*24);
    int hours=((int)dayCountTime)%(3600*24)/3600;
    int minute=((int)dayCountTime)%(3600*24)/60;
    int second = ((int)dayCountTime)%(3600*24)%3600%60;
    NSLog(@"time=%f",(double)dayCountTime);
    NSString *dateContent;
    int start = 0;
    int length = 0;
    if(month!=0){
        dateContent = [NSString stringWithFormat:@"  距离上次检查已经%d%@",month,@"个月"];
        start = (int)[dateContent rangeOfString:[NSString stringWithFormat:@"%d",month]].location;
        length = (int)[dateContent rangeOfString:[NSString stringWithFormat:@"%d",month]].length;

    }else if(days!=0){
        dateContent = [NSString stringWithFormat:@"  距离上次检查已经%d%@",days,@"天"];
        start = (int)[dateContent rangeOfString:[NSString stringWithFormat:@"%d",days]].location;
        length = (int)[dateContent rangeOfString:[NSString stringWithFormat:@"%d",days]].length;
    }else if(hours!=0){
        dateContent = [NSString stringWithFormat:@"  距离上次检查已经%d%@",hours,@"小时"];
        start = (int)[dateContent rangeOfString:[NSString stringWithFormat:@"%d",hours]].location;
        length = (int)[dateContent rangeOfString:[NSString stringWithFormat:@"%d",hours]].length;
    }else if(minute != 0){
        dateContent = [NSString stringWithFormat:@"  距离上次检查已经%d%@",minute,@"分钟"];
        start = (int)[dateContent rangeOfString:[NSString stringWithFormat:@"%d",minute]].location;
        length = (int)[dateContent rangeOfString:[NSString stringWithFormat:@"%d",minute]].length;
    }else{
        dateContent = [NSString stringWithFormat:@"  距离上次检查已经%d%@",second,@"秒"];
        start = (int)[dateContent rangeOfString:[NSString stringWithFormat:@"%d",second]].location;
        length = (int)[dateContent rangeOfString:[NSString stringWithFormat:@"%d",second]].length;
    }
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:dateContent];
    [attributedText addAttribute:NSForegroundColorAttributeName value:[ColorUtils colorWithHexString:lighter_2_brown_color] range:NSMakeRange(start,length)];
    [attributedText addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:small_font_size] range:NSMakeRange(start,length)];
    self.dayCountLbel.attributedText = attributedText;
}


- (IBAction)reCheckBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didreCheckBtnClick:)]) {
        [self.delegate didreCheckBtnClick:sender];
    }
}


@end
