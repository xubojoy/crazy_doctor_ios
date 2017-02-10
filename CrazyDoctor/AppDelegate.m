//
//  AppDelegate.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/3/31.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "AppDelegate.h"
#import "GaodeMapProcessor.h"
#import "URLDispatcher.h"
#import "WXApi.h"
#import "ShareSDKProcessor.h"
#import "UMengSDKProcessor.h"
#import "UserStore.h"
#import "BaiduPushProcessor.h"
#import "AppClientStore.h"
#import "LocalNotificationprocessor.h"
#import "XQNewFeatureVC.h"
#import "MeridianStore.h"
#import "Meridian.h"
#import "WCDSharkeyFunction.h"
#import "WeiXinPayProcessor.h"
@interface AppDelegate ()<CLLocationManagerDelegate>
{
    CLLocationManager      *_locationmanager;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
#if TARGET_OS_IPHONE
    if (IOS8) {
        [UIApplication sharedApplication].idleTimerDisabled = TRUE;
        _locationmanager = [[CLLocationManager alloc] init];
        [_locationmanager requestWhenInUseAuthorization];     //NSLocationWhenInUseDescription
        _locationmanager.delegate = self;
        //        [_locationmanager startUpdatingLocation];
    }
#endif
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"First"]) {
        XQNewFeatureVC *newVc = [[XQNewFeatureVC alloc] initWithFeatureImagesNameArray:@[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg"]];
        self.window.rootViewController = newVc;
        newVc.completeBlock = ^{
            //初始化App的底栏
            self.tabbar = [CrazyDoctorTabbar new];
            self.window.rootViewController = self.tabbar.tabBarController;
        };
        [self.window makeKeyAndVisible];
      
    }else{
        //初始化App的底栏
        self.tabbar = [CrazyDoctorTabbar new];
        self.window.rootViewController = self.tabbar.tabBarController;
    }
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"First"];

    ////    定位
    //初始化友盟用于统计
    [UMengSDKProcessor initUMengSDK];
    //    shareSDK
    [ShareSDKProcessor initShareSDK];
    //注册联网状态的通知监听器
    self.netProcessor = [NetworkProcessor new];
    [self.netProcessor initNetWork];
    [[GaodeMapProcessor sharedInstance] startLocation];
    
    
    [WXApi registerApp:weixin_app_id];
    /**
     * 注册接收PUSH
     *
     *  @param respondsToSelector:@selectorisRegisteredForRemoteNotifications
     *
     *  @return ios8 之后以下方法有所调整，这里是判断版本，从而使用相应的注册远程通知方法。
     */
    // iOS8 下需要使用新的 API
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        //UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        
       // UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
       // [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
        
        UIUserNotificationType noteType = UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge;
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:noteType categories:nil];
        [application registerUserNotificationSettings:setting];
        
        
    }else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
    
    [BaiduPushProcessor application:application didFinishLaunchingWithOptions:launchOptions];
    
    UILocalNotification * localNotify = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if(localNotify)
    {
        [AppStatus sharedInstance].acupointName = localNotify.alertBody;
        [AppStatus saveAppStatus];
        [[LocalNotificationprocessor  sharedInstance] jumpDetailWithName:localNotify.alertBody navigationController:[self.tabbar getViewController:0]];
    }
    
    [WCDSharkeyFunction configuration:self];

    return YES;
}

#pragma mark -----链接跳转回调

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    UINavigationController *nav = [self.tabbar getSelectedViewController];
    BOOL result =  [URLDispatcher dispatch:url nav:nav];
    if(!result){
//        [ShareSDK handleOpenURL:url
//              sourceApplication:sourceApplication
//                     annotation:annotation
//                     wxDelegate:self];
    }
    if ([NSStringUtils isNotBlank:sourceApplication] ) {
        
       
    }
    
    return result;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
    UINavigationController *nav = [self.tabbar getSelectedViewController];
    BOOL result =  [URLDispatcher dispatch:url nav:nav];
    NSLog(@">>>>>>H5跳转>>>>>>%d",result);
    if(!result){
        NSLog(@">>>>>>H5跳转>>>>>>%d",result);
        WeiXinPayProcessor *wxpayProcessor = [WeiXinPayProcessor sharedInstance];
        return  [WXApi handleOpenURL:url delegate:wxpayProcessor];
    }
    
    return  result;
}

// 此方法是 用户点击了通知，应用在前台 或者开启后台并且应用在后台 时调起
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [[BaiduPushProcessor sharedInstance] application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler naviagtionController:[self.tabbar getSelectedViewController]];
    NSLog(@">>>>>userInfo>>>>%@",userInfo);
}

// 在 iOS8 系统中，还需要添加这个方法。通过新的 API 注册推送服务
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [[LocalNotificationprocessor  sharedInstance] application:application didReceiveLocalNotification:notification naviagtionController:[self.tabbar getSelectedViewController]];
    NSLog(@">>>>>>>notification.alertBody佛法的闪光灯和>>>>%@",notification.alertBody);
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
  [BaiduPushProcessor application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

// 当 DeviceToken 获取失败时，系统会回调此方法
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"DeviceToken 获取失败，原因：%@",error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@">>>>>userInfo>>>>%@",userInfo);
    [[BaiduPushProcessor sharedInstance] application:application didReceiveRemoteNotification:userInfo naviagtionController:[self.tabbar getSelectedViewController]];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    debugMethod();
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    WCDSharkeyFunction *wcd = [WCDSharkeyFunction shareInitializationt];
    Sharkey *sharkey = [wcd currentSharkey];
    SharkeyState state = [wcd querySharkeyState];
    if (state == SharkeyStateConnected) {
        [wcd disconnectSharkey:sharkey];
    }
    [AppStatus saveAppStatus];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [application cancelAllLocalNotifications];
    [application setApplicationIconBadgeNumber:0];
    NSMutableDictionary *meridianDictionary = [NSMutableDictionary new];
    [MeridianStore getMeridiansInfo:^(NSArray *meridiansArray, NSError *err) {
        if ([meridiansArray isKindOfClass:[NSArray class]]) {
            
            for (NSDictionary *dict in meridiansArray) {
                Meridian *meridian = [[Meridian alloc] initWithDictionary:dict error:nil];
                if (meridian != nil) {
                    [meridianDictionary setObject:meridian.acupoints forKey:[NSString stringWithFormat:@"%d",meridian.beginTime]];
                }
            }
            
            [AppStatus sharedInstance].meridianDict = meridianDictionary;
            [AppStatus saveAppStatus];
//            NSLog(@">>>>>>>>[AppStatus sharedInstance].meridianDict>保存的字典>>>>>>>>>>>%@",[AppStatus sharedInstance].meridianDict);
        }
    }];
    
    if ([[AppStatus sharedInstance] logined]) {
        [[UserStore sharedStore] getUserInfo:^(User *user, NSError *err) {
            if (user != nil) {
//                NSLog(@">>>>>useruseruseruseruser>>>>>%@",user);
                [AppStatus sharedInstance].user = user;
                [AppStatus saveAppStatus];
                if (user.receivePush == YES) {
                    if ([NSStringUtils isNotBlank:user.pushTimes]) {
                        NSString *pushTimes = user.pushTimes;
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
                    [application cancelAllLocalNotifications];
                }
                
            }else{
                ExceptionMsg *exception = [[err userInfo] objectForKey:@"ExceptionMsg"];
                NSLog(@">>>>>>>>>>>>>>>%d",exception.code);
                if (exception.code == 401 || exception.code == 40001) {
                    [[UserStore sharedStore] removeSession:^(NSError *err) {
                        AppStatus *as = [AppStatus sharedInstance];
                        [[NSURLCache sharedURLCache] removeCachedResponseForRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:as.user.avatarUrl]]];// 清除旧的头像缓存
                        [as initBaseData];
                        [AppStatus saveAppStatus];
                        
                        [((AppDelegate *)[UIApplication sharedApplication].delegate).tabbar.tabBarController setTabBarHidden:NO animated:NO];
                        [((AppDelegate *)[UIApplication sharedApplication].delegate).tabbar setSelectedIndex:0];
                        
                    } accessToken:[AppStatus sharedInstance].user.accessToken];
                }
            }
        }];
    }
    
    int hour = [DateUtils getCurrentDateHour];
    NSDate *date = [NSDate date];
    NSString *nowStr = [DateUtils getDateByDate:date];
    NSArray *array = [nowStr componentsSeparatedByString:@" "];
    NSLog(@"date1111111 = %@", array);
    NSString *datastr = array[0];
    int remarkNo = [FunctionUtils getRemarkNum:hour];
    NSString *tmpDataStr = [NSString stringWithFormat:@"%@%d",datastr,remarkNo];
    if (![tmpDataStr isEqualToString:[AppStatus sharedInstance].remarkDataStr]) {
        [AppStatus sharedInstance].remarkDataStr = tmpDataStr;
        [AppStatus sharedInstance].recommendAcupointTime = nowStr;
        [AppStatus saveAppStatus];
    }
    
    NSLog(@">>>>>>>>>>>>>当前时间>>>>>>>>>>%d---%d---%@",hour,remarkNo,[AppStatus sharedInstance].remarkDataStr);
    [AppStatus saveAppStatus];
    [AppClientStore updateAppClient];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    debugMethod();
    WCDSharkeyFunction *wcd = [WCDSharkeyFunction shareInitializationt];
    Sharkey *sharkey = [wcd currentSharkey];
    SharkeyState state = [wcd querySharkeyState];
    if (state == SharkeyStateConnected) {
        [wcd disconnectSharkey:sharkey];
    }
}
//禁止第三方键盘
//- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(NSString *)extensionPointIdentifier
//{
//    return NO;
//}

@end
