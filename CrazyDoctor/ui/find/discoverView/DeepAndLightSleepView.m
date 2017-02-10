//
//  DeepAndLightSleepView.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/25.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "DeepAndLightSleepView.h"

@implementation DeepAndLightSleepView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"DeepAndLightSleepView" owner:self options:nil] objectAtIndex:0];
        self.frame = frame;
        self.lightSleepLabel.font = [UIFont systemFontOfSize:22];
        self.lightSleepLabel.textColor = [UIColor whiteColor];
        self.deepSleepLabel.font = [UIFont systemFontOfSize:22];
        self.deepSleepLabel.textColor = [UIColor whiteColor];
        
        float x = ((self.frame.size.width/2)-60-17-9)/2;
        
        UIImageView *lightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 28, 17, 17)];
        lightImgView.image = [UIImage imageNamed:@"icon_time_history_record"];
        [self addSubview:lightImgView];
        
        UILabel *lightLabel = [[UILabel alloc] initWithFrame:CGRectMake(x+17+9, 28, 60, 17)];
        lightLabel.text = @"浅度睡眠";
        lightLabel.textColor = [ColorUtils colorWithHexString:@"#faefde"];
        lightLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:lightLabel];
        
        UIImageView *deepImgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width/2)+x, 28, 17, 17)];
        deepImgView.image = [UIImage imageNamed:@"icon_time_history_record"];
        [self addSubview:deepImgView];
        
        UILabel *deepLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width/2)+x+17+9, 28, 60, 17)];
        deepLabel.text = @"深度睡眠";
        deepLabel.textColor = [ColorUtils colorWithHexString:@"#faefde"];
        deepLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:deepLabel];
        
    }
    return self;
}

- (void)renderDeepAndLightSleepView:(SharkeyData *)sharkeyData{

    int hour = (int)sharkeyData.sleepTimeLight / 60; //3小时
    int minremains = (int)sharkeyData.sleepTimeLight % 60; //余数，20分钟
    
    NSString *realStepStr= [NSString stringWithFormat:@"%d小时%d分钟",hour,minremains];
    int start = (int)[realStepStr rangeOfString:[NSString stringWithFormat:@"%@",@"小时"]].location;
    NSLog(@">>>>>>>>>>开始位置>>>>>>>>>%d",start);
    int length = (int)[realStepStr rangeOfString:[NSString stringWithFormat:@"%@",@"小时"]].length;
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:realStepStr];
    [attributedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(start,length)];
    
    int start1 = (int)[realStepStr rangeOfString:[NSString stringWithFormat:@"%@",@"分钟"]].location;
    NSLog(@">>>>>>>>>>开始位置>>>>>>>>>%d",start);
    int length1 = (int)[realStepStr rangeOfString:[NSString stringWithFormat:@"%@",@"分钟"]].length;
    NSMutableAttributedString *attributedText1 = [[NSMutableAttributedString alloc] initWithAttributedString:attributedText];
    [attributedText1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(start1,length1)];
    
    self.lightSleepLabel.attributedText = attributedText1;
    
    
    int deephour = (int)sharkeyData.sleepTimeDeep / 60; //3小时
    int deepminremains = (int)sharkeyData.sleepTimeDeep % 60; //余数，20分钟
    
    NSString *deepSleepStr= [NSString stringWithFormat:@"%d小时%d分钟",deephour,deepminremains];
    int start2 = (int)[deepSleepStr rangeOfString:[NSString stringWithFormat:@"%@",@"小时"]].location;
    NSLog(@">>>>>>>>>>开始位置>>>>>>>>>%d",start);
    int length2 = (int)[deepSleepStr rangeOfString:[NSString stringWithFormat:@"%@",@"小时"]].length;
    NSMutableAttributedString *attributedText2 = [[NSMutableAttributedString alloc] initWithString:deepSleepStr];
    [attributedText2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(start2,length2)];
    
    int start3 = (int)[deepSleepStr rangeOfString:[NSString stringWithFormat:@"%@",@"分钟"]].location;
    NSLog(@">>>>>>>>>>开始位置>>>>>>>>>%d",start);
    int length3 = (int)[deepSleepStr rangeOfString:[NSString stringWithFormat:@"%@",@"分钟"]].length;
    NSMutableAttributedString *attributedText3 = [[NSMutableAttributedString alloc] initWithAttributedString:attributedText2];
    [attributedText3 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(start3,length3)];
    
    self.deepSleepLabel.attributedText = attributedText3;

    
}

@end
