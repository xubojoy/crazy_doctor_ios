//
//  UserRegisterController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/6/7.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    menbtn_tag = 1000000,
    women_tag = 1000001,
} SexBtnTag;

@interface UserRegisterController : BaseViewController<UITextFieldDelegate>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) UITextField *userPhoneNumField;
@property (nonatomic ,strong) UITextField *userPhoneCodeField;
@property (nonatomic ,strong) UIButton *registerCodeBtn;
@property (nonatomic ,strong) UIButton *registerBtn;
@property (nonatomic ,strong) UIButton *agreementBtn;
@property (nonatomic ,strong) UIButton *protocolBtn;

@property (nonatomic ,strong) UIButton *menBtn;
@property (nonatomic ,strong) UIButton *womenBtn;

@property (nonatomic ,strong) UILabel *dateLabel;


//时间选择器

@property (strong, nonatomic) IBOutlet UIView *maskView;

@property (strong, nonatomic) IBOutlet UIView *chooseBirthDateModalView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelDateBtn;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *confirmDateBtn;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;

- (IBAction)cancelDatePickerClick:(UIBarButtonItem *)sender;


- (IBAction)confirmDatePickerClick:(UIBarButtonItem *)sender;


@property (nonatomic ,assign) BOOL isSame;

@property (nonatomic ,assign) int sexSelect;


@property int accountSessionFrom;
-(id) initWithFrom:(int)accountSessionFrom;


@end
