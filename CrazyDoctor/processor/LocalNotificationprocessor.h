//
//  LocalNotificationprocessor.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/23.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalNotificationprocessor : NSObject<UIAlertViewDelegate>

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic ,strong) NSString *bodyName;

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification naviagtionController:(UINavigationController *)nav;
- (void)jumpDetailWithName:(NSString *)bodyName navigationController:(UINavigationController *)navigationController;

+ (LocalNotificationprocessor *) sharedInstance;

@end
