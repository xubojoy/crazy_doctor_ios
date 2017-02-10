//
//  PayProcessor.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/6/27.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "PayProcessor.h"
#import "MyWalletController.h"
#import "MyOrdersController.h"
#define TEN_PAYMENT  @"微信支付"
#define ALI_APP_PAYMENT    @"支付宝"

#import "WXApi.h"
#import "AppDelegate.h"
//-------------------------------------------
//  支付类型的数据结构
//-------------------------------------------
@implementation PaymentType

-(id) initWithName:(NSString *)paymentTypeName paymentTypeIcon:(NSString *)paymentTypeIcon subName:(NSString *)subName{
    self = [super init];
    _paymentTypeName = paymentTypeName;
    _paymentTypeIcon = paymentTypeIcon;
    _subName = subName;
    return self;
}


-(BOOL) isTenPay{
    if ([self.paymentTypeName isEqualToString:TEN_PAYMENT]) {
        return YES;
    }
    return NO;
}

-(BOOL) isALIAPPPay{
    if ([self.paymentTypeName isEqualToString:ALI_APP_PAYMENT]) {
        return YES;
    }
    return NO;
}

@end

//-------------------------------------------
//  支付处理器
//-------------------------------------------

@implementation PayProcessor

/**
 *  获取支付方式
 */
-(NSMutableArray *) getPaymentTypes{
    if (self.paymentTypes == nil ) {
        self.paymentTypes = [[NSMutableArray alloc] init];
    }else{
        [self.paymentTypes removeAllObjects];
    }
//    if ([WXApi isWXAppInstalled]) {
        PaymentType *paymentType = [[PaymentType alloc] initWithName:TEN_PAYMENT paymentTypeIcon:@"icon_wechat_payment" subName:@"推荐已安装微信客户端的用户使用"];
        [self.paymentTypes addObject:paymentType];
//    }
    
    if (![DeviceUtils isIpad]) {
        PaymentType *paymentType = [[PaymentType alloc] initWithName:ALI_APP_PAYMENT paymentTypeIcon:@"icon_alipay" subName:@"推荐已安装支付宝客户端的用户使用"];
        [self.paymentTypes addObject:paymentType];
    }
    
    return self.paymentTypes;
}

/**
 *  获取默认的支付类型
 */
-(PaymentType *) getDefaultPaymentType{
    if (self.paymentTypes == nil) {
        [self getPaymentTypes];
    }
    return self.paymentTypes[0];
}



-(void) processFailPayment:(UINavigationController *)nav{
    if ([self.type isEqualToString:type_project]){
        [nav popToRootViewControllerAnimated:NO];
        CrazyDoctorTabbar *tabBar = [(AppDelegate*)[UIApplication sharedApplication].delegate tabbar];
        [tabBar.tabBarController setSelectedIndex:tabbar_item_index_me];
        
        UINavigationController *navController = [tabBar getSelectedViewController];
        
        NSString *url = [NSString stringWithFormat:@"%@/myOrders?Authorization=%@&isAppOpen=1&noHeaderFlag=1&noLocationFlag=0&orderType=projects",[AppStatus sharedInstance].wxpubUrl,[AppStatus sharedInstance].user.accessToken];
        MyOrdersController *mcvc = [[MyOrdersController alloc] initWithUrl:url];
        [navController pushViewController:mcvc animated:YES];
        [tabBar.tabBarController setTabBarHidden:YES animated:YES];
    }else if ([self.type isEqualToString:type_doctor]){
        [nav popToRootViewControllerAnimated:NO];
        CrazyDoctorTabbar *tabBar = [(AppDelegate*)[UIApplication sharedApplication].delegate tabbar];
        [tabBar.tabBarController setSelectedIndex:tabbar_item_index_me];
        
        UINavigationController *navController = [tabBar getSelectedViewController];
        
        NSString *url = [NSString stringWithFormat:@"%@/myOrders?Authorization=%@&isAppOpen=1&noHeaderFlag=1&noLocationFlag=0&orderType=doctors",[AppStatus sharedInstance].wxpubUrl,[AppStatus sharedInstance].user.accessToken];
        MyOrdersController *mcvc = [[MyOrdersController alloc] initWithUrl:url];
        [navController pushViewController:mcvc animated:YES];
        [tabBar.tabBarController setTabBarHidden:YES animated:YES];
    }
}

-(void) successRedirect:(UINavigationController *)nav type:(NSString *)type{
    [SVProgressHUD dismiss];
    if ([type isEqualToString:type_recharge]) {
        for (UIViewController *vc in nav.viewControllers) {
            if([vc isKindOfClass:[MyWalletController class]]){
                [[NSNotificationCenter defaultCenter] postNotificationName:@"重新加载我的钱包页" object:nil];
                [nav popToViewController:vc animated:YES];
            }
        }
    }else if ([type isEqualToString:type_project]){
        [nav popToRootViewControllerAnimated:NO];
        CrazyDoctorTabbar *tabBar = [(AppDelegate*)[UIApplication sharedApplication].delegate tabbar];
        [tabBar.tabBarController setSelectedIndex:tabbar_item_index_me];
        
        UINavigationController *navController = [tabBar getSelectedViewController];
        
        NSString *url = [NSString stringWithFormat:@"%@/myOrders?Authorization=%@&isAppOpen=1&noHeaderFlag=1&noLocationFlag=0&orderType=projects",[AppStatus sharedInstance].wxpubUrl,[AppStatus sharedInstance].user.accessToken];
        MyOrdersController *mcvc = [[MyOrdersController alloc] initWithUrl:url];
        [navController pushViewController:mcvc animated:YES];
        [tabBar.tabBarController setTabBarHidden:YES animated:YES];
    }else{
        [nav popToRootViewControllerAnimated:NO];
        CrazyDoctorTabbar *tabBar = [(AppDelegate*)[UIApplication sharedApplication].delegate tabbar];
        [tabBar.tabBarController setSelectedIndex:tabbar_item_index_me];
        
        UINavigationController *navController = [tabBar getSelectedViewController];
        
        NSString *url = [NSString stringWithFormat:@"%@/myOrders?Authorization=%@&isAppOpen=1&noHeaderFlag=1&noLocationFlag=0&orderType=doctors",[AppStatus sharedInstance].wxpubUrl,[AppStatus sharedInstance].user.accessToken];
        MyOrdersController *mcvc = [[MyOrdersController alloc] initWithUrl:url];
        [navController pushViewController:mcvc animated:YES];
        [tabBar.tabBarController setTabBarHidden:YES animated:YES];
    }
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {  // 点查看进行跳转
        
    }
}

+(PayProcessor *) sharedInstance{
    static PayProcessor *sharedInstance = nil;
    if (sharedInstance == nil) {
        if (sharedInstance == nil) {
            sharedInstance = [PayProcessor new];
        }
    }
    return sharedInstance;
}

//========================================================================================
//  支付结果 的 代理方法
//========================================================================================

-(void) wxpaymentSuccess:(UINavigationController *)nav{
//
    self.navigationController = nav;
    self.type = type_recharge;
    self.isClick = NO;
    [self popSuccessView];
}

-(void) wxpaymentFail:(UINavigationController *)nav{
    self.type = type_recharge;
    [self processFailPayment:nav];
}

-(void) wxpaymentProjectSuccess:(UINavigationController *)nav{
    self.type = type_project;
    self.navigationController = nav;
    self.isClick = NO;
    [self popSuccessView];

}
-(void) wxpaymentProjectFail:(UINavigationController *)nav{
    self.type = type_project;
    [self processFailPayment:nav];
}

-(void) wxpaymentDoctorSuccess:(UINavigationController *)nav{
    self.type = type_doctor;
    self.navigationController = nav;
    self.isClick = NO;
    [self popSuccessView];
}

-(void) wxpaymentDoctorFail:(UINavigationController *)nav{
    self.type = type_doctor;
    [self processFailPayment:nav];
}


- (void)popSuccessView{
    self.popUpView = [[PopUpView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    [self.navigationController.view addSubview:self.popUpView];
    
    self.xbPopView = [[XbPopView alloc] initWithFrame:CGRectMake((screen_width-280)/2, 205, 280, 155) remindImg:@"bg_success"];
    self.xbPopView.userInteractionEnabled = YES;
    self.xbPopView.delegate = self;
    if (self.isClick == NO) {
        [self performSelector:@selector(didCancelBtnClick:) withObject:nil afterDelay:3.0f];
    }
    
    //下拉动画
    [UIView animateWithDuration:0.2 animations:^{
        self.xbPopView.center =  CGPointMake(screen_width/2, screen_height/2);
    }];
    [self.navigationController.view addSubview:self.xbPopView];
    [self.navigationController.view bringSubviewToFront:self.xbPopView];
    
}

- (void)didCancelBtnClick:(UIButton *)sender{
    self.isClick = YES;
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(didCancelBtnClick:) object:nil];
    [self.popUpView removeFromSuperview];
    [self.xbPopView removeFromSuperview];
    [self successRedirect:self.navigationController type:self.type];
}

@end
