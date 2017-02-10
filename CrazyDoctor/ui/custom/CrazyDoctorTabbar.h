//
//  FunJoyTabbar.h
//  funjoy
//
//  Created by xubojoy on 16/3/11.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
@interface CrazyDoctorTabbar : NSObject<UINavigationControllerDelegate,RDVTabBarControllerDelegate>
@property (nonatomic,copy)NSString *currentPageName;

@property (nonatomic, strong) RDVTabBarController *tabBarController;

-(id) init;

-(UINavigationController *) getSelectedViewController;
-(UINavigationController *) getViewController:(int)index;

-(NSInteger) getSelectedIndex;
-(void) setSelectedIndex:(int)selectedIndex;
-(NSString *) getCurrentPageName;

@end
