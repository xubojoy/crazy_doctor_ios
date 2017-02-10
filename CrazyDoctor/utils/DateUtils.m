//
//  DateUtils.m
//  styler
//
//  Created by aypc on 13-10-16.
//  Copyright (c) 2013年 mlzj. All rights reserved.
//

#import "DateUtils.h"
#import "TimeUtils.h"
@implementation DateUtils

-(id)initWithDate:(NSDate *)date
{
    self = [self init];
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy,MM,dd"];
    NSString * dateStr = [df stringFromDate:date];
    NSArray * dateArray = [dateStr componentsSeparatedByString:@","];
    self.year = [[dateArray objectAtIndex:0]intValue];
    self.month = [[dateArray objectAtIndex:1]intValue];
    self.session = [DateUtils sessionFromMonth:self.month];
    self.day = [[dateArray objectAtIndex:2]intValue];
    self.week = [DateUtils weekDayFromDate:date];
    self.date = date;
    return self;
}

+(NSString *)sessionFromMonth:(int)month{
    switch (month) {
        case 3:
        case 4:
        case 5:
            return @"春季";
        case 6:
        case 7:
        case 8:
            return @"夏季";
        case 9:
        case 10:
        case 11:
            return @"秋季";
        case 12:
        case 1:
        case 2:
            return @"冬季";
        default:
            break;
    }
    return @"";
}


+(int)weekDayFromDate:(NSDate *)date
{
//    NSCalendar *gregorian = [[NSCalendar alloc]
//                             initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:date];
//    int weekday = (int)[weekdayComponents weekday];
//
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    NSInteger weekday = [comps weekday];
    return (int)weekday;
}

+(NSInteger)stringToTime:(NSString *)timeStr

{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"yyyy-M-dd HH:mm +0800"];// ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSDate* date = [formatter dateFromString:timeStr];//------------将字符串按formatter转成nsdate
    return (long)[date timeIntervalSince1970]*1000;
}


-(BOOL)isEqualToDateUtils:(DateUtils *)DU
{
    if ((self.year == DU.year)&&(self.month == DU.month)&&(self.day == DU.day)) {
        return YES;
    }else
    {
        return NO;
    }
}

+(int)daysOfMonthWithDate:(NSDate *)date
{
    DateUtils * du = [[DateUtils alloc]initWithDate:date];
    
    if (du.month == 1 || du.month == 3 || du.month == 5|| du.month == 7|| du.month == 8|| du.month == 10|| du.month == 12) {
        return 31;
    }else if(du.month == 2){
        if (du.year % 400 == 0) {
            return 29;
        }else if(du.year % 4 ==0)
        {
            return 29;
        }else
        {
            return 28;
        }
    }else
    {
        return 30;
    }
    
}
+(NSString *)weekDayStringWithWeek:(int)week
{
    switch (week) {
        case 1:
            return @"星期日";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
            
        default:
            return nil;
            break;
    }
}

+(NSString *)weekDayStringByWeek:(int)week
{
    switch (week) {
        case 0:
            return @"日";
            break;
        case 1:
            return @"一";
            break;
        case 2:
            return @"二";
            break;
        case 3:
            return @"三";
            break;
        case 4:
            return @"四";
            break;
        case 5:
            return @"五";
            break;
        case 6:
            return @"六";
            break;
            
        default:
            return nil;
            break;
    }
}

+(NSString *)weekDayByWeek:(int)week
{
    switch (week) {
        case 1:
            return @"日";
            break;
        case 2:
            return @"一";
            break;
        case 3:
            return @"二";
            break;
        case 4:
            return @"三";
            break;
        case 5:
            return @"四";
            break;
        case 6:
            return @"五";
            break;
        case 7:
            return @"六";
            break;
            
        default:
            return nil;
            break;
    }
}

+ (NSInteger)numberOfDaysFromTodayByTime:(NSString *)time timeStringFormat:(NSString *)format
{
    // format可以形如： @"yyyy-MM-dd"
    
    NSDate *today = [NSDate date];
    
    NSTimeZone *localTimeZone = [NSTimeZone systemTimeZone];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:localTimeZone];
    [formatter setDateFormat:NSLocalizedString(format,nil)];
    
    // 时分秒转为00:00:00
    NSDate *today2 = [formatter dateFromString:[formatter stringFromDate:today]];
    
    NSDate *newDate = [formatter dateFromString:time];
    // 时分秒转为00:00:00
    NSDate *newDate2 = [formatter dateFromString:[formatter stringFromDate:newDate]];
    
    double dToday = [DateUtils longlongintFromDate:today2];
    double dNewDate = [DateUtils longlongintFromDate:newDate2];
    
    NSInteger nSecs = (NSInteger)(dNewDate - dToday);
    NSInteger oneDaySecs = 24*3600;
    return nSecs / oneDaySecs;
}

+ (NSString *)getADayYouWantFromDate:(NSDate *)aDate withNumber:(NSString *)number {
    int a = 0;
    if ([number hasPrefix:@"0"]) {
        [number substringFromIndex:1];
        a = -number.intValue;
    }
    else {
        a = number.intValue;
    }
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *componets = [gregorian components:NSWeekCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:aDate];
    NSDateFormatter *dateDay = [[NSDateFormatter alloc] init];
    [dateDay setDateFormat:@"yyyy/M/d"];
    [componets setDay:([componets day] + a)];
    NSDate *mydate = [gregorian dateFromComponents:componets];
    return [dateDay stringFromDate:mydate];
}

+ (NSString *)getADayYearAndMonthFromDate:(NSDate *)aDate withNumber:(NSString *)number {
    int a = 0;
    if ([number hasPrefix:@"0"]) {
        [number substringFromIndex:1];
        a = -number.intValue;
    }
    else {
        a = number.intValue;
    }
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *componets = [gregorian components:NSWeekCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:aDate];
    NSDateFormatter *dateDay = [[NSDateFormatter alloc] init];
    [dateDay setDateFormat:@"yyyy-M-d"];
    [componets setDay:([componets day] + a)];
    NSDate *mydate = [gregorian dateFromComponents:componets];
    return [dateDay stringFromDate:mydate];
}


+(NSString *)stringFromDate:(NSDate *)date{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *minuteComponents = [gregorian components:NSMinuteCalendarUnit fromDate:date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    if (minuteComponents.minute == 0) {
        [dateFormatter setDateFormat:@"yyyy年M月d日 H点 EEE"];
    }else if(minuteComponents.minute == 30){
        [dateFormatter setDateFormat:@"yyyy年M月d日 H点半 EEE"];
    }else{
        [dateFormatter setDateFormat:@"yyyy年M月d日 H点 EEE"];
    }
    
    return [dateFormatter stringFromDate:date];
}


+(NSString *)stringFromLongLongInt:(long long int)date{
    NSDate *temp = [[NSDate alloc]initWithTimeIntervalSince1970:date/1000.0];
    return [DateUtils stringFromDateAndFormat:temp dateFormat:@"yyyy年M月d日"];
}

+(NSString *)stringFromLongLongIntDate:(long long int)date{
    NSDate *temp = [[NSDate alloc]initWithTimeIntervalSince1970:date/1000.0];
    return [DateUtils stringFromDateAndFormat:temp dateFormat:@"yyyy-M-d"];
}

+(NSString *)dateStringFromLongLongInt:(long long int)date{
    NSDate *temp = [[NSDate alloc]initWithTimeIntervalSince1970:date/1000.0];
    return [DateUtils stringFromDateAndFormat:temp dateFormat:@"yyyy年M月d日 HH:mm"];
}

+(NSString *)dateWithStringFromLongLongInt:(long long int)date{
    NSDate *temp = [[NSDate alloc]initWithTimeIntervalSince1970:date/1000.0];
    return [DateUtils stringFromDateAndFormat:temp dateFormat:@"yyyy-M-d HH:mm"];
}

+(NSString *)dateStringWithFromLongLongInt:(long long int)date{
    NSDate *temp = [[NSDate alloc]initWithTimeIntervalSince1970:date/1000.0];
    return [DateUtils stringFromDateAndFormat:temp dateFormat:@"yyyy/M/d HH:mm"];
}

+(NSString *)stringFromNumber:(NSNumber *)date{
    NSDate *temp = [[NSDate alloc]initWithTimeIntervalSince1970:date.longLongValue/1000.0];
    return [DateUtils stringFromDateAndFormat:temp dateFormat:@"yyyy年M月d日"];
}

+(NSString *)stringFromDateAndFormat:(NSDate *)date dateFormat:(NSString *)dateFormat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = dateFormat;
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    return [dateFormatter stringFromDate:date];
}

+(NSString *)stringFromLongLongIntAndFormat:(long long int)date dateFormat:(NSString *)dateFormat{
    NSDate *temp = [[NSDate alloc]initWithTimeIntervalSince1970:date/1000.0];
    return [DateUtils stringFromDateAndFormat:temp dateFormat:dateFormat];
}

+(NSString *)stringFromNumberAndFormat:(NSNumber *)date dateFormat:(NSString *)dateFormat{
    NSDate *temp = [[NSDate alloc]initWithTimeIntervalSince1970:date.longLongValue/1000.0];
    return [DateUtils stringFromDateAndFormat:temp dateFormat:dateFormat];
}


+(NSDate *)dateFromLongLongInt:(long long int)date{
    return [[NSDate alloc]initWithTimeIntervalSince1970:date/1000.0];
}

+(long long int)longlongintFromDate:(NSDate *)date{
    return [date timeIntervalSince1970] * 1000;
}


+(int) compare:(NSDate *)date1 date2:(NSDate *)date2{
    if ([date1 isEqualToDate:date2]) {
        return 0;  // 两日期相等
    }else {
        NSDate *result = [date1 earlierDate:date2];
        if ([result isEqualToDate:date1]) {
            return 1;  // 第一个日期比第二个日期早
        }else{
            return 2;  // 第一个日期比第二个日期晚
        }
    }
}

+(NSString *)getDateByDate:(NSDate *)date{
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm +0800";
//    selectDateFormatter.locale = [NSLocale systemLocale];
    [selectDateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSString *dateAndTime = [selectDateFormatter stringFromDate:date]; // 把date类型转为设置好格式的string类型
//    NSLog(@">>>>>>>>>dateAndTime>>>>>>>%@",dateAndTime);
    return dateAndTime;
}

+(NSString *)getDateBySingleDate:(NSDate *)date{
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"yyyy-M-dd HH:mm";
    //    selectDateFormatter.locale = [NSLocale systemLocale];
    [selectDateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSString *dateAndTime = [selectDateFormatter stringFromDate:date]; // 把date类型转为设置好格式的string类型
    //    NSLog(@">>>>>>>>>dateAndTime>>>>>>>%@",dateAndTime);
    return dateAndTime;
}

+(NSString *)getDateByPickerDate:(NSDate *)date{
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"yyyy/MM/dd HH:mm";
    //    selectDateFormatter.locale = [NSLocale systemLocale];
    [selectDateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSString *dateAndTime = [selectDateFormatter stringFromDate:date]; // 把date类型转为设置好格式的string类型
//    NSLog(@">>>>>>>>>dateAndTime>>>>>>>%@",dateAndTime);
    return dateAndTime;
}

+(NSString *)getDateByFormatDate:(NSDate *)date dateFormat:(NSString *)dateFormat{
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = dateFormat;
    //    selectDateFormatter.locale = [NSLocale systemLocale];
    [selectDateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSString *dateAndTime = [selectDateFormatter stringFromDate:date]; // 把date类型转为设置好格式的string类型
    //    NSLog(@">>>>>>>>>dateAndTime>>>>>>>%@",dateAndTime);
    return dateAndTime;
}

+(NSDate *)getDateByString:(NSString *)dateStr {
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm +0800";
    selectDateFormatter.locale = [NSLocale currentLocale];
    [selectDateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [selectDateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSDate *date =[selectDateFormatter dateFromString:dateStr]; // 把date类型转为设置好格式的string类型
    NSLog(@">>>>>>>>>date>>>>>>>%@",date);
    return date;
}

+(NSDate *)getNewDateByString:(NSString *)dateStr {
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    [selectDateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSDate *date =[selectDateFormatter dateFromString:dateStr]; // 把date类型转为设置好格式的string类型
    NSLog(@">>>>>>>>>dnewate>>>>>>>%@",date);
    return date;
}

+(NSString *)getDateStringByDateString:(NSString *)dateStr{
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"yyyy年MM月dd日 HH:mm";
    [selectDateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
     NSDate *date =[selectDateFormatter dateFromString:dateStr]; // 把date类型转为设置好格式的string类型
    NSString *dateAndTime = [selectDateFormatter stringFromDate:date]; // 把date类型转为设置好格式的string类型
//    NSLog(@">>>>>>>>>dateAndTime>>>>>>>%@",dateAndTime);
    return dateAndTime;
}


+(NSString *)getFutureDateByDate:(NSDate *)date{
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"MM月dd日";
    NSString *dateAndTime = [selectDateFormatter stringFromDate:date]; // 把date类型转为设置好格式的string类型
//    NSLog(@">>>>>>>>>dateAndTime>>>>>>>%@",dateAndTime);
    return dateAndTime;
}

+(NSString *)getDateStringByDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    return [dateFormatter stringFromDate:date];
}

+ (NSTimeInterval)getUTCFormateDate:(NSString *)newsDate

{
    //    newsDate = @"2013-08-09 17:01";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSLog(@"newsDate = %@",newsDate);
    NSDate *newsDateFormatted = [dateFormatter dateFromString:newsDate];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    NSDate* current_date = [NSDate date];
    NSLog(@"current_date = %@",current_date);
    NSTimeInterval time=[current_date timeIntervalSinceDate:newsDateFormatted];//间隔的秒数
    
    return time;
    
//    int month=((int)time)/(3600*24*30);
//    int days=((int)time)/(3600*24);
//    int hours=((int)time)%(3600*24)/3600;
//    int minute=((int)time)%(3600*24)/60;
//    NSLog(@"time=%f",(double)time);
//    if(month!=0){
//        dateContent = [NSString stringWithFormat:@"%d%@",month,@"个月"];
//    }else if(days!=0){
//        dateContent = [NSString stringWithFormat:@"%d%@",days,@"天前"];
//    }else if(hours!=0){
//        dateContent = [NSString stringWithFormat:@"%d%@",hours,@"小时前"];
//    }else{
//        dateContent = [NSString stringWithFormat:@"%d%@",minute,@"分钟前"];
//    }
//    return dateContent;
}


+ (BOOL)intervalSinceNow: (NSString *) theDate
{
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate date];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: dat];
    NSDate *localDate = [dat  dateByAddingTimeInterval: interval];
    NSTimeInterval now=[localDate timeIntervalSince1970]*1;
    
    NSTimeInterval cha=now-late;
    
    if (cha/3600>=1)
    {
        return YES;
    }
    return NO;
}

+ (int)getCurrentDateHour{
    int hour = 0;
    NSDate *date = [NSDate date];
    NSString *nowStr = [DateUtils getDateByDate:date];
    //    NSLog(@"date222222 = %@", nowStr);
    NSArray *array = [nowStr componentsSeparatedByString:@" "];
    NSString *timeStr = array[1];
    NSArray *timeStrArray = [timeStr componentsSeparatedByString:@":"];
    hour = [timeStrArray[0] intValue];
    return hour;
}


-(NSString *)description
{
    return [NSString stringWithFormat:@"year = %d,month = %d,day = %d,week = %d",self.year,self.month,self.day,self.week];
}
@end
