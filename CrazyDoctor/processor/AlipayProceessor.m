//
//  AlipayProceessor.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/13.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "AlipayProceessor.h"
#import "AlixPayResult.h"
#import "UserStore.h"
#import "AlixPayOrder.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "PartnerConfig.h"
#import "MyWalletController.h"
#import "MyOrdersController.h"
@implementation AlipayProceessor
-(void) processPaymentResultFromApp:(NSURL *)result nav:(UINavigationController *)nav{
    //跳转支付宝钱包进行支付，处理支付结果
    self.navigationController = nav;
    self.isClick = NO;
    [[AlipaySDK defaultService] processOrderWithPaymentResult:result standbyCallback:^(NSDictionary *resultDic) {
        NSLog(@"result22222222222 = %@",resultDic);
        if (resultDic != nil) {
            int resultStatus = [resultDic[@"resultStatus"] intValue];
            //支付成功跳转到我的美发卡列表页
            if (resultStatus == 9000){
                [self popSuccessView];
            }
            //支付失败
            else{
               [SVProgressHUD showErrorWithStatus:@"订单未支付"];
                [self failRedirect:self.navigationController type:self.type];
            }
        }
    }];
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

-(void) failRedirect:(UINavigationController *)nav type:(NSString *)type{
    if ([type isEqualToString:type_project]){
        [nav popToRootViewControllerAnimated:NO];
        CrazyDoctorTabbar *tabBar = [(AppDelegate*)[UIApplication sharedApplication].delegate tabbar];
        [tabBar.tabBarController setSelectedIndex:tabbar_item_index_me];
        
        UINavigationController *navController = [tabBar getSelectedViewController];
        
        NSString *url = [NSString stringWithFormat:@"%@/myOrders?Authorization=%@&isAppOpen=1&noHeaderFlag=1&noLocationFlag=0&orderType=projects",[AppStatus sharedInstance].wxpubUrl,[AppStatus sharedInstance].user.accessToken];
        MyOrdersController *mcvc = [[MyOrdersController alloc] initWithUrl:url];
        [navController pushViewController:mcvc animated:YES];
        [tabBar.tabBarController setTabBarHidden:YES animated:YES];
    }else if ([type isEqualToString:type_doctor]){
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

-(void)doAlipay:(AlixPayOrder *)payOrder paymentType:(NSString *)paymentType type:(NSString *)type navigationController:(UINavigationController *)navigationController{
    self.navigationController = navigationController;
    self.type = type;
    self.isClick = NO;
    [SVProgressHUD dismiss];
    AppStatus *as = [AppStatus sharedInstance];
    if ([paymentType isEqualToString:ALI_APP_PAYMENT]) {
        payOrder.notifyURL = [[NSString stringWithFormat:@"%@/alipay/notification", as.paymentUrl] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *appScheme = @"doctor";
        NSString* orderInfo = [payOrder description];
        NSString* signedStr = [self doRsa:orderInfo];
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                                 orderInfo, signedStr, @"RSA"];
        NSLog(@"orderString调起支付宝 = %@",orderString);
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut1111111111111111 = %@",resultDic);
            if (resultDic != nil) {
                int resultStatus = [resultDic[@"resultStatus"] intValue];
                if (resultStatus == 9000){
                    [self popSuccessView];
                }
                //支付失败
                else{
                   [SVProgressHUD showErrorWithStatus:@"订单未支付"];
                    [self failRedirect:self.navigationController type:self.type];
                }
            }
        }];
    }
}

-(AlixPayOrder *) buildAlixPayOrderByHdcOrder:(UserAccountRecharge *)cdOrder type:(NSString *)type subject:(NSString *)subject{
    AlixPayOrder *payOrder = [AlixPayOrder new];
    payOrder.partner = PartnerID;
    payOrder.sellerID = SellerID;
    payOrder.outTradeNO = [NSString stringWithFormat:@"%@-%@",cdOrder.orderNumber,type];
    payOrder.totalFee = [NSString stringWithFormat:@"%.2f", cdOrder.price];
    
    payOrder.service = @"mobile.securitypay.pay";
    payOrder.inputCharset = @"utf-8";
    payOrder.notifyURL = [[NSString stringWithFormat:@"%@/alipay/notification", [AppStatus sharedInstance].paymentUrl] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    payOrder.subject = subject;
    payOrder.body = payOrder.subject;
    
    return payOrder;
}

-(AlixPayOrder *) buildAlixPayOrderByProjectOrder:(ProjectOrder *)projectOrder type:(NSString *)type subject:(NSString *)subject{
    AlixPayOrder *payOrder = [AlixPayOrder new];
    payOrder.partner = PartnerID;
    payOrder.sellerID = SellerID;
    payOrder.outTradeNO = [NSString stringWithFormat:@"%@-%@",projectOrder.orderNo,type];
    payOrder.totalFee = [NSString stringWithFormat:@"%.2f", projectOrder.orderPrice];
//    projectOrder.orderPrice
    payOrder.service = @"mobile.securitypay.pay";
    payOrder.inputCharset = @"utf-8";
    payOrder.notifyURL = [[NSString stringWithFormat:@"%@/alipay/notification", [AppStatus sharedInstance].paymentUrl] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    payOrder.subject = subject;
    payOrder.body = payOrder.subject;
    
    return payOrder;

}

-(AlixPayOrder *) buildAlixPayOrderByDoctorOrder:(DoctorOrder *)projectOrder type:(NSString *)type subject:(NSString *)subject{
    AlixPayOrder *payOrder = [AlixPayOrder new];
    payOrder.partner = PartnerID;
    payOrder.sellerID = SellerID;
    payOrder.outTradeNO = [NSString stringWithFormat:@"%@-%@",projectOrder.orderNo,type];
    payOrder.totalFee = [NSString stringWithFormat:@"%.2f", projectOrder.orderPrice];
    //    projectOrder.orderPrice
    payOrder.service = @"mobile.securitypay.pay";
    payOrder.inputCharset = @"utf-8";
    payOrder.notifyURL = [[NSString stringWithFormat:@"%@/alipay/notification", [AppStatus sharedInstance].paymentUrl] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    payOrder.subject = subject;
    payOrder.body = payOrder.subject;
    
    return payOrder;
}

-(NSString*)doRsa:(NSString*)orderInfo
{
    id<DataSigner> signer;
    signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderInfo];
    return signedString;
}

-(void)paymentResultDelegate:(NSURL *)result
{
    [[AlipayProceessor sharedInstance] processPaymentResultFromApp:result nav:self.navigationController];
}


+ (AlipayProceessor *) sharedInstance{
    static AlipayProceessor *sharedInstance = nil;
    if(sharedInstance == nil){
        sharedInstance = [[AlipayProceessor alloc] init];
    }
    
    return sharedInstance;
}

@end
