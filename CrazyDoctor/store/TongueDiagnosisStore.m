//
//  TongueDiagnosisStore.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/26.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "TongueDiagnosisStore.h"

@implementation TongueDiagnosisStore

+(void) getUserTongueDiagnoses:(void(^)(NSDictionary *tongueDiagnoseDic, NSError *err))completionBlock{
    HttpRequestFacade *request = [HttpRequestFacade sharedInstance];
    NSString *url = [NSString stringWithFormat:@"/tongueDiagnoses"];
    [request get:url completionBlock:^(id json, NSError *err) {
        if (err == nil) {
            NSDictionary *tongueDiagnoseDic = json;
//            NSLog(@">>>>>>>>>>>>tongueDiagnoseDic>>>>>>>>>%@",tongueDiagnoseDic);
            completionBlock(tongueDiagnoseDic, nil);
        }else if(err != nil){
            completionBlock(nil, err);
        }
    } refresh:NO useCacheIfNetworkFail:NO];
}


+(void) getAllBodyTags:(void(^)(NSArray *tags, NSError *err))completionBlock{

    HttpRequestFacade *request = [HttpRequestFacade sharedInstance];
    NSString *url = [NSString stringWithFormat:@"/bodyTags"];
    [request get:url completionBlock:^(id json, NSError *err) {
        if (err == nil) {
            NSArray *tags = json;
//            NSLog(@">>>>>>>>>>>>tags>>>>>>>>>%@",tags);
            completionBlock(tags, nil);
        }else if(err != nil){
            completionBlock(nil, err);
        }
    } refresh:NO useCacheIfNetworkFail:NO];
}

+(void) upLoadTongueDiagnosisImg:(void(^)(NSString *imgUrl, NSError *err))completionBlock tongueImage:(UIImage *)image{

    HttpRequestFacade *requestFacade = [HttpRequestFacade sharedInstance];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:image forKey:@"image"];
    [requestFacade asiPost:[NSString stringWithFormat:@"%@/images/upload",[AppStatus sharedInstance].apiUrl] completionBlock:^(NSString *json, NSError *err) {
        if(err == nil){
            NSString *imgUrl = json;
            NSLog(@"更新成功--%@",imgUrl);
            completionBlock(imgUrl,nil);
        }else{
            completionBlock(nil,err);
        }
    } params:params];

}
+(void) confirmTongueDiagnosisTest:(void(^)(NSDictionary *dict, NSError *err))completionBlock userTongueUrl:(NSString *)userTongueUrl bodyTagIds:(NSArray *)bodyTagIds userSelectQuestions:(NSArray *)userSelectQuestions isPingHe:(BOOL)isPingHe{
    NSString *tags = [bodyTagIds componentsJoinedByString:@","];
    HttpRequestFacade *requestFacade = [HttpRequestFacade sharedInstance];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:userTongueUrl forKey:@"userTongueUrl"];
    [params setObject:tags forKey:@"bodyTagIds"];
    [params setObject:@(isPingHe) forKey:@"pinghe"];
    [params setObject:[userSelectQuestions componentsJoinedByString:@","] forKey:@"userSelectQuestions"];
    [requestFacade post:[NSString stringWithFormat:@"%@/tongueDiagnoses",[AppStatus sharedInstance].apiUrl] completionBlock:^(id json, NSError *err) {
        if(err == nil){
            NSDictionary *dic = json;
//            NSLog(@"更新成功--%@",dic);
            completionBlock(dic,nil);
        }else{
            completionBlock(nil,err);
        }
    } commonParams:params];
}

@end
