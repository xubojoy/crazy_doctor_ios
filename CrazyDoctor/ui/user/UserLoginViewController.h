//
//  UserLoginViewController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/12.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CrazyDoctorTabbar.h"
@interface UserLoginViewController : BaseViewController<UITextFieldDelegate>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) UITextField *userPhoneNumField;
@property (nonatomic ,strong) UITextField *userPhoneCodeField;
@property (nonatomic ,strong) UIButton *loginCodeBtn;
@property (nonatomic ,strong) UIButton *registerBtn;
@property (nonatomic ,strong) UIButton *loginBtn;
@property (nonatomic, strong) CrazyDoctorTabbar *tabbar;
@property (nonatomic ,strong) UIButton *agreementBtn;
@property (nonatomic ,strong) UIButton *protocolBtn;

@property (nonatomic ,assign) BOOL isSame;
@property int accountSessionFrom;
-(id) initWithFrom:(int)accountSessionFrom;
@end
