//
//  AppClientStore.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/23.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "AppClientStore.h"

@implementation AppClientStore
+(void) updateAppClient{
    HttpRequestFacade *request = [HttpRequestFacade sharedInstance];
    NSString *url = [NSString stringWithFormat:@"%@/appClients",[AppStatus sharedInstance].apiUrl];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [request put:url completionBlock:^(NSString *json, NSError *err) {
            //            NSLog(@">> put app client :%@" , json);
        }];
    });
}

@end
