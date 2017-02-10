//
//  CustomEmptyView.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/18.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomEmptyViewDelegate <NSObject>

- (void)didCustomEmptyBtnClick:(UIButton *)sender;

@end

@interface CustomEmptyView : UIView

@property (weak, nonatomic) IBOutlet UIButton *customBtn;

@property (nonatomic ,strong) UILabel *remindLabel;

@property (weak, nonatomic) IBOutlet UIImageView *emptyImgView;


@property (nonatomic ,assign) id<CustomEmptyViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title withUnderLineTitle:(NSString *)lineTitle color:(NSString *)color withLineColor:(NSString *)withLinecolor font:(float)font withLineFont:(float)withLineFont;
@end
