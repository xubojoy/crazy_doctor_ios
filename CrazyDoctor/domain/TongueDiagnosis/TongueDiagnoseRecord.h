//
//  TongueDiagnoseRecord.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/27.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DiagnoseQaRecord.h"
#import "BodyTag.h"
@protocol TongueDiagnoseRecord
@end
@interface TongueDiagnoseRecord : JSONModel

@property (nonatomic ,assign) int id;
@property (nonatomic ,assign) int userId;
@property (nonatomic ,strong) NSString<Optional> *userTongueImageUrl;//舌头照片地址
@property (nonatomic ,strong) NSArray<BodyTag *><Optional> *bodyTags;//渲染的体质标签
@property (nonatomic ,strong) NSString<Optional> *diagnoseQaRecordsJson;// 舌诊问题记录
@property (nonatomic ,strong) NSString<Optional> *tongueDiagnoseResult;// 舌诊结果
@property (nonatomic ,strong) NSArray<DiagnoseQaRecord *><Optional> *diagnoseQaRecords;// 舌诊问题对象集合
@property (nonatomic ,assign) long long int createTime;

@end
