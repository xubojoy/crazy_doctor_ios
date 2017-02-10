//
//  UserStore.h
//  Golf
//
//  Created by xubojoy on 15/3/30.
//  Copyright (c) 2015年 xubojoy. All rights reserved.
//

#import "AFNetworking.h"
@interface HttpRequestFacade : NSObject
//refresh参数用于强制更新，禁用缓存
-(void)             get:(NSString *)urlStr
        completionBlock:(void (^)(id json, NSError *err))completionBlock
                refresh:(BOOL)refresh
  useCacheIfNetworkFail:(BOOL)useCacheIfNetworkFail;

-(void)           doGet:(NSURL *)url
        completionBlock:(void (^)(id json, NSError *err))completionBlock
                refresh:(BOOL)refresh
  useCacheIfNetworkFail:(BOOL)useCacheIfNetworkFail;

-(void)           doIOSGet:(NSURL *)url
        completionBlock:(void (^)(id json, NSError *err))completionBlock
                refresh:(BOOL)refresh
  useCacheIfNetworkFail:(BOOL)useCacheIfNetworkFail;

-(void)           asiDoGet:(NSURL *)url
        completionBlock:(void (^)(NSString *json, NSError *err))completionBlock
                refresh:(BOOL)refresh
  useCacheIfNetworkFail:(BOOL)useCacheIfNetworkFail;

-(void)          post:(NSString *)urlStr
      completionBlock:(void (^)(id json, NSError *err))completionBlock
               commonParams:(NSDictionary *)params;

-(void)          post:(NSString *)urlStr
      completionBlock:(void (^)(id json, NSError *err))comletionBlock
               params:(NSDictionary *)params;

-(void)          post:(NSString *)urlStr
      completionBlock:(void (^)(id json, NSError *err))completionBlock
           jsonString:(NSDictionary *)jsonString;

-(void)          asiPost:(NSString *)urlStr
      completionBlock:(void (^)(NSString *json, NSError *err))comletionBlock
               params:(NSDictionary *)params;

-(void)          asiPost:(NSString *)urlStr
      completionBlock:(void (^)(NSString *json, NSError *err))completionBlock
           jsonString:(NSString *)jsonString;

-(void)        delete:(NSString *)urlStr
completionBlock:(void (^)(id json, NSError *err))completionBlock
            param:(NSDictionary *)param;

-(void)        put:(NSString *)urlStr
   completionBlock:(void (^)(id json, NSError *err))completionBlock;

-(void)        put:(NSString *)urlStr
   completionBlock:(void (^)(id json, NSError *err))completionBlock
            params:(NSDictionary *)params;


+(HttpRequestFacade *)sharedInstance;

@end
