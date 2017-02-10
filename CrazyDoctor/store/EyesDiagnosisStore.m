//
//  EyesDiagnosisStore.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/29.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "EyesDiagnosisStore.h"

@implementation EyesDiagnosisStore

+(void) getUserEyesDiagnoses:(void(^)(NSDictionary *eyesDiagnoseDic, NSError *err))completionBlock{
    HttpRequestFacade *request = [HttpRequestFacade sharedInstance];
    NSString *url = [NSString stringWithFormat:@"/eyePositions"];
    [request get:url completionBlock:^(id json, NSError *err) {
        if (err == nil) {
            NSDictionary *eyesDiagnoseDic = json;
            NSLog(@">>>>>>>>>>>>eyesDiagnoseDic>>>>>>>>>%@",eyesDiagnoseDic);
            completionBlock(eyesDiagnoseDic, nil);
        }else if(err != nil){
            completionBlock(nil, err);
        }
    } refresh:NO useCacheIfNetworkFail:NO];
}

+(void) confirmEyesDiagnoses:(void(^)(NSDictionary *dict, NSError *err))completionBlock  userLeftSelectPositions:(NSArray *)userLeftSelectPositions userRightSelectPositions:(NSArray *)userRightSelectPositions userLeftEyeImageUrl:(NSString *)userLeftEyeImageUrl userRightEyeImageUrl:(NSString *)userRightEyeImageUrl{
    HttpRequestFacade *requestFacade = [HttpRequestFacade sharedInstance];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[userLeftSelectPositions componentsJoinedByString:@","] forKey:@"userLeftSelectPositions"];
    [params setObject:[userRightSelectPositions componentsJoinedByString:@","] forKey:@"userRightSelectPositions"];
//    [params setObject:userLeftEyeImageUrl forKey:@"userLeftEyeImageUrl"];
//    [params setObject:userRightEyeImageUrl forKey:@"userRightEyeImageUrl"];
    
    [requestFacade post:[NSString stringWithFormat:@"%@/eyeDiagnoseRecords",[AppStatus sharedInstance].apiUrl] completionBlock:^(id json, NSError *err) {
        if(err == nil){
            NSDictionary *dic = json;
            NSLog(@"眼诊数据--%@",dic);
            completionBlock(dic,nil);
        }else{
            completionBlock(nil,err);
        }
    } commonParams:params];
}

+(void) getUserEyesDiagnosesLaterRecord:(void(^)(NSDictionary *eyesDiagnoseDic, NSError *err))completionBlock{
    HttpRequestFacade *request = [HttpRequestFacade sharedInstance];
    NSString *url = [NSString stringWithFormat:@"/eyeDiagnoseRecords"];
    [request get:url completionBlock:^(id json, NSError *err) {
        if (err == nil) {
            NSDictionary *eyesDiagnoseDic = json;
            NSLog(@">>>>>>>>>>>>eyesDiagnoseDic>>>>>>>>>%@",eyesDiagnoseDic);
            completionBlock(eyesDiagnoseDic, nil);
        }else if(err != nil){
            completionBlock(nil, err);
        }
    } refresh:NO useCacheIfNetworkFail:NO];

}

@end
