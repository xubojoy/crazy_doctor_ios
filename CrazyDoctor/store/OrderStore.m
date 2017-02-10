//
//  OrderStore.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/9.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "OrderStore.h"

@implementation OrderStore

+(void) getProjectById:(void(^)(NSDictionary *projectDict, NSError *err))completionBlock projectId:(int)projectId{
    HttpRequestFacade *request = [HttpRequestFacade sharedInstance];
    AppStatus *as = [AppStatus sharedInstance];
    NSString *url = [NSString stringWithFormat:@"/projects/%d?poi=%f,%f",projectId,[as lastLng], [as lastLat]];
    [request get:url completionBlock:^(id json, NSError *err) {
        if (err == nil) {
            NSDictionary *projectDict = json;
            NSLog(@">>>>>>>>>>>>projectDict>>>>>>>>>%@",projectDict);
            completionBlock(projectDict, nil);
        }else if(err != nil){
            completionBlock(nil, err);
        }
    } refresh:NO useCacheIfNetworkFail:NO];
}

+(void) confirmOrderProject:(void(^)(ProjectOrder *project, NSError *err))completionBlock project:(NewProjectOrder *)newProjectOrder redEnvelopeId:(int)redEnvelopeId paymentType:(NSString *)paymentType{
    HttpRequestFacade *requestFacade = [HttpRequestFacade sharedInstance];
    NSString *url = [NSString stringWithFormat:@"%@/projectOrders?redEnvelopeId=%d&paymentType=%@",[AppStatus sharedInstance].apiUrl,redEnvelopeId,paymentType];
//    [requestFacade post:url completionBlock:^(id json, NSError *err) {
//        NSLog(@">>>>>>>>>project>>>>>>>>>%@",json);
//        if (err == nil) {
//            NSDictionary *dic = json;
//            ProjectOrder *project = [[ProjectOrder alloc] initWithDictionary:dic error:nil];
//            NSLog(@">>>>>>>>>添加返回值project>>>>>>>>>%@",project);
//            completionBlock(project, nil);
//        }else if (err != nil){
//            completionBlock(nil, err);
//        }
//    } jsonString:[newProjectOrder toDictionary]];
    [requestFacade asiPost:url completionBlock:^(NSString *json, NSError *err) {
        NSLog(@">>>>>>>>>project>>>>>>>>>%@",json);
        if (err == nil) {
//            NSDictionary *dic = [json objectFromJSONString];
            ProjectOrder *project = [[ProjectOrder alloc] initWithString:json error:nil];
            NSLog(@">>>>>>>>>添加返回值project>>>>>>>>>%@",project);
            completionBlock(project, nil);
        }else if (err != nil){
            completionBlock(nil, err);
        }
    } jsonString:[newProjectOrder toJSONString]];
}

+(void) getDoctorById:(void(^)(NSDictionary *doctorDict, NSError *err))completionBlock doctorId:(int)doctorId{
    HttpRequestFacade *request = [HttpRequestFacade sharedInstance];
    NSString *url = [NSString stringWithFormat:@"/doctors/%d",doctorId];
    [request get:url completionBlock:^(id json, NSError *err) {
        if (err == nil) {
            NSDictionary *doctorDict = json;
            NSLog(@">>>>>>>>>>>>doctorDict>>>>>>>>>%@",doctorDict);
            completionBlock(doctorDict, nil);
        }else if(err != nil){
            completionBlock(nil, err);
        }
    } refresh:NO useCacheIfNetworkFail:NO];
}

+(void) confirmDoctorOrder:(void(^)(DoctorOrder *doctor, NSError *err))completionBlock doctor:(NewDoctorOrder *)newDoctorOrder redEnvelopeId:(int)redEnvelopeId paymentType:(NSString *)paymentType{
    HttpRequestFacade *requestFacade = [HttpRequestFacade sharedInstance];
    NSString *url = [NSString stringWithFormat:@"%@/doctorOrders?redEnvelopeId=%d&paymentType=%@",[AppStatus sharedInstance].apiUrl,redEnvelopeId,paymentType];
    [requestFacade post:url completionBlock:^(id json, NSError *err) {
        NSLog(@">>>>>>>>>doctor>>>>>>>>>%@",json);
        if (err == nil) {
            NSDictionary *dic = json;
            DoctorOrder *doctor = [[DoctorOrder alloc] initWithDictionary:dic error:nil];
            NSLog(@">>>>>>>>>添加返回值doctor>>>>>>>>>%@",doctor);
            completionBlock(doctor, nil);
        }else if (err != nil){
            completionBlock(nil, err);
        }
    } jsonString:[newDoctorOrder toDictionary]];
}

+(void) payUserDoctorOrderByorderNumber:(void(^)(NSDictionary *doctorDict, NSError *err))completionBlock doctorOrderNumber:(NSString *)doctorOrderNumber{
    HttpRequestFacade *requestFacade = [HttpRequestFacade sharedInstance];
    NSString *url = [NSString stringWithFormat:@"%@/doctorOrders/pay/%@",[AppStatus sharedInstance].apiUrl,doctorOrderNumber];
    [requestFacade put:url completionBlock:^(id json, NSError *err) {
        if (err == nil) {
            NSDictionary *dict = json;
            completionBlock(dict,nil);
        }else{
            completionBlock(nil,err);
        }
        
    }];
}
+(void) payUserProjectOrderByorderNumber:(void(^)(NSDictionary *projectDict, NSError *err))completionBlock projectOrderNumber:(NSString *)projectOrderNumber{

    HttpRequestFacade *requestFacade = [HttpRequestFacade sharedInstance];
    NSString *url = [NSString stringWithFormat:@"%@/projectOrders/pay/%@",[AppStatus sharedInstance].apiUrl,projectOrderNumber];
    [requestFacade put:url completionBlock:^(id json, NSError *err) {
        if (err == nil) {
            NSDictionary *dict = json;
            completionBlock(dict,nil);
        }else{
            completionBlock(nil,err);
        }
    }];
}


@end
