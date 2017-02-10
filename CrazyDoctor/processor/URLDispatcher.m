//
//  URLDispatcher.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/8.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "URLDispatcher.h"
#import "AppDelegate.h"
#import "NSString+stringPlus.h"
#import "DiscoverIndexController.h"
#import "UserCenterViewController.h"
#import "PhysiotherapyDetailConfirmController.h"
#import "OrderDoctorFillController.h"
#import "AlipayProceessor.h"
#import "WalletRecordontroller.h"
#import "MyWalletController.h"
#import "UserUnpaySelectPayTypeController.h"
@implementation URLDispatcher
+(BOOL) dispatch:(NSURL *)url nav:(UINavigationController *)nav
{
    NSLog(@"点用了连接:%@",url);
    NSString *path = [url path];
    NSString *params = [url query];
    NSString *host = [url host];
    if ([host isEqualToString:[AppStatus sharedInstance].hostUrl]) {
        NSLog(@">>>>>>>path>>>>>%@",path);
        if([path rangeOfString:@"/backdiscover"].location < path.length)
        {
            NSLog(@">>>>>>>进来了>>>>>");
            if(nav.viewControllers.count >= 2 && [nav.viewControllers[nav.viewControllers.count-2] isKindOfClass:[DiscoverIndexController class]]){
                [nav popToViewController:nav.viewControllers[nav.viewControllers.count-2] animated:YES];
                return YES;
            }
        }else if ([path rangeOfString:@"/backmine"].location < path.length){
            if(nav.viewControllers.count >= 2 && [nav.viewControllers[nav.viewControllers.count-2] isKindOfClass:[UserCenterViewController class]]){
                [nav popToViewController:nav.viewControllers[nav.viewControllers.count-2] animated:YES];
                return YES;
            }
        }else if ([path rangeOfString:@"/wallet"].location < path.length){
            NSLog(@">>>>>>>跳转我的钱包>>>>>%@",url);
            if(nav.viewControllers.count >= 2 && [nav.viewControllers[nav.viewControllers.count-2] isKindOfClass:[MyWalletController class]]){
                [nav popToViewController:nav.viewControllers[nav.viewControllers.count-2] animated:YES];
                return YES;
            }
        }else if ([path rangeOfString:@"/projectOrder"].location < path.length && ![path containsString:@"/projectOrderDetail"]){
            NSLog(@">>>>>>>params>>>>>%@",params);
            if (![[AppStatus sharedInstance] logined]) {
                UserLoginViewController *ulc = [[UserLoginViewController alloc] initWithFrom:account_session_from_OrderPhysiotherapy];
                [nav pushViewController:ulc animated:YES];
                
            }else{
                NSArray *array = [params componentsSeparatedByString:@"="];
                int projectId = [array[1] intValue];
                PhysiotherapyDetailConfirmController *pdvc = [[PhysiotherapyDetailConfirmController alloc] initWithProjectId:projectId];
                [nav pushViewController:pdvc animated:YES];
            }
        }else if ([path rangeOfString:@"/doctorOrder"].location < path.length && ![path containsString:@"/doctorOrderDetail"]){
            NSLog(@">>>>>>>到这params>>>>>%@",params);
            if (![[AppStatus sharedInstance] logined]) {
                UserLoginViewController *ulc = [[UserLoginViewController alloc] initWithFrom:account_session_from_OrderPhysiotherapy];
                [nav pushViewController:ulc animated:YES];
                
            }else{
                params = [params stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSMutableDictionary *dics = [params urlParamsChange2Dict];
                NSString *date = dics[@"date"];
                NSString *halfDay = dics[@"halfDay"];
                int doctorId = [dics[@"doctorId"] intValue];
                NSLog(@">>>>>>参数>dics>>>>>%@",dics);
                OrderDoctorFillController *odfvc = [[OrderDoctorFillController alloc] initWithDoctorId:doctorId date:date halfDay:halfDay];
                [nav pushViewController:odfvc animated:YES];
   
            }
        }else if ([path rangeOfString:@"/projectOrderDetail"].location < path.length){
            NSLog(@">>>>>>>到这projectOrderDetail>>>>>%@",params);
            NSArray *arr = [params componentsSeparatedByString:@"&"];
            NSString *str1 = [arr objectAtIndex:0];
            NSRange range1 = [str1 rangeOfString:@"id="];
            NSString *projectOrderIdStr = [str1 substringFromIndex:range1.location+3];
            NSString *str2 = [arr objectAtIndex:1];
            NSRange range2 = [str2 rangeOfString:@"orderNumber="];
            NSString *orderNumberStr = [str2 substringFromIndex:range2.location+12];
            UserUnpaySelectPayTypeController *uuspvc = [[UserUnpaySelectPayTypeController alloc] initWithId:[projectOrderIdStr intValue] orderType:project_order_detail orderNumber:orderNumberStr];
            [nav pushViewController:uuspvc animated:YES];

        }else if ([path rangeOfString:@"/doctorOrderDetail"].location < path.length){
            NSLog(@">>>>>>>到这params>doctorOrderDetail>>>>%@",params);
            NSArray *arr = [params componentsSeparatedByString:@"&"];
            NSString *str1 = [arr objectAtIndex:0];
            NSRange range1 = [str1 rangeOfString:@"id="];
            NSString *doctorOrderIdStr = [str1 substringFromIndex:range1.location+3];
            NSString *str2 = [arr objectAtIndex:1];
            NSRange range2 = [str2 rangeOfString:@"orderNumber="];
            NSString *orderNumberStr = [str2 substringFromIndex:range2.location+12];
            UserUnpaySelectPayTypeController *uuspvc = [[UserUnpaySelectPayTypeController alloc] initWithId:[doctorOrderIdStr intValue] orderType:doctor_order_detail orderNumber:orderNumberStr];
            [nav pushViewController:uuspvc animated:YES];
        }

    }else if([host isEqualToString:@"safepay"]){
        NSLog(@">>>>>> app alipay back:%@, path:%@, query:%@", url, [url path], [url query]);
        [[AlipayProceessor sharedInstance] processPaymentResultFromApp:url nav:nav];
        return YES;
    }
    return NO;
}

//OrderDoctorFillController

+(BOOL) dispatchWithContentSort:(int)contentSortId
                contentSortName:(NSString *)contentSortName
                    extendParam:(NSString *)extendParam
                contentModeType:(int)contentModeType
                            nav:(UINavigationController *)nav{
    //NSLog(@"contentSortId:%d, name:%@, extendParam:%@, modeType:%d", contentSortId, contentSortName, extendParam, contentModeType);
    
    switch (contentModeType) {
        case 1://标签作品；
            break;
        case 2://指定作品
            break;
        default:
            return NO;
    }
    return YES;
}

@end
