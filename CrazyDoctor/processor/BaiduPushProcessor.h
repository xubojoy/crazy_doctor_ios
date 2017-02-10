//
//  BaiduPushProcessor.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/17.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPush.h"
#import "PushRecord.h"
@interface BaiduPushProcessor : NSObject<UIAlertViewDelegate>
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic ,strong) PushRecord *pushRecord;
@property (nonatomic ,strong) NSString *typeStr;
@property (nonatomic ,strong) NSDictionary *userInfoDict;


+ (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

+ (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler naviagtionController:(UINavigationController *)nav;

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo naviagtionController:(UINavigationController *)nav;

+ (BaiduPushProcessor *) sharedInstance;

@end
