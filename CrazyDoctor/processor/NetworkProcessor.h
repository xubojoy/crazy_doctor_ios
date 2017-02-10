//
//  NetworkProcessor.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/14.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkProcessor : NSObject
@property (nonatomic, strong) Reachability *reachability;

-(void) initNetWork;
-(void)reachabilityChanged:(NSNotification *) note;
@end
