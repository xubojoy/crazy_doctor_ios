//
//  UserLoginViewController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/12.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "UserLoginViewController.h"
#import "AppDelegate.h"
#import "UserStore.h"
#import "ServiceProtocolController.h"
#import "AccountSessionSpringBoard.h"
#import "AppClientStore.h"
#import "UserRegisterController.h"
@interface UserLoginViewController ()

@end

@implementation UserLoginViewController
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
    [self setRightSwipeGestureAndAdaptive];
    self.isSame = YES;
    [self initHeadView];
    [self initUI];
}

//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"登录" navigationController:self.navigationController];
    [self.view addSubview:self.headerView];
}

- (void)initUI{
    // 设置大背景
//    UIImage *bgImg = [UIImage imageNamed:@"bg_login@2x.jpg"];
//    self.view.layer.contents = (id) bgImg.CGImage;
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height+splite_line_height, screen_width, screen_height-self.headerView.frame.size.height)];
    bgImageView.image = [UIImage imageNamed:@"bg_login@2x.jpg"];
    [self.view addSubview:bgImageView];
    
    
    float heightScreen = [UIScreen mainScreen].applicationFrame.size.height;
    NSLog(@">>>>>>screen_height>>>>>%f",heightScreen);
    float phoney = 0;
    if (screen_height > 568) {
        phoney = 340;
    }else{
        phoney = 260;
    }
    
    UIImageView *phoneBgIMgView = [[UIImageView alloc] initWithFrame:CGRectMake((screen_width-300)/2, phoney, 300, 45)];
    
    UIImage *phoneImg = [UIImage imageNamed:@"input_login_iphone"];
    phoneBgIMgView.image = [ImageUtils resizableBgImage:phoneImg];
    [self.view addSubview:phoneBgIMgView];
    
    
    self.userPhoneNumField = [[UITextField alloc] initWithFrame:CGRectMake((screen_width-300)/2+10, phoney, 300-10, 45)];
//    self.userPhoneNumField.layer.borderWidth = splite_line_height;
//    self.userPhoneNumField.layer.cornerRadius = 2;
    
    NSString *placeholderStr = @"请输入手机号";
    NSMutableAttributedString *attrString =
    [[NSMutableAttributedString alloc] initWithString:placeholderStr];
    // 设置颜色
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:[ColorUtils colorWithHexString:@"#beaaa7"]
                       range:NSMakeRange(0, placeholderStr.length)];
    
    self.userPhoneNumField.attributedPlaceholder = attrString;

    self.userPhoneNumField.textColor = [ColorUtils colorWithHexString:common_app_text_color];
    self.userPhoneNumField.keyboardType = UIKeyboardTypeNumberPad;
    self.userPhoneNumField.delegate = self;
//    UIImage *phoneImg = [UIImage imageNamed:@"input_login_iphone"];
//    self.userPhoneNumField.background = [ImageUtils resizableBgImage:phoneImg];
    [self.userPhoneNumField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.userPhoneNumField];
    
    float codey = 0;
    if (screen_height > 568) {
        codey = 309+50+40;
    }else{
        codey = 309-30+40;
    }
    
    UIImageView *codeBgIMgView = [[UIImageView alloc] initWithFrame:CGRectMake((screen_width-300)/2, codey, 182, 45)];
    
    UIImage *phoneCodeImg = [UIImage imageNamed:@"input_login_iphone"];
    codeBgIMgView.image = [ImageUtils resizableBgImage:phoneCodeImg];
    [self.view addSubview:codeBgIMgView];
    
    
    self.userPhoneCodeField = [[UITextField alloc] initWithFrame:CGRectMake((screen_width-300)/2+10, codey, 182-10, 45)];
//    self.userPhoneCodeField.layer.borderWidth = splite_line_height;
//    self.userPhoneCodeField.layer.cornerRadius = 2;
    
    NSString *codePlaceholderStr = @"请输入验证码";
    NSMutableAttributedString *codeAttrString =
    [[NSMutableAttributedString alloc] initWithString:codePlaceholderStr];
    // 设置颜色
    [codeAttrString addAttribute:NSForegroundColorAttributeName
                       value:[ColorUtils colorWithHexString:@"#beaaa7"]
                       range:NSMakeRange(0, codePlaceholderStr.length)];
    
    self.userPhoneCodeField.attributedPlaceholder = codeAttrString;
    
    self.userPhoneCodeField.textColor = [ColorUtils colorWithHexString:common_app_text_color];
    self.userPhoneCodeField.delegate = self;
    self.userPhoneCodeField.keyboardType = UIKeyboardTypeNumberPad;
//    UIImage *phoneCodeImg = [UIImage imageNamed:@"input_login_iphone"];
//    self.userPhoneCodeField.background = [ImageUtils resizableBgImage:phoneCodeImg];
    [self.userPhoneCodeField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.userPhoneCodeField];
    
    self.loginCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginCodeBtn.frame = CGRectMake((screen_width-300)/2+180, codey, 120, 45);
    [self.loginCodeBtn setBackgroundImage:[UIImage imageNamed:@"btn_code_nor"]  forState:UIControlStateNormal];
    [self.loginCodeBtn setBackgroundImage:[UIImage imageNamed:@"btn_code_nor"]  forState:UIControlStateDisabled];
    [self.loginCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.loginCodeBtn setTitleColor:[ColorUtils colorWithHexString:common_app_text_color] forState:UIControlStateNormal];
    [self.loginCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:default_font_size]];
    self.loginCodeBtn.enabled = NO;
    [self.loginCodeBtn addTarget:self action:@selector(loginCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginCodeBtn];
    
    
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerBtn.frame = CGRectMake((screen_width-300)/2+180, self.loginCodeBtn.bottomY+10, 120, 45);
    [self.registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];

    [self.registerBtn setTitleColor:[ColorUtils colorWithHexString:common_app_text_color] forState:UIControlStateNormal];
    [self.registerBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:default_font_size]];
    [self.registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registerBtn];
    
    
//    float loginBtny = 0;
//    if (screen_height > 568) {
//        loginBtny = 398+50;
//    }else{
//        loginBtny = 398-30;
//    }

    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake((screen_width-300)/2, self.registerBtn.bottomY+10, 300, 45);
    UIImage *image = [UIImage imageNamed:@"btn_login_nor"];
    [self.loginBtn setBackgroundImage:[ImageUtils resizableBgImage:image] forState:UIControlStateNormal];
    self.loginBtn.enabled = NO;
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginBtn.titleLabel setFont:[UIFont systemFontOfSize:bigger_font_size]];
    [self.loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
    
//    self.agreementBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.agreementBtn.frame = CGRectMake((screen_width-300)/2, self.loginBtn.bottomY+15, 140, 45);
////    self.agreementBtn.backgroundColor = [UIColor purpleColor];
//    
//    [self.agreementBtn setImage:[UIImage imageNamed:@"icon_abandon_answer_select_circle_pre"] forState:UIControlStateNormal];
//    self.agreementBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -110);
//    [self.agreementBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:default_txt_height]];
//    [self.agreementBtn addTarget:self action:@selector(agreementBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.agreementBtn];
//    
//    self.protocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.protocolBtn.frame = CGRectMake((screen_width-300)/2+140, self.loginBtn.bottomY+15, 160, 45);
////    self.protocolBtn.backgroundColor = [UIColor cyanColor];
//    NSString *agreeStr = @"用户协议";
//    NSMutableAttributedString * strAtt_Temp = [[NSMutableAttributedString alloc] initWithString:agreeStr];
//    [strAtt_Temp addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, agreeStr.length)];
//    [strAtt_Temp addAttribute:NSForegroundColorAttributeName value:[ColorUtils colorWithHexString:common_app_text_color] range:NSMakeRange(0,agreeStr.length)];
//    [self.protocolBtn setAttributedTitle:strAtt_Temp forState:UIControlStateNormal];
//    self.protocolBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -90, 0, 0);
//    [self.protocolBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:default_txt_height]];
//    [self.protocolBtn addTarget:self action:@selector(protocolBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.protocolBtn];
}
//icon_abandon_answer_select_circle_nor
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
    NSString *url = [NSString stringWithFormat:@"%@/protocol?noHeaderFlag=0&isAppOpen=1&noLocationFlag=0",[AppStatus sharedInstance].wxpubUrl];
    ServiceProtocolController *auvc = [[ServiceProtocolController alloc] initWithUrl:url titleStr:@"用户协议"];
    [self.navigationController pushViewController:auvc animated:YES];
}

- (void)loginBtnClick{
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
    [SVProgressHUD showWithStatus:@"正在登录..." maskType:SVProgressHUDMaskTypeBlack];
    [[UserStore sharedStore] login:^(User *user, NSError *err) {
        [SVProgressHUD dismiss];
        if (err == nil) {
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
                [AppClientStore updateAppClient];
                [AccountSessionSpringBoard jumpToAccountSessionFrom:self accountSessionFrom:self.accountSessionFrom];
                
            }
        }
        else{
            NSLog(@">>>>>>>>>>>>密码错误>>>>>>");
            ExceptionMsg *exception = [[err userInfo] objectForKey:@"ExceptionMsg"];
            [self.view makeToast:exception.message duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        }
    } mobileNo:self.userPhoneNumField.text pwd:pwd];
    [MobClick event:log_event_user_login];
}

- (void)loginCodeBtnClick{
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

- (void)registerBtnClick{
    UserRegisterController *urvc = [[UserRegisterController alloc] init];
    [self.navigationController pushViewController:urvc animated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string

{
    //emoji无效
    if([NSStringUtils isContainsEmoji:string])
        
    {
        return NO;
        
    }else{
        if (textField == self.userPhoneNumField || textField == self.userPhoneCodeField) {
            if (![self validateNumber:string]) {
                return NO;
            }else{
                return YES;
            }
        }
        else{
            return YES;
        }

    }
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}


-(void)textFieldDidChanged:(UITextField *)textField
{
    NSLog(@"----------%@",textField.text);
    if (textField == self.userPhoneNumField) {
        if (self.userPhoneNumField.text.length == 11){
            self.loginBtn.enabled = YES;
            self.loginCodeBtn.enabled = YES;
            UIImage *norImage = [UIImage imageNamed:@"btn_login_nor"];
            UIImage *hightLightImage = [UIImage imageNamed:@"btn_login_pre"];
            [self.loginBtn setBackgroundImage:[ImageUtils resizableBgImage:norImage] forState:UIControlStateNormal];
            [self.loginBtn setBackgroundImage:[ImageUtils resizableBgImage:hightLightImage] forState:UIControlStateHighlighted];
            
            [self.loginCodeBtn setBackgroundImage:[UIImage imageNamed:@"btn_code_pre"]  forState:UIControlStateNormal];
            [self.loginCodeBtn setTitleColor:[ColorUtils colorWithHexString:@"#6f4841"] forState:UIControlStateNormal];
            
        }else{
            self.loginBtn.enabled = NO;
            self.loginCodeBtn.enabled = NO;
            UIImage *image = [UIImage imageNamed:@"btn_login_nor"];
            [self.loginBtn setBackgroundImage:[ImageUtils resizableBgImage:image] forState:UIControlStateNormal];
            [self.loginBtn setBackgroundImage:[ImageUtils resizableBgImage:image] forState:UIControlStateHighlighted];
            
            [self.loginCodeBtn setBackgroundImage:[UIImage imageNamed:@"btn_code_nor"]  forState:UIControlStateNormal];
            [self.loginCodeBtn setTitleColor:[ColorUtils colorWithHexString:common_app_text_color] forState:UIControlStateNormal];
            
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
                [self.loginCodeBtn setTitle:@"重新发送验证码" forState:UIControlStateNormal];
                self.loginCodeBtn.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"____%@",strTime);
                [self.loginCodeBtn setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                self.loginCodeBtn.userInteractionEnabled = NO;
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
