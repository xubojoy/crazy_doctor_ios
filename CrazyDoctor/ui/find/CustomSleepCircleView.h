//
//  CustomSleepCircleView.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/26.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomSleepCircleView : UIView
@property (nonatomic, assign) NSInteger rate; // 中间显示的数字
@property (nonatomic ,assign) NSInteger tagartStep;
@property (nonatomic ,assign) NSInteger realStep;
@property (nonatomic ,strong) UILabel *tagartLabel;
@property (nonatomic ,strong) UIImageView *flagImageView;

- (void)startAnimation; // 开始动画

- (instancetype)initWithFrame:(CGRect)frame tagartStep:(NSInteger)tagartStep realStep:(NSInteger)realStep;

@end
