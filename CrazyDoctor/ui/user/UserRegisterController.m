//
//  UserRegisterController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/6/7.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "UserRegisterController.h"
#import "AppDelegate.h"
#import "UserStore.h"
#import "ServiceProtocolController.h"
#import "AccountSessionSpringBoard.h"
#import "AppClientStore.h"
@interface UserRegisterController ()

@end

@implementation UserRegisterController

-(id) initWithFrom:(int)accountSessionFrom{
    self = [super init];
    if(self){
        self.accountSessionFrom = accountSessionFrom;
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.autoresizesSubviews = NO;
    self.view.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    self.isSame = YES;
    self.sexSelect = 1;
    [self initHeadView];
    [self initUI];
}

//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"注册" navigationController:self.navigationController];
    [self.view addSubview:self.headerView];
}

- (void)initUI{
    //    // 设置大背景
    UIImage *bgImg = [UIImage imageNamed:@"bg_login@2x.jpg"];
    self.view.layer.contents = (id) bgImg.CGImage;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height+splite_line_height, screen_width, 290)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    self.userPhoneNumField = [[UITextField alloc] initWithFrame:CGRectMake(general_margin, 0, screen_width-120-general_margin, 45)];
    
    NSString *placeholderStr = @"请输入手机号";
    NSMutableAttributedString *attrString =
    [[NSMutableAttributedString alloc] initWithString:placeholderStr];
    // 设置颜色
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:[ColorUtils colorWithHexString:@"#c8c8c8"]
                       range:NSMakeRange(0, placeholderStr.length)];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:default_1_font_size] range:NSMakeRange(0, placeholderStr.length)];
    
    self.userPhoneNumField.attributedPlaceholder = attrString;
    
    self.userPhoneNumField.textColor = [ColorUtils colorWithHexString:common_app_text_color];
    self.userPhoneNumField.keyboardType = UIKeyboardTypeNumberPad;
    self.userPhoneNumField.delegate = self;
    
    [self.userPhoneNumField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [bgView addSubview:self.userPhoneNumField];
    
    self.registerCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerCodeBtn.frame = CGRectMake(screen_width-120, 0, 120, 45);
    [self.registerCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.registerCodeBtn.backgroundColor = [ColorUtils colorWithHexString:@"#efefef"];
    [self.registerCodeBtn setTitleColor:[ColorUtils colorWithHexString:@"#9f9f9f"] forState:UIControlStateNormal];
    [self.registerCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:default_font_size]];
    [self.registerCodeBtn addTarget:self action:@selector(registerCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.registerCodeBtn];
    
    UIView *firstLine = [[UIView alloc] initWithFrame:CGRectMake(0, 45, screen_width, splite_line_height)];
    firstLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
    [bgView addSubview:firstLine];
    
    
    
    self.userPhoneCodeField = [[UITextField alloc] initWithFrame:CGRectMake(general_margin, 45, screen_width-30, 45)];
    
    NSString *codePlaceholderStr = @"请输入验证码";
    NSMutableAttributedString *codeAttrString =
    [[NSMutableAttributedString alloc] initWithString:codePlaceholderStr];
    // 设置颜色
    [codeAttrString addAttribute:NSForegroundColorAttributeName
                           value:[ColorUtils colorWithHexString:@"#c8c8c8"]
                           range:NSMakeRange(0, codePlaceholderStr.length)];
    [codeAttrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:default_1_font_size] range:NSMakeRange(0, codePlaceholderStr.length)];
    
    self.userPhoneCodeField.attributedPlaceholder = codeAttrString;
    
    self.userPhoneCodeField.textColor = [ColorUtils colorWithHexString:common_app_text_color];
    self.userPhoneCodeField.delegate = self;
    self.userPhoneCodeField.keyboardType = UIKeyboardTypeNumberPad;
    [self.userPhoneCodeField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [bgView addSubview:self.userPhoneCodeField];
    
    UIView *secondLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.userPhoneCodeField.bottomY, screen_width, splite_line_height)];
    secondLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
    [bgView addSubview:secondLine];
    
    
    
    UILabel *birthLabel = [[UILabel alloc] initWithFrame:CGRectMake(general_margin, secondLine.bottomY, 100, 45)];
    birthLabel.text = @"出生日期";
    birthLabel.font = [UIFont systemFontOfSize:default_1_font_size];
    birthLabel.textColor = [ColorUtils colorWithHexString:@"#c8c8c8"];
    [bgView addSubview:birthLabel];
    
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(general_margin+100, secondLine.bottomY, screen_width-30-100-20, 45)];
    self.dateLabel.font = [UIFont systemFontOfSize:default_1_font_size];
    self.dateLabel.backgroundColor = [UIColor whiteColor];
    self.dateLabel.text = @"";
    self.dateLabel.textColor = [UIColor blackColor];
    self.dateLabel.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:self.dateLabel];
    
    UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(screen_width-35, secondLine.bottomY+(45-20)/2, general_space, general_space)];
    arrowImgView.image = [UIImage imageNamed:@"icon_arrow"];
    [bgView addSubview:arrowImgView];
    
    UIButton *birthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    birthBtn.frame = CGRectMake(0, secondLine.bottomY, screen_width, 45);
    birthBtn.backgroundColor = [UIColor clearColor];
    [birthBtn addTarget:self action:@selector(birthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:birthBtn];
    
    
    
    UIView *thirdLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.dateLabel.bottomY, screen_width, splite_line_height)];
    thirdLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
    [bgView addSubview:thirdLine];
    
    UILabel *sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(general_margin, self.dateLabel.bottomY, 100, 45)];
    sexLabel.text = @"男/女";
    sexLabel.font = [UIFont systemFontOfSize:default_1_font_size];
    sexLabel.textColor = [ColorUtils colorWithHexString:@"#c8c8c8"];
    [bgView addSubview:sexLabel];
    
    
    self.menBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.menBtn.frame = CGRectMake(screen_width-120-15, self.dateLabel.bottomY, 60, 45);
    self.menBtn.backgroundColor = [UIColor clearColor];
    self.menBtn.tag = menbtn_tag;
    [self.menBtn setImage:[UIImage imageNamed:@"icon_abandon_answer_select_circle_pre"] forState:UIControlStateNormal];
    [self.menBtn setTitle:@"男" forState:UIControlStateNormal];
    self.menBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [self.menBtn setTitleColor:[ColorUtils colorWithHexString:common_app_text_color] forState:UIControlStateNormal];
    self.menBtn.titleLabel.font = [UIFont systemFontOfSize:default_1_font_size];
    [self.menBtn addTarget:self action:@selector(sexBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.menBtn];
    
    self.womenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.womenBtn.frame = CGRectMake(screen_width-15-60, self.dateLabel.bottomY, 60, 45);
    self.womenBtn.backgroundColor = [UIColor clearColor];
    self.womenBtn.tag = women_tag;
    [self.womenBtn setImage:[UIImage imageNamed:@"icon_abandon_answer_select_circle_nor"] forState:UIControlStateNormal];
    [self.womenBtn setTitle:@"女" forState:UIControlStateNormal];
    self.womenBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [self.womenBtn setTitleColor:[ColorUtils colorWithHexString:common_app_text_color] forState:UIControlStateNormal];
    self.womenBtn.titleLabel.font = [UIFont systemFontOfSize:default_1_font_size];
    [self.womenBtn addTarget:self action:@selector(sexBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.womenBtn];
    
    UIView *forthLine = [[UIView alloc] initWithFrame:CGRectMake(0, sexLabel.bottomY, screen_width, splite_line_height)];
    forthLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
    [bgView addSubview:forthLine];
    
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerBtn.frame = CGRectMake(35, sexLabel.bottomY+50, screen_width-70, 45);
    [self.registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    self.registerBtn.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
    [self.registerBtn setTitleColor:[ColorUtils colorWithHexString:white_text_color] forState:UIControlStateNormal];
    [self.registerBtn.titleLabel setFont:[UIFont systemFontOfSize:default_font_size]];
    [self.registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.registerBtn];
    
    
    self.agreementBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.agreementBtn.frame = CGRectMake(0, bgView.bottomY+15, 45, 45);
    
    [self.agreementBtn setImage:[UIImage imageNamed:@"icon_abandon_answer_select_circle_pre"] forState:UIControlStateNormal];
    [self.agreementBtn addTarget:self action:@selector(agreementBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.agreementBtn];
    
    self.protocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.protocolBtn.frame = CGRectMake(45, bgView.bottomY+15, 320-45, 45);
    [self.protocolBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.protocolBtn.titleLabel setFont:[UIFont systemFontOfSize:default_font_size]];
    NSString *agreeStr = @"同意并已阅读  <<用户协议>>";
    int start = (int)[agreeStr rangeOfString:@"<<用户协议>>"].location;
    int length = (int)[agreeStr rangeOfString:@"<<用户协议>>"].length;
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:agreeStr];
    [attributedText addAttribute:NSForegroundColorAttributeName value:[ColorUtils colorWithHexString:common_app_text_color] range:NSMakeRange(start,length)];
    [self.protocolBtn setAttributedTitle:attributedText forState:UIControlStateNormal];
    self.protocolBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -90, 0, 0);
    
    [self.protocolBtn addTarget:self action:@selector(protocolBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.protocolBtn];
}



/**
 *  时间选择器
 *
 *  @return
 */
//弹出-------datePickerView
#pragma mark - datePickerView   处理Date
-(void)birthBtnClick{
    CGRect maskFrame = self.maskView.frame;
    maskFrame.size.height = screen_height;
    maskFrame.size.width = screen_width;
    self.maskView.frame = maskFrame;
    self.maskView.alpha = 0.5;
    self.maskView.backgroundColor = [UIColor blackColor];
    [self.cancelDateBtn setTintColor:[UIColor blackColor]];
    [self.confirmDateBtn setTintColor:[ColorUtils colorWithHexString:common_app_text_color]];
    [self.view addSubview:self.maskView];
    self.datePickerView.datePickerMode = UIDatePickerModeDate;
    NSLocale *chineseLocale = [NSLocale currentLocale]; //创建一个中文的地区对象
    [self.datePickerView setLocale:chineseLocale]; //将这个地区对象给UIDatePicker设置上
    CGRect frame = self.chooseBirthDateModalView.frame;
    frame.origin.y = screen_height;
    frame.size.width = screen_width;
    self.chooseBirthDateModalView.frame = frame;
    [self.view addSubview:self.chooseBirthDateModalView];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.chooseBirthDateModalView.frame;
        frame.origin.y = screen_height - 200;
        self.chooseBirthDateModalView.frame = frame;
    }];
}

- (IBAction)cancelDatePickerClick:(UIBarButtonItem *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.chooseBirthDateModalView.frame;
        frame.origin.y = screen_height;
        self.chooseBirthDateModalView.frame = frame;
    } completion:^(BOOL finished) {
        [self.chooseBirthDateModalView removeFromSuperview];
        [self.maskView removeFromSuperview];
    }];
    
}

- (IBAction)confirmDatePickerClick:(UIBarButtonItem *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.chooseBirthDateModalView.frame;
        frame.origin.y = screen_height;
        self.chooseBirthDateModalView.frame = frame;
    } completion:^(BOOL finished) {
        NSDate *select = [self.datePickerView date]; // 获取被选中的时间
        NSString *dateString = [DateUtils getDateByPickerDate:select];
        NSArray *array = [dateString componentsSeparatedByString:@" "];
        NSString *dateStr = array[0];
        self.dateLabel.text = dateStr;
        [self.chooseBirthDateModalView removeFromSuperview];
        [self.maskView removeFromSuperview];
    }];
}

- (void)sexBtnClick:(UIButton *)sender{
    switch (sender.tag) {
        case menbtn_tag:
            [self.menBtn setImage:[UIImage imageNamed:@"icon_abandon_answer_select_circle_pre"] forState:UIControlStateNormal];
            [self.womenBtn setImage:[UIImage imageNamed:@"icon_abandon_answer_select_circle_nor"] forState:UIControlStateNormal];
            self.sexSelect = 1;
            break;
        case women_tag:
            [self.menBtn setImage:[UIImage imageNamed:@"icon_abandon_answer_select_circle_nor"] forState:UIControlStateNormal];
            [self.womenBtn setImage:[UIImage imageNamed:@"icon_abandon_answer_select_circle_pre"] forState:UIControlStateNormal];
            self.sexSelect = 0;
            break;
            
        default:
            break;
    }

}


- (void)agreementBtnClick{
    self.isSame = !self.isSame;
    NSLog(@">>>>>>>>>>>>>>>>>%d",self.isSame);
    if (self.isSame) {
        self.isSame = YES;
        [self.agreementBtn setImage:[UIImage imageNamed:@"icon_abandon_answer_select_circle_pre"] forState:UIControlStateNormal];
    }else{
        self.isSame = NO;
        [self.agreementBtn setImage:[UIImage imageNamed:@"icon_abandon_answer_select_circle_nor"] forState:UIControlStateNormal];
    }
}

- (void)protocolBtnClick{
    [self.userPhoneNumField resignFirstResponder];
    [self.userPhoneCodeField resignFirstResponder];
    NSString *url = [NSString stringWithFormat:@"%@/protocol?noHeaderFlag=0&isAppOpen=1&noLocationFlag=0",[AppStatus sharedInstance].wxpubUrl];
    ServiceProtocolController *auvc = [[ServiceProtocolController alloc] initWithUrl:url titleStr:@"用户协议"];
    [self.navigationController pushViewController:auvc animated:YES];
}

- (void)registerBtnClick{
    NSString *loginMobileNo = self.userPhoneNumField.text;
    NSString *pwd = self.userPhoneCodeField.text;
    
    if (loginMobileNo == nil || loginMobileNo.length == 0) {
        [self.view makeToast:@"手机号不能为空" duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        return;
    }else if (loginMobileNo.length != 11){
        [self.view makeToast:@"请输入正确的手机号..." duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        return;
    }
    
    if (pwd == nil || pwd.length == 0) {
        [self.view makeToast:@"验证码不能为空" duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        return;
    }
    
    if (self.isSame == NO) {
        [self.view makeToast:@"您尚未同意用户协议！" duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        return;
    }
    [SVProgressHUD showWithStatus:@"注册中..." maskType:SVProgressHUDMaskTypeBlack];
    [[UserStore sharedStore] login:^(User *user, NSError *err) {
        [SVProgressHUD dismiss];
        if (user != nil) {
            NSLog(@">>>>>>>user>>>%@",user);
            [[NSNotificationCenter defaultCenter] postNotificationName:notification_name_session_update object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:notification_name_user_login object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:notification_name_update_user_avatar object:nil];
            NSLog(@">>>>>>>>>>>>>用户图像>>>>>>%@",user.avatarUrl);
            [AppStatus sharedInstance].user = user;
            [AppStatus saveAppStatus];
            
            if ([AppStatus sharedInstance].user.receivePush == YES) {
                if ([NSStringUtils isNotBlank:[AppStatus sharedInstance].user.pushTimes]) {
                    NSString *pushTimes = [AppStatus sharedInstance].user.pushTimes;
                    if ([FunctionUtils isDefaultPushTimes:pushTimes] == YES) {
                        AppStatus *pushStatus = [AppStatus sharedInstance];
                        pushStatus.defaultSwitch = YES;
                        pushStatus.customSwitch = NO;
                        [AppStatus saveAppStatus];
                        [FunctionUtils startDefaultNotifi];
                        
                    }else{
                        AppStatus *pushStatus = [AppStatus sharedInstance];
                        pushStatus.defaultSwitch = NO;
                        pushStatus.customSwitch = YES;
                        [AppStatus saveAppStatus];
                        [FunctionUtils closeDefaultNotifi];
                        
                        NSArray *pushTimesTmpArray = [pushTimes componentsSeparatedByString:@","];
                        if (pushTimesTmpArray.count > 0) {
                            for (NSString *timeStr in pushTimesTmpArray) {
                                [FunctionUtils scheduleLocalNotification:[NSString stringWithFormat:@"%@:01",timeStr] notificationId:[NSString stringWithFormat:@"notificationId%@",timeStr] content:[FunctionUtils getAcupointByTimeStr:timeStr]];
                            }
                        }
                        
                    }
                    
                }
            }else{
                AppStatus *pushStatus = [AppStatus sharedInstance];
                pushStatus.defaultSwitch = NO;
                pushStatus.customSwitch = NO;
                [AppStatus saveAppStatus];
            }
        
            [[UserStore sharedStore] updateUserInfo:^(User *user, NSError *err) {
                if (user != nil) {
                    NSLog(@">>>>>>>birthday>>>>>>>>>%@---%d",user.birthday,user.userGender);
                }else{
                    
                }
            } userId:[AppStatus sharedInstance].user.id
                                               name:[AppStatus sharedInstance].user.name
                                          avatarUrl:[AppStatus sharedInstance].user.avatarUrl
                                         userGender:self.sexSelect
                                        userSetCity:[AppStatus sharedInstance].user.userSetCity
                                         userRoleId:[AppStatus sharedInstance].user.userRoleId
                                        receivePush:[AppStatus sharedInstance].user.receivePush
                                          pushTimes:[AppStatus sharedInstance].user.pushTimes
                                            userJob:[AppStatus sharedInstance].user.userJob
                                           userType:[AppStatus sharedInstance].user.userType
                                           realName:[AppStatus sharedInstance].user.realName
                                          birthCity:[AppStatus sharedInstance].user.birthCity
                                          userMarry:[AppStatus sharedInstance].user.userMarry
                                           birthday:self.dateLabel.text
                                         userHeight:[AppStatus sharedInstance].user.userHeight
                                         userWeight:[AppStatus sharedInstance].user.userWeight
                                           userIDNo:[AppStatus sharedInstance].user.userIDNo
                                 pastMedicalHistory:[AppStatus sharedInstance].user.pastMedicalHistory];

            
            
            
            [AppClientStore updateAppClient];
            [AccountSessionSpringBoard jumpToAccountSessionFrom:self accountSessionFrom:self.accountSessionFrom];
        }else{
            ExceptionMsg *exception = [[err userInfo] objectForKey:@"ExceptionMsg"];
            [self.view makeToast:exception.message duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        }
    } mobileNo:self.userPhoneNumField.text pwd:pwd];
    [MobClick event:log_event_user_register];
    
}

- (void)registerCodeBtnClick{
    NSString *registerMobileNo = self.userPhoneNumField.text;
    if (registerMobileNo == nil || registerMobileNo.length == 0) {
        [self.view makeToast:@"手机号不能为空" duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        return;
    }else if (registerMobileNo.length != 11){
        [self.view makeToast:@"请输入正确的手机号..." duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        return;
    }
    [[UserStore sharedStore] requestTempPwd:^(NSError *err) {
        if (!err) {
            [SVProgressHUD showSuccessWithStatus:@"获取验证码成功" maskType:SVProgressHUDMaskTypeBlack];
            
            [self startTime];
        }else{
            ExceptionMsg *exception = [[err userInfo] objectForKey:@"ExceptionMsg"];
            [self.view makeToast:exception.message duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
            [SVProgressHUD showErrorWithStatus:@"获取验证码失败！" maskType:SVProgressHUDMaskTypeBlack];
        }
        
    } mobileNo:self.userPhoneNumField.text];
}

//b5918b

-(void)textFieldDidChanged:(UITextField *)textField
{
    NSLog(@"----------%@",textField.text);
    if (textField == self.userPhoneNumField) {
        if (self.userPhoneNumField.text.length == 11){
            self.registerBtn.userInteractionEnabled = YES;
            UIImage *norImage = [UIImage imageNamed:@"btn_login_nor"];
            UIImage *hightLightImage = [UIImage imageNamed:@"btn_login_pre"];
            [self.registerBtn setBackgroundImage:[ImageUtils resizableBgImage:norImage] forState:UIControlStateNormal];
            [self.registerBtn setBackgroundImage:[ImageUtils resizableBgImage:hightLightImage] forState:UIControlStateHighlighted];
            
            self.registerCodeBtn.backgroundColor = [ColorUtils colorWithHexString:@"#b5918b"];
            [self.registerCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        }else{
            self.registerBtn.userInteractionEnabled = NO;
            //            UIImage *image = [UIImage imageNamed:@"btn_login_nor"];
            //            [self.registerBtn setBackgroundImage:[ImageUtils resizableBgImage:image] forState:UIControlStateNormal];
            //            [self.registerBtn setBackgroundImage:[ImageUtils resizableBgImage:image] forState:UIControlStateHighlighted];
            
            self.registerCodeBtn.backgroundColor = [ColorUtils colorWithHexString:@"#efefef"];
            [self.registerCodeBtn setTitleColor:[ColorUtils colorWithHexString:@"#9f9f9f"] forState:UIControlStateNormal];
        }
        
    }else{
        
        
    }
}

#pragma mark - 开启时间倒计时线程
-(void)startTime{
    __block int timeout = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.registerCodeBtn setTitle:@"重新发送验证码" forState:UIControlStateNormal];
                self.registerCodeBtn.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"____%@",strTime);
                [self.registerCodeBtn setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                self.registerCodeBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
