//
//  ArticleStore.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/19.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "ArticleStore.h"

@implementation ArticleStore

+ (void)getAllRecommendArticles:(void(^)(Page *page ,NSError *error))completionBlock city:(NSString *)city age:(int)age userGender:(NSString *)userGender bodyTags:(NSString *)bodyTags eyeTagNames:(NSString *)eyeTagNames session:(NSString *)session pageNo:(int)pageNo pageSize:(int)pageSize{
    HttpRequestFacade *request = [HttpRequestFacade sharedInstance];
    NSString *url = [NSString stringWithFormat:@"%@/recommendArticles/search?city=%@&age=%d&userGender=%@&bodyTags=%@&eyeTagNames=%@&session=%@&pageNo=%d&pageSize=%d",[AppStatus sharedInstance].apiUrl,city,age,userGender,bodyTags,eyeTagNames,session,pageNo,pageSize];
    NSLog(@">>>>即将请求>>>>>%@",url);
    NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *urlStr = [NSURL URLWithString:encoded];
    [request doGet:urlStr completionBlock:^(id json, NSError *err) {
//        NSLog(@">>>>>>>>>>>>>>>>获取文章json：%@",json);
        if (err == nil) {
            NSDictionary *jsonDict = json;
            Page *page = [[Page alloc] initWithJSONDictionary:jsonDict];
            NSArray *jsonDictArray = [jsonDict objectForKey:@"items"];
            page.items = jsonDictArray;
            completionBlock(page, nil);
        }else if(err != nil){
            completionBlock(nil, err);
        }
    } refresh:NO useCacheIfNetworkFail:NO];
}

+ (void)getAllIOSRecommendArticles:(void(^)(Page *page ,NSError *error))completionBlock city:(NSString *)city pageNo:(int)pageNo pageSize:(int)pageSize{
    HttpRequestFacade *request = [HttpRequestFacade sharedInstance];
    NSString *url;
    if ([AppStatus sharedInstance].logined) {
        url = [NSString stringWithFormat:@"%@/ios/recommendArticles/search?city=%@&Authorization=%@&pageNo=%d&pageSize=%d",[AppStatus sharedInstance].apiUrl,city,[AppStatus sharedInstance].user.accessToken,pageNo,pageSize];
        NSLog(@">>>>即将请求>>>>>%@",url);
    }else{
        url = [NSString stringWithFormat:@"%@/ios/recommendArticles/search?city=%@&Authorization=&pageNo=%d&pageSize=%d",[AppStatus sharedInstance].apiUrl,city,pageNo,pageSize];
        NSLog(@">>>>即将请求>>>>>%@",url);
    }
    
    NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *urlStr = [NSURL URLWithString:encoded];
    [request doIOSGet:urlStr completionBlock:^(id json, NSError *err) {
        //        NSLog(@">>>>>>>>>>>>>>>>获取文章json：%@",json);
        if (err == nil) {
            NSDictionary *jsonDict = json;
            Page *page = [[Page alloc] initWithJSONDictionary:jsonDict];
            NSArray *jsonDictArray = [jsonDict objectForKey:@"items"];
            page.items = jsonDictArray;
            completionBlock(page, nil);
        }else if(err != nil){
            completionBlock(nil, err);
        }
    } refresh:NO useCacheIfNetworkFail:NO];
}

+ (void)updateArticleReadCount:(void (^)(NSDictionary *dict, NSError *err))completionBlock articleId:(int)articleId{
    HttpRequestFacade *request = [HttpRequestFacade sharedInstance];
    NSString *url = [NSString stringWithFormat:@"%@/articles/%d/readCount",[AppStatus sharedInstance].apiUrl,articleId];
    [request put:url completionBlock:^(id json, NSError *err) {
        if (err == nil) {
            NSDictionary *dict = json;
            NSLog(@">>>>>>>>>>>>成功更新阅读数>>>>>>>>>%@",dict);
            completionBlock(dict, nil);
        }else if(err != nil){
            completionBlock(nil, err);
        }
    }];
}

@end
