//
//  CustomProgressLineView.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/6/30.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomProgressLineViewDelegate <NSObject>

- (void)progressRate:(NSInteger)rate;

@end

@interface CustomProgressLineView : UIView
@property (nonatomic, assign) NSInteger rate; // 中间显示的数字
@property (nonatomic ,strong) UINavigationController *navcontroller;
@property (nonatomic, strong) UIImageView *renImgView;

@property (nonatomic ,assign) id<CustomProgressLineViewDelegate> delegate;

- (void)startAnimation; // 开始动画

- (instancetype)initWithFrame:(CGRect)frame rate:(NSInteger)rate nav:(UINavigationController *)nav;

@end
