//
//  WeiXinPayProcessor.m
//  styler
//
//  Created by 冯聪智 on 14-10-10.
//  Copyright (c) 2014年 mlzj. All rights reserved.
//

#import "WeiXinPayProcessor.h"
#import "PayProcessor.h"
#import <objc/runtime.h>
#import "DataMD5.h"
#import "UserStore.h"
@implementation WeiXinPayProcessor

-(void)doWeixinpay:(NSString *)outTradeTitle outTradeNo:(NSString *)outTradeNo totalPrice:(float)totalPrice buyer:(NSString *)buyer tradeType:(NSString *)tradeType type:(NSString *)type navigationController:(UINavigationController *)navigationController{
    self.type = type;
    self.navigationController = navigationController;
    [UserStore weiXinPayOrderClub:^(NSDictionary *weixinPayInfo, NSError *err) {
        NSLog(@">>>>>>>>>>>>获取支付信息---------%@",weixinPayInfo);
        if (weixinPayInfo != nil) {
            if ([WXApi isWXAppInstalled]) {
                PayReq *request = [[PayReq alloc] init];
                request.partnerId = [weixinPayInfo valueForKey:@"mch_id"];
                request.prepayId= [weixinPayInfo valueForKey:@"prepay_id"];
                request.package = @"Sign=WXPay";
                request.nonceStr= [weixinPayInfo valueForKey:@"nonce_str"];
                //发起微信支付，设置参数
                //将当前事件转化成时间戳
                NSDate *datenow = [NSDate date];
                NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
                UInt32 timeStamp =[timeSp intValue];
                request.timeStamp= timeStamp;
                DataMD5 *md5 = [[DataMD5 alloc] init];
                request.sign=[md5 createMD5SingForPay:[weixinPayInfo valueForKey:@"appid"] partnerid:request.partnerId prepayid:request.prepayId package:request.package noncestr:request.nonceStr timestamp:request.timeStamp];
                //            调用微信
                if(![WXApi sendReq:request]){
                    [SVProgressHUD showErrorWithStatus:@"调用微信支付app失败"];
                }
//                NSLog(@">>>>>>>>>>>>>>>>>>>>%d--%@--%@-%@-%@-%d-%@-%@",(unsigned int)timeStamp,request.partnerId,request.prepayId,request.package,request.nonceStr,request.timeStamp,request.sign,[weixinPayInfo valueForKey:@"appid"]);
            }else if(![WXApi isWXAppInstalled]){
               [SVProgressHUD showErrorWithStatus:@"未安装微信客户端"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"生成微信支付预订单失败"];
        }

    } payAmount:totalPrice orderNum:outTradeNo buyer:buyer desc:outTradeTitle tradeType:tradeType type:type];
}

-(void)onResp:(BaseResp*)resp{

    if ([resp isKindOfClass:[PayResp class]]) {
        PayResp *response = (PayResp *)resp;
        NSLog(@">>>>>>>支付结果>>>>>>>>>%d>>>>%@",response.errCode,response.errStr);
        switch (response.errCode) {
            case WXSuccess:
                {
//                    [SVProgressHUD showSuccessWithStatus:@"支付成功"];
                    
                    if ([self.type isEqualToString:type_recharge]) {
                        if ([self.delegate respondsToSelector:@selector(wxpaymentSuccess:)]) {
                            [self.delegate wxpaymentSuccess:self.navigationController];
                        }
                    }else if([self.type isEqualToString:type_project]){
                        if ([self.delegate respondsToSelector:@selector(wxpaymentProjectSuccess:)]) {
                            [self.delegate wxpaymentProjectSuccess:self.navigationController];
                        }
                    }else{
                        if ([self.delegate respondsToSelector:@selector(wxpaymentDoctorSuccess:)]) {
                            [self.delegate wxpaymentDoctorSuccess:self.navigationController];
                        }
                    }

                }
                break;
            default:
                {
                    [SVProgressHUD showErrorWithStatus:@"订单未支付"];
                    if ([self.type isEqualToString:type_recharge]) {
                        if ([self.delegate respondsToSelector:@selector(wxpaymentFail:)]) {
                            [self.delegate wxpaymentFail:self.navigationController];
                        }
                    }else if([self.type isEqualToString:type_project]){
                        if ([self.delegate respondsToSelector:@selector(wxpaymentProjectFail:)]) {
                            [self.delegate wxpaymentProjectFail:self.navigationController];
                        }
                    }else{
                        if ([self.delegate respondsToSelector:@selector(wxpaymentDoctorFail:)]) {
                            [self.delegate wxpaymentDoctorFail:self.navigationController];
                        }
                    }
                }
                break;
        }
    }
}

+ (WeiXinPayProcessor *) sharedInstance{
    static WeiXinPayProcessor *sharedInstance = nil;
    if(sharedInstance == nil){
        sharedInstance = [[WeiXinPayProcessor alloc] init];
    }
    return sharedInstance;
}

@end
