//
//  SleepDetail.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/19.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol SleepDetail
@end
@interface SleepDetail : JSONModel
@property (nonatomic ,assign) long long int sleepStartMinutes;//深度睡眠开始时间 date类型
@property (nonatomic ,assign) long long int sleepEndMinutes;// 深度睡眠结束时间 date类型
@property (nonatomic ,assign) int deep;// 睡眠时长

@end
