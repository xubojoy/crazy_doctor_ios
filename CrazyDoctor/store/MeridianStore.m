//
//  MeridianStore.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/4.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "MeridianStore.h"

@implementation MeridianStore

+(void) getMeridiansInfo:(void(^)(NSArray *meridiansArray, NSError *err))completionBlock{
    HttpRequestFacade *request = [HttpRequestFacade sharedInstance];
    NSString *url = [NSString stringWithFormat:@"/meridians/info"];
    [request get:url completionBlock:^(id json, NSError *err) {
        if (err == nil) {
            NSArray *meridiansArray = json;
//            NSLog(@">>>>>>>>>>>>meridiansArray>>>>>>>>>%@",meridiansArray);
            completionBlock(meridiansArray, nil);
        }else if(err != nil){
            completionBlock(nil, err);
        }
    } refresh:NO useCacheIfNetworkFail:NO];
}

+(void) confirmMeridianRecord:(void(^)(NSDictionary *dict, NSError *err))completionBlock  userId:(int)userId meridianId:(int)meridianId acupointId:(int)acupointId level:(int)level{
    HttpRequestFacade *requestFacade = [HttpRequestFacade sharedInstance];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@(userId) forKey:@"userId"];
    [params setObject:@(meridianId) forKey:@"meridianId"];
    [params setObject:@(acupointId) forKey:@"acupointId"];
    [params setObject:@(level) forKey:@"level"];
    [requestFacade post:[NSString stringWithFormat:@"%@/meridians",[AppStatus sharedInstance].apiUrl] completionBlock:^(id json, NSError *err) {
        if(err == nil){
            NSDictionary *dic = json;
            NSLog(@"经络记录--%@",dic);
            completionBlock(dic,nil);
        }else{
            completionBlock(nil,err);
        }
    } commonParams:params];
}

@end
