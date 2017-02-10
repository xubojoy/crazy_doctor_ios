//
//  NetworkProcessor.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/14.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "NetworkProcessor.h"
#import "GaodeMapProcessor.h"
@implementation NetworkProcessor
-(void) initNetWork{
    NSLog(@">>>>> init NetWork ");
    
    //设置ASIHttpRequest，Http客户端组件
    
    //注册联网状态的通知监听器
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object: nil];
    self.reachability = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    [self.reachability startNotifier];
}

-(void)reachabilityChanged:(NSNotification *) note{
    //NSLog(@">>>>>>> reachability changed");
    Reachability *curReachability = [note object];
    NetworkStatus status = [curReachability currentReachabilityStatus];
    [AppStatus sharedInstance].networkStatus = status;
    if (status == NotReachable) {
        NSLog(@"网络不通");
    }else if(status == ReachableViaWiFi){
        NSLog(@"WIFI联网");
    }else if(status == ReachableViaWWAN){
        NSLog(@"2G/3G/4G/GPRS联网");
    }
    if(status != NotReachable){
        [[GaodeMapProcessor sharedInstance] startLocation];
    }
}

@end
