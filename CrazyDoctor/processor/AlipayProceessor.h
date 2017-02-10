//
//  AlipayProceessor.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/13.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlixPayOrder.h"
#import "PayProcessor.h"
#import "UserAccountRecharge.h"
#import "PopUpView.h"
#import "XbPopView.h"
#import "ProjectOrder.h"
#import "DoctorOrder.h"
@class PaymentType;
//@protocol AlipayProceessorDrelegate <NSObject>
//
//-(void) paymentSuccess:(UINavigationController *)nav;
//-(void) paymentFail:(UINavigationController *)nav;
//
//@end

@interface AlipayProceessor : NSObject<UIAlertViewDelegate,XbPopViewDelegate>
@property (nonatomic , strong) UINavigationController *navigationController;
//@property (nonatomic , assign) id<AlipayProceessorDrelegate> delegate;
@property (nonatomic ,strong) PopUpView *popUpView;
@property (nonatomic ,strong) XbPopView *xbPopView;
@property (nonatomic ,assign) BOOL isClick;
@property (nonatomic ,strong) NSString *type;
//ProjectOrder
+ (AlipayProceessor *) sharedInstance;
-(void) processPaymentResultFromApp:(NSURL *)result nav:(UINavigationController *)nav;
-(void)doAlipay:(AlixPayOrder *)payOrder paymentType:(NSString *)paymentType type:(NSString *)type navigationController:(UINavigationController *)navigationController;
-(AlixPayOrder *) buildAlixPayOrderByHdcOrder:(UserAccountRecharge *)hdcOrder type:(NSString *)type subject:(NSString *)subject;
-(AlixPayOrder *) buildAlixPayOrderByProjectOrder:(ProjectOrder *)projectOrder type:(NSString *)type subject:(NSString *)subject;

-(AlixPayOrder *) buildAlixPayOrderByDoctorOrder:(DoctorOrder *)projectOrder type:(NSString *)type subject:(NSString *)subject;
@end
