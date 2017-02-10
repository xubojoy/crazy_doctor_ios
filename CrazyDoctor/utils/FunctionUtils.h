//
//  FunctionUtils.h
//  styler
//
//  Created by 冯聪智 on 14-9-19.
//  Copyright (c) 2014年 mlzj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FunctionUtils : NSObject

+(void)setTimeout:(void (^)())block delayTime:(float)delayTime;

+ (NSString *)getChineseNum:(int)num;

+ (NSString *)getChineseNumByBool:(int)num;

+ (CGSize)getCGSizeByString:(NSString *)string font:(CGFloat)font;

+ (NSMutableArray *)getRandomDataArray:(NSMutableArray *)commonArray chooseNum:(int)chooseNum;

+ (CGAffineTransform)getAngleByTime;

+ (int)getRemarkNum:(int)hour;
//
//+ (NSString *)getTimeStrByHour:(int)hour;
+ (void)scheduleLocalNotification:(NSString *)timeStr notificationId:(NSString *)notificationId content:(NSString *)content;
+ (void)removeLocalNotification:(NSString *)notificationId;
//+ (void)notificationByRemarkNum:(int)hour remarkNo:(int)remarkNo;

+ (BOOL)isDefaultPushTimes:(NSString *)pushtimes;

+ (void)startDefaultNotifi;
+ (void)closeDefaultNotifi;
+ (void)clearAllLocalNotifi;

+ (void)startCustomNotifiByTimes:(NSString *)time;

+ (BOOL)isCustomPushTimes:(NSString *)pushtimes;

+ (NSString *)getAcupointByTimeStr:(NSString *)timeStr;

@end
