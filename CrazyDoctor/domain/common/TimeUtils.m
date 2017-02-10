//
//  TimeUtils.m
//  styler
//
//  Created by System Administrator on 13-6-7.
//  Copyright (c) 2013年 mlzj. All rights reserved.
//

#import "TimeUtils.h"

@implementation TimeUtils

+(NSString *) weekDayString:(NSDate *)date{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *weekdayComponents = [gregorian components:NSCalendarUnitWeekday fromDate:date];
    int weekday = (int)[weekdayComponents weekday];
    NSString *dayStr = @"";
    switch (weekday) {
        case 1:
            dayStr = @"日";
            break;
        case 2:
            dayStr = @"一";
            break;
        case 3:
            dayStr = @"二";
            break;
        case 4:
            dayStr = @"三";
            break;
        case 5:
            dayStr = @"四";
            break;
        case 6:
            dayStr = @"五";
            break;
        case 7:
            dayStr = @"六";
            break;
        default:
            break;
    }
    return [NSString stringWithFormat:@"周%@", dayStr];
}


@end
