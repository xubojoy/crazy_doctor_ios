//
//  BaiduPushProcessor.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/17.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "BaiduPushProcessor.h"
#import "ArticleDetailController.h"
#import "AppClientStore.h"
#import "DoctorDetailController.h"
#import "ProjectsDetailController.h"
#import "CrazyDoctorTabbar.h"
#import "AppDelegate.h"
#import "LocalNotificationprocessor.h"
static BOOL isBackGroundActivateApplication;
@implementation BaiduPushProcessor
+ (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    // 在 App 启动时注册百度云推送服务，需要提供 Apikey
    [BPush registerChannel:launchOptions apiKey:@"t5Zccd8hjTwWLobPqdG5E9Hh" pushMode:BPushModeProduction withFirstAction:@"打开" withSecondAction:@"回复" withCategory:@"test" useBehaviorTextInput:YES isDebug:YES];
    // App 是用户点击推送消息启动
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    NSLog(@"程序启动%@",userInfo);
    if (userInfo) {
        [BaiduPushProcessor sharedInstance].userInfoDict = userInfo;;
        [BPush handleNotification:userInfo];
    }
    
#if TARGET_IPHONE_SIMULATOR
    Byte dt[32] = {0xc6, 0x1e, 0x5a, 0x13, 0x2d, 0x04, 0x83, 0x82, 0x12, 0x4c, 0x26, 0xcd, 0x0c, 0x16, 0xf6, 0x7c, 0x74, 0x78, 0xb3, 0x5f, 0x6b, 0x37, 0x0a, 0x42, 0x4f, 0xe7, 0x97, 0xdc, 0x9f, 0x3a, 0x54, 0x10};
    [self application:application didRegisterForRemoteNotificationsWithDeviceToken:[NSData dataWithBytes:dt length:32]];
#endif
    //角标清0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    return YES;

}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler naviagtionController:(UINavigationController *)nav{
    self.navigationController = nav;
    completionHandler(UIBackgroundFetchResultNewData);
    self.userInfoDict = userInfo;
    NSArray *keyArray = [userInfo allKeys];
    NSString *typeStr = keyArray[1];
    self.typeStr = typeStr;
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
    // 打印到日志 textView 中
    NSLog(@"********** iOS7.0之后 background **********%@",keyArray);
    // 应用在前台，不跳转页面，让用户选择。
    if (application.applicationState == UIApplicationStateActive) {
        NSLog(@"acitve ");
        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"通知" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
    //杀死状态下，直接跳转到跳转页面。
    if (application.applicationState == UIApplicationStateInactive && !isBackGroundActivateApplication)
    {
        
        [self jumpForPushUrl];
        NSLog(@"applacation is unactive ===== %@",userInfo);
    }
    // 应用在后台。当后台设置aps字段里的 content-available 值为 1 并开启远程通知激活应用的选项
    if (application.applicationState == UIApplicationStateBackground) {
        NSLog(@"background is Activated Application ===== %@",userInfo);
        // 此处可以选择激活应用提前下载邮件图片等内容。
        isBackGroundActivateApplication = YES;
        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"通知" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
        
    
    NSLog(@"fetchCompletionHandler%@",userInfo);
}

+ (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{    
    NSLog(@"test:%@",deviceToken);
    [BPush registerDeviceToken:deviceToken];
    [BPush bindChannelWithCompleteHandler:^(id result, NSError *error) {
        // 需要在绑定成功后进行 settag listtag deletetag unbind 操作否则会失败
        
        // 网络错误
        if (error) {
            return ;
        }
        if (result) {
            // 确认绑定成功
            if ([result[@"error_code"]intValue]!=0) {
                return;
            }
            // 获取channel_id
            NSString *myChannel_id = [BPush getChannelId];
            NSLog(@"==%@",myChannel_id);
            if (![[AppStatus sharedInstance].deviceToken isEqualToString:myChannel_id]) {
                [AppClientStore updateAppClient];
            }
            [AppStatus sharedInstance].deviceToken = myChannel_id;
            
            [BPush listTagsWithCompleteHandler:^(id result, NSError *error) {
                if (result) {
                    NSLog(@"result ============== %@",result);
                }
            }];
            [BPush setTag:@"Mytag" withCompleteHandler:^(id result, NSError *error) {
                if (result) {
                    NSLog(@"设置tag成功");
                }
            }];
        }
    }];

}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo naviagtionController:(UINavigationController *)nav{
    self.navigationController = nav;
    // App 收到推送的通知
    [BPush handleNotification:userInfo];
    
    self.userInfoDict = userInfo;
    NSArray *keyArray = [userInfo allKeys];
    NSString *typeStr = keyArray[1];
    self.typeStr = typeStr;
    
    NSLog(@"********** ios7.0之前 **********----%@",userInfo);
    // 应用在前台 或者后台开启状态下，不跳转页面，让用户选择。
    if (application.applicationState == UIApplicationStateActive || application.applicationState == UIApplicationStateBackground) {
        NSLog(@"acitve or background");
        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"通知" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
    else//杀死状态下，直接跳转到跳转页面。
    {

        [self jumpForPushUrl];
    }
    NSLog(@"didReceiveRemoteNotification%@",userInfo);
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self jumpForPushUrl];

    }
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)jumpForPushUrl{
    if ([self.typeStr isEqualToString:@"aId"]) {
        int aId = [self.userInfoDict[@"aId"] intValue];
        ArticleDetailController *skipCtr = [[ArticleDetailController alloc]initWithArticleId:aId articleTitle:self.userInfoDict[@"aps"][@"alert"] articleLogo:nil recommendTime:0 recommendArticleId:0];
        // 根视图是nav 用push 方式跳转
        [self.navigationController pushViewController:skipCtr animated:YES];
        
    }else if([self.typeStr isEqualToString:@"dId"]){
        int dId = [self.userInfoDict[@"dId"] intValue];
        DoctorDetailController *ddvc = [[DoctorDetailController alloc] initWithDoctorId:dId];
        [self.navigationController pushViewController:ddvc animated:YES];
    }else if ([self.typeStr isEqualToString:@"pId"]){
        int pId = [self.userInfoDict[@"pId"] intValue];
        ProjectsDetailController *pdvc = [[ProjectsDetailController alloc] initWithProjectId:pId];
        [self.navigationController pushViewController:pdvc animated:YES];
        
    }else{
        CrazyDoctorTabbar *tabBar = [(AppDelegate*)[UIApplication sharedApplication].delegate tabbar];
        if ([tabBar.tabBarController selectedIndex] != tabbar_item_index_jinnang) {
            UINavigationController *navController = [tabBar getSelectedViewController];
            [navController popToRootViewControllerAnimated:NO];
            [tabBar.tabBarController setSelectedIndex:tabbar_item_index_jinnang];
        }else{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}

+ (BaiduPushProcessor *) sharedInstance{
    static BaiduPushProcessor *sharedInstance = nil;
    if(sharedInstance == nil){
        sharedInstance = [[BaiduPushProcessor alloc] init];
    }
    
    return sharedInstance;
}

@end
