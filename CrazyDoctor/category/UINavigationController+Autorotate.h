//
//  UINavigationController+Autorotate.h
//  LeCloudLivingPlayerDemo
//
//  Created by zjc on 15/1/8.
//  Copyright (c) 2015年 letv. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UINavigationController (Autorotate)

- (BOOL)shouldAutorotate;
- (NSUInteger)supportedInterfaceOrientations;
-(UIViewController *)childViewControllerForStatusBarStyle;
@end
