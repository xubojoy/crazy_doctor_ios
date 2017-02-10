//
//  OrderStore.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/9.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewProjectOrder.h"
#import "ProjectOrder.h"
#import "DoctorOrder.h"
#import "NewDoctorOrder.h"
@interface OrderStore : NSObject

+(void) getProjectById:(void(^)(NSDictionary *projectDict, NSError *err))completionBlock projectId:(int)projectId;

+(void) confirmOrderProject:(void(^)(ProjectOrder *project, NSError *err))completionBlock project:(NewProjectOrder *)newProjectOrder redEnvelopeId:(int)redEnvelopeId paymentType:(NSString *)paymentType;

+(void) getDoctorById:(void(^)(NSDictionary *doctorDict, NSError *err))completionBlock doctorId:(int)doctorId;

+(void) confirmDoctorOrder:(void(^)(DoctorOrder *doctor, NSError *err))completionBlock doctor:(NewDoctorOrder *)newDoctorOrder redEnvelopeId:(int)redEnvelopeId paymentType:(NSString *)paymentType;

+(void) payUserDoctorOrderByorderNumber:(void(^)(NSDictionary *doctorDict, NSError *err))completionBlock doctorOrderNumber:(NSString *)doctorOrderNumber;
+(void) payUserProjectOrderByorderNumber:(void(^)(NSDictionary *projectDict, NSError *err))completionBlock projectOrderNumber:(NSString *)projectOrderNumber;

@end
