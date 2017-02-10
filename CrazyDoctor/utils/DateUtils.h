//
//  DateUtils.h
//  styler
//
//  Created by aypc on 13-10-16.
//  Copyright (c) 2013年 mlzj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtils : NSObject

-(id)initWithDate:(NSDate *)date;

@property int year;
@property int month;
@property int week;
@property int day;
@property int hour;
@property int min;
@property int second;
@property (nonatomic ,strong) NSString *session;
@property (nonatomic, strong) NSDate * date;
-(BOOL)isEqualToDateUtils:(DateUtils *)DU;

+(int)weekDayFromDate:(NSDate *)date;
+(NSInteger)stringToTime:(NSString *)timeStr;
+(NSString *)getDateByDate:(NSDate *)date;
+(NSString *)getFutureDateByDate:(NSDate *)date;
+(NSString *)getDateStringByDate:(NSDate *)date;
+(NSDate *)getDateByString:(NSString *)dateStr;
+(int)daysOfMonthWithDate:(NSDate *)date;

+ (int)getCurrentDateHour;

+ (NSInteger)numberOfDaysFromTodayByTime:(NSString *)time timeStringFormat:(NSString *)format;
+ (NSString *)getADayYouWantFromDate:(NSDate *)aDate withNumber:(NSString *)number;
+ (NSString *)getADayYearAndMonthFromDate:(NSDate *)aDate withNumber:(NSString *)number;
+(NSString *)getDateByFormatDate:(NSDate *)date dateFormat:(NSString *)dateFormat;

+(NSString *)getDateBySingleDate:(NSDate *)date;

+(NSDate *)getNewDateByString:(NSString *)dateStr;

+(NSString *)weekDayStringWithWeek:(int)week;
+(NSString *)weekDayStringByWeek:(int)week;
+(NSString *)weekDayByWeek:(int)week;
+(NSString *)getDateStringByDateString:(NSString *)dateStr;
+(NSString *)stringFromDate:(NSDate *)date;
+(NSString *)stringFromLongLongInt:(long long int)date;
+(NSString *)stringFromNumber:(NSNumber *)date;
+(NSString *)dateStringFromLongLongInt:(long long int)date;
+(NSString *)dateWithStringFromLongLongInt:(long long int)date;
+(NSString *)dateStringWithFromLongLongInt:(long long int)date;
+(NSString *)stringFromDateAndFormat:(NSDate *)date dateFormat:(NSString *)dateFormat;
+(NSString *)stringFromLongLongIntAndFormat:(long long int)date dateFormat:(NSString *)dateFormat;
+(NSString *)stringFromNumberAndFormat:(NSNumber *)date dateFormat:(NSString *)dateFormat;
+(NSString *)stringFromLongLongIntDate:(long long int)date;
+(NSDate *)dateFromLongLongInt:(long long int)date;
+(long long int)longlongintFromDate:(NSDate *)date;

+ (NSTimeInterval)getUTCFormateDate:(NSString *)newsDate;
+(NSString *)getDateByPickerDate:(NSDate *)date;

+(int) compare:(NSDate *)date1 date2:(NSDate *)date2;
+ (BOOL)intervalSinceNow: (NSString *) theDate;
@end
