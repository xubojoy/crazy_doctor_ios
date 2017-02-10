//
//  LocalNotificationprocessor.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/23.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "LocalNotificationprocessor.h"
#import "CheckAcupointViewController.h"
#import "BPush.h"
#import "MeridianStore.h"
#import "Meridian.h"
#import "Acupoint.h"
#import "CrazyDoctorTabbar.h"
#import "AppDelegate.h"
@implementation LocalNotificationprocessor

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification naviagtionController:(UINavigationController *)nav{
    self.navigationController = nav;
    NSLog(@">>>>>>>notification.alertBody>>>>%@",notification.alertBody);
    self.bodyName = notification.alertBody;
    [AppStatus sharedInstance].acupointName = self.bodyName;
    [AppStatus saveAppStatus];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:notification.alertBody delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"确认",nil];
    [alert show];
    NSLog(@"接收本地通知啦！！！");
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"刷新穴位" object:self.bodyName];
    if (buttonIndex == 1) {
        [self jumpDetailWithName:self.bodyName navigationController:self.navigationController];
    }
}

- (void)jumpDetailWithName:(NSString *)bodyName navigationController:(UINavigationController *)navigationController{
    [MeridianStore getMeridiansInfo:^(NSArray *meridiansArray, NSError *err) {
        if ([meridiansArray isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dict in meridiansArray) {
                Meridian *meridian = [[Meridian alloc] initWithDictionary:dict error:nil];
                if (meridian != nil) {
                    if (meridian.acupoints.count > 0) {
                        for (NSDictionary *dic in meridian.acupoints) {
                            Acupoint *acupoint = [[Acupoint alloc] initWithDictionary:dic error:nil];
                            if (acupoint != nil) {
                                if ([bodyName isEqualToString:acupoint.name]) {
                                    
                                    [[AppStatus sharedInstance].user addReadArticle:acupoint.id];
                                    [[AppStatus sharedInstance] addHasReadArticle:acupoint.id];
                                    [AppStatus saveAppStatus];
                                    
                                    CrazyDoctorTabbar *tabBar = [(AppDelegate*)[UIApplication sharedApplication].delegate tabbar];
                                    if ([tabBar.tabBarController selectedIndex] != tabbar_item_index_jinnang) {
                                        UINavigationController *navController = [tabBar getSelectedViewController];
                                        [navController popToRootViewControllerAnimated:NO];
                                        [tabBar.tabBarController setSelectedIndex:tabbar_item_index_jinnang];
                                    }else{
                                        [navigationController popToRootViewControllerAnimated:YES];
                                    }
                                    
                                    CheckAcupointViewController *cavc = [[CheckAcupointViewController alloc] initWithAcupoint:acupoint meridian:meridian];
                                    // 根视图是nav 用push 方式跳转
                                    [navigationController pushViewController:cavc animated:YES];
                                }
                                
                            }
                        }
                    }
                }
            }
            
        }else{
            ExceptionMsg *exception = [[err userInfo] objectForKey:@"ExceptionMsg"];
            [self.navigationController.view makeToast:exception.message duration:2.0 position:[NSValue valueWithCGPoint:self.navigationController.view.center]];
        }
    }];
}

+ (LocalNotificationprocessor *) sharedInstance{
    static LocalNotificationprocessor *sharedInstance = nil;
    if(sharedInstance == nil){
        sharedInstance = [[LocalNotificationprocessor alloc] init];
    }
    
    return sharedInstance;
}


@end
