//
//  UserInfoView.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/20.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    next_btn_tag = 0,
    connect_hardware_tag = 1,
} UserInfoViewBtnTag;
@protocol UserInfoViewDelegate <NSObject>

- (void)didUserInfoViewBtnClick:(UIButton *)sender;

@end

@interface UserInfoView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *userIconImgView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property (weak, nonatomic) IBOutlet UIButton *connectHardwareBtn;

@property (nonatomic ,assign) id<UserInfoViewDelegate> delegate;

- (void)renderUserInfoViewWithUser:(User *)user;

@end
