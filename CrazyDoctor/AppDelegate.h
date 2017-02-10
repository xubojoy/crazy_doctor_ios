//
//  AppDelegate.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/3/31.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "CrazyDoctorTabbar.h"
#import "UserLoginViewController.h"
#import "NetworkProcessor.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic ,strong) UserLoginViewController *userLoginvc;
@property (nonatomic, strong) CrazyDoctorTabbar *tabbar;
@property (nonatomic ,strong) NetworkProcessor *netProcessor;

@end

