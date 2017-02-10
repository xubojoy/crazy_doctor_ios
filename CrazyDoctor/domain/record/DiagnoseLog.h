//
//  DiagnoseLog.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/12.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol DiagnoseLog
@end
@interface DiagnoseLog : JSONModel
@property (nonatomic ,assign) int id;
@property (nonatomic ,assign) int userId;

@property (nonatomic ,strong) NSString<Optional> *diagnoseType;//诊断类型:舌诊:tongueDiagnose，眼诊:eyeDiagnose，经络:meridian
@property (nonatomic ,strong) NSString<Optional> *tongueUrl;// 舌头照片
@property (nonatomic ,strong) NSString<Optional> *bodyTagNames;// 眼健康标签
@property (nonatomic ,strong) NSString<Optional> *visceras;// 有问题的五脏六腑
@property (nonatomic ,strong) NSString<Optional> *acupoint;// 穴位
@property (nonatomic ,assign) int painLevel;// 穴位的疼痛级别 1，2，3，4
@property (nonatomic ,assign) long long int createTime;// 创建时间

@end
