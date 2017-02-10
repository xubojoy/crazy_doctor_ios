//
//  NewSharkeyData.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/19.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SleepDetail.h"
@protocol NewSharkeyData
@end
@interface NewSharkeyData : JSONModel

@property (nonatomic ,assign) int userId;
@property (nonatomic ,assign) long long int createTime;//字符串 示例“2016-07-18”
@property (nonatomic ,assign) NSInteger step;//步数
@property (nonatomic ,assign) CGFloat distance;
@property (nonatomic ,assign) CGFloat kCall;
@property (nonatomic ,assign) long long int sleepStartMinutes;//开始睡眠时间
@property (nonatomic ,assign) NSInteger sleepTimeTotal;// 睡眠总时长
@property (nonatomic ,assign) NSInteger sleepTimeDeep;// 深度睡眠时长
@property (nonatomic ,assign) NSInteger sleepTimeLight;// 浅度睡眠市场
@property (nonatomic ,strong) NSMutableArray<SleepDetail *><Optional> *sleepDetails;//睡眠详情List对象

@end
