//
//  PayProcessor.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/6/27.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlipayProceessor.h"
#import "WeiXinPayProcessor.h"
#import "PopUpView.h"
#import "XbPopView.h"

@class AlipayProceessor;
//-------------------------------------------
//  支付类型的数据结构
//-------------------------------------------
@interface PaymentType : NSObject

@property (nonatomic, copy , readonly) NSString *paymentTypeIcon;
@property (nonatomic, copy , readonly) NSString *paymentTypeName;
@property (nonatomic, strong) NSString *subName;

-(instancetype) init __attribute__((unavailable("Must use initWithPaymentTypeName method instead.")));
-(id) initWithName:(NSString *)paymentTypeName paymentTypeIcon:(NSString *)paymentTypeIcon subName:(NSString *)subName;
-(BOOL) isTenPay;
-(BOOL) isALIAPPPay;

@end


//-------------------------------------------
//  支付处理器
//-------------------------------------------
@interface PayProcessor : NSObject<WeiXinPayProcessorDelegate,XbPopViewDelegate>

@property (nonatomic , strong) NSMutableArray *paymentTypes;
@property (nonatomic ,strong) PopUpView *popUpView;
@property (nonatomic ,strong) XbPopView *xbPopView;
@property (nonatomic ,assign) BOOL isClick;
@property (nonatomic ,strong) UINavigationController *navigationController;
@property (nonatomic ,strong) NSString *type;

-(instancetype)init __attribute__((unavailable("Must use sharedInstance method instead.")));

-(NSMutableArray *) getPaymentTypes;
-(PaymentType *) getDefaultPaymentType;

+(PayProcessor *) sharedInstance;
@end
