//
//  UINavigationController+Autorotate.h
//  LeCloudLivingPlayerDemo
//
//  Created by zjc on 15/1/8.
//  Copyright (c) 2015年 letv. All rights reserved.
//

#import "UINavigationController+Autorotate.h"


@implementation UINavigationController (Autorotate)


- (BOOL)shouldAutorotate{
    return self.topViewController.shouldAutorotate;
}

//返回最上层的子Controller的supportedInterfaceOrientations
- (NSUInteger)supportedInterfaceOrientations{
    return self.topViewController.supportedInterfaceOrientations;
}

-(UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}

@end
