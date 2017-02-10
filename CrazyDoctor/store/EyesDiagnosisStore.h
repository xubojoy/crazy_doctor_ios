//
//  EyesDiagnosisStore.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/29.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EyesDiagnosisStore : NSObject
+(void) getUserEyesDiagnoses:(void(^)(NSDictionary *eyesDiagnoseDic, NSError *err))completionBlock;

+(void) confirmEyesDiagnoses:(void(^)(NSDictionary *dict, NSError *err))completionBlock  userLeftSelectPositions:(NSArray *)userLeftSelectPositions userRightSelectPositions:(NSArray *)userRightSelectPositions userLeftEyeImageUrl:(NSString *)userLeftEyeImageUrl userRightEyeImageUrl:(NSString *)userRightEyeImageUrl;

+(void) getUserEyesDiagnosesLaterRecord:(void(^)(NSDictionary *eyesDiagnoseDic, NSError *err))completionBlock;

@end
