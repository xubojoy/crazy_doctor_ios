//
//  CityStore.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/13.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "CityStore.h"

@implementation CityStore
+(void) getAllCitys:(void(^)(NSDictionary *dict, NSError *err))completionBlock{

    HttpRequestFacade *request = [HttpRequestFacade sharedInstance];
//    AppStatus *as = [AppStatus sharedInstance];
    NSString *url = [NSString stringWithFormat:@"/areas"];
    //    NSLog(@">>>>>>>>>>>>url>>>>>>>>>%@",url);
    [request get:url completionBlock:^(id json, NSError *err) {
        if (err == nil) {
            NSDictionary *areaDict = json;
//            NSLog(@">>>>>>>>>>>>areaDict>>>>>>>>>%@",areaDict);
            completionBlock(areaDict, nil);
        }else if(err != nil){
            completionBlock(nil, err);
        }
    } refresh:NO useCacheIfNetworkFail:NO];
}

+(void) getAllHotCitys:(void(^)(NSArray *hotCitiesArr, NSError *err))completionBlock{
    HttpRequestFacade *request = [HttpRequestFacade sharedInstance];
    NSString *url = [NSString stringWithFormat:@"/cities/hot"];
    [request get:url completionBlock:^(id json, NSError *err) {
        if (err == nil) {
            NSArray *hotCitiesArr = json;
//            NSLog(@">>>>>>>>>>>>hotCitiesArr>>>>>>>>>%@",hotCitiesArr);
            completionBlock(hotCitiesArr, nil);
        }else if(err != nil){
            completionBlock(nil, err);
        }
    } refresh:NO useCacheIfNetworkFail:NO];
}

@end
