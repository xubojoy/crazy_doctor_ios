//
//  FunctionUtils.m
//  styler
//
//  Created by 冯聪智 on 14-9-19.
//  Copyright (c) 2014年 mlzj. All rights reserved.
//

#import "FunctionUtils.h"

@implementation FunctionUtils


+(void)setTimeout:(void (^)())block delayTime:(float)delayTime{
    [self performSelector:@selector(runBlock:) withObject:block afterDelay:delayTime];
}


+(void) runBlock:(void (^)())block{
    block();
}

+ (NSString *)getChineseNum:(int)num{
    switch (num) {
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
            
        default:
            break;
    }
    return @"";
}

+ (NSString *)getChineseNumByBool:(int)num{
    if (num == 0) {
        return @"双";
    }
    return @"单";
}

+ (CGSize)getCGSizeByString:(NSString *)string font:(CGFloat)font{
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    CGSize retSize = [string boundingRectWithSize:CGSizeMake(screen_width, 0)
                                         options:
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                      attributes:attribute
                                         context:nil].size;
    return retSize;

}


+ (NSMutableArray *)getRandomDataArray:(NSMutableArray *)commonArray chooseNum:(int)chooseNum{
    NSMutableArray *choseArray = [NSMutableArray new];
    NSMutableArray *arr = [NSMutableArray new];
    NSMutableArray *choose = [NSMutableArray new];
    if (commonArray.count > 0) {
        for (int i = 0; i < commonArray.count; i++) {
            [arr addObject:@(i)];
        }
    }
    if (chooseNum > 0) {
        for (int i = 0; i < chooseNum; i++) {
            [choose addObject:@(i)];
        }
    }
    int total = (int)commonArray.count;
    int i = 0;
    int randid = 0;
    for (i = 0;i < total;i++)
    {
        int d = [arr[i] intValue];
        d = (int)i+1;
    }
    
    for (i = 0; i < chooseNum;i++)
    {
        randid = arc4random()%(total-i);
        choose[i] = arr[randid];
        arr[randid] = arr[total-i-1];
    }
    
    for(i=0;i<chooseNum;i++)
    {
        NSLog(@">>>>>>>>>>随机数>>>>>>%d",[choose[i] intValue]);
        int chooseIndex = [choose[i] intValue];
        NSString *str = commonArray[chooseIndex];
        [choseArray addObject:str];
    }
    return choseArray;
}

+ (CGAffineTransform)getAngleByTime{
    NSDate *date = [NSDate date];
    NSString *nowStr = [DateUtils getDateByDate:date];
//    NSLog(@"date222222 = %@", nowStr);
    NSArray *array = [nowStr componentsSeparatedByString:@" "];
    NSString *timeStr = array[1];
    NSArray *timeStrArray = [timeStr componentsSeparatedByString:@":"];
    NSInteger hour = [timeStrArray[0] integerValue];
//    NSLog(@"hour = %ld", (long)hour);
    if (hour >= 1 && hour < 3){
        return CGAffineTransformMakeRotation((M_PI)/6);
    }else if (hour >= 3 && hour < 5){
        return CGAffineTransformMakeRotation((M_PI)/3);
    }else if (hour >= 5 && hour < 7){
        return CGAffineTransformMakeRotation(M_PI_2);
    }else if (hour >= 7 && hour < 9){
        return CGAffineTransformMakeRotation((2*M_PI)/3);
    }else if (hour >= 9 && hour < 11){
        return CGAffineTransformMakeRotation((M_PI*5) / 6);
    }else if (hour >= 11 && hour < 13){
        return CGAffineTransformMakeRotation(M_PI);
    }else if (hour >= 13 && hour < 15){
        return CGAffineTransformMakeRotation((M_PI*7)/6);
    }else if (hour >= 15 && hour < 17){
        return CGAffineTransformMakeRotation((M_PI*4)/3);
    }else if (hour >= 17 && hour < 19){
        return CGAffineTransformMakeRotation((M_PI*3)/2);
    }else if (hour >= 19 && hour < 21){
        return CGAffineTransformMakeRotation((M_PI*5)/3);
    }else if (hour >= 21 && hour < 23){
        return CGAffineTransformMakeRotation((M_PI*11)/6);
    }else{
        return CGAffineTransformMakeRotation(M_PI*2);
    }
}

+ (int)getRemarkNum:(int)hour{
    if((hour >= 23) || (hour >= 0 && hour < 1)){
        return 23;
    }else if (hour >= 1 && hour < 3){
        return 1;
    }else if (hour >= 3 && hour < 5){
        return 3;
    }else if (hour >= 5 && hour < 7){
        return 5;
    }else if (hour >= 7 && hour < 9){
        return 7;
    }else if (hour >= 9 && hour < 11){
        return 9;
    }else if (hour >= 11 && hour < 13){
        return 11;
    }else if (hour >= 13 && hour < 15){
        return 13;
    }else if (hour >= 15 && hour < 17){
        return 15;
    }else if (hour >= 17 && hour < 19){
        return 17;
    }else if (hour >= 19 && hour < 21){
        return 19;
    }else{
        return 21;
    }
}

+ (BOOL)isDefaultPushTimes:(NSString *)pushtimes{
    NSArray *pushTimesTmpArray = [pushtimes componentsSeparatedByString:@","];
    if ([pushTimesTmpArray containsObject:@"7"]&& [pushTimesTmpArray containsObject:@"9"] && [pushTimesTmpArray containsObject:@"11"] && [pushTimesTmpArray containsObject:@"13"] && [pushTimesTmpArray containsObject:@"15"] && [pushTimesTmpArray containsObject:@"17"] && [pushTimesTmpArray containsObject:@"19"] && ![pushTimesTmpArray containsObject:@"21"] && ![pushTimesTmpArray containsObject:@"23"] && ![pushTimesTmpArray containsObject:@"1"] && ![pushTimesTmpArray containsObject:@"3"] && ![pushTimesTmpArray containsObject:@"5"]) {
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)isCustomPushTimes:(NSString *)pushtimes{
    NSString *pushTimes = [AppStatus sharedInstance].user.pushTimes;
    NSArray *pushTimesTmpArray = [pushTimes componentsSeparatedByString:@","];
    if ([pushTimesTmpArray containsObject:@"5"] || [pushTimesTmpArray containsObject:@"21"] || [pushTimesTmpArray containsObject:@"23"] || [pushTimesTmpArray containsObject:@"1"] || [pushTimesTmpArray containsObject:@"3"]|| ![pushTimesTmpArray containsObject:@"7"] || ![pushTimesTmpArray containsObject:@"9"] || ![pushTimesTmpArray containsObject:@"11"] || ![pushTimesTmpArray containsObject:@"13"] || ![pushTimesTmpArray containsObject:@"15"] || ![pushTimesTmpArray containsObject:@"17"] || ![pushTimesTmpArray containsObject:@"19"]) {
        return YES;
    }else{
        return NO;
    }
}

+ (NSString *)getAcupointByTimeStr:(NSString *)timeStr{
    NSArray *acupointArray = [AppStatus sharedInstance].meridianDict[timeStr];
    if (acupointArray.count > 0) {
        int i = arc4random()% ((int)acupointArray.count);

        NSDictionary *dict = acupointArray[i];
    
        return dict[@"name"];
 
    }else{
        return @"太白穴";
    }
}

+ (void)startDefaultNotifi{
    [FunctionUtils scheduleLocalNotification:@"07:01" notificationId:@"notificationId7" content:[FunctionUtils getAcupointByTimeStr:@"7"]];
    [FunctionUtils scheduleLocalNotification:@"09:01" notificationId:@"notificationId9" content:[FunctionUtils getAcupointByTimeStr:@"9"]];
    
    [FunctionUtils scheduleLocalNotification:@"11:01" notificationId:@"notificationId11" content:[FunctionUtils getAcupointByTimeStr:@"11"]];
    [FunctionUtils scheduleLocalNotification:@"13:01" notificationId:@"notificationId13" content:[FunctionUtils getAcupointByTimeStr:@"13"]];
    [FunctionUtils scheduleLocalNotification:@"15:01" notificationId:@"notificationId15" content:[FunctionUtils getAcupointByTimeStr:@"15"]];
    [FunctionUtils scheduleLocalNotification:@"17:01" notificationId:@"notificationId17" content:[FunctionUtils getAcupointByTimeStr:@"17"]];
    [FunctionUtils scheduleLocalNotification:@"19:01" notificationId:@"notificationId19" content:[FunctionUtils getAcupointByTimeStr:@"19"]];
}

+ (void)closeDefaultNotifi{
    [FunctionUtils removeLocalNotification:@"notificationId7"];
    [FunctionUtils removeLocalNotification:@"notificationId9"];
    [FunctionUtils removeLocalNotification:@"notificationId11"];
    [FunctionUtils removeLocalNotification:@"notificationId13"];
    [FunctionUtils removeLocalNotification:@"notificationId15"];
    [FunctionUtils removeLocalNotification:@"notificationId17"];
    [FunctionUtils removeLocalNotification:@"notificationId19"];
}

+ (void)clearAllLocalNotifi{
    [FunctionUtils removeLocalNotification:@"notificationId5"];
    [FunctionUtils removeLocalNotification:@"notificationId7"];
    [FunctionUtils removeLocalNotification:@"notificationId9"];
    [FunctionUtils removeLocalNotification:@"notificationId11"];
    [FunctionUtils removeLocalNotification:@"notificationId13"];
    [FunctionUtils removeLocalNotification:@"notificationId15"];
    [FunctionUtils removeLocalNotification:@"notificationId17"];
    [FunctionUtils removeLocalNotification:@"notificationId19"];
    [FunctionUtils removeLocalNotification:@"notificationId21"];
    [FunctionUtils removeLocalNotification:@"notificationId23"];
}

+ (void)startCustomNotifiByTimes:(NSString *)time{
    NSArray *pushTimesTmpArray = [time componentsSeparatedByString:@","];
    if (pushTimesTmpArray.count > 0) {
        for (NSString *timeStr in pushTimesTmpArray) {
            [FunctionUtils scheduleLocalNotification:[NSString stringWithFormat:@"%@:01",timeStr] notificationId:[NSString stringWithFormat:@"notificationId%@",timeStr] content:[FunctionUtils getAcupointByTimeStr:timeStr]];
        }
    }
}


//+ (NSString *)getTimeStrByHour:(int)hour{
//    if((hour >= 23) || (hour >= 0 && hour < 1)){
//        return @"23:01";
//    }else if (hour >= 1 && hour < 3){
//        return @"01:01";
//    }else if (hour >= 3 && hour < 5){
//        return @"03:01";
//    }else if (hour >= 5 && hour < 7){
//        return @"05:01";
//    }else if (hour >= 7 && hour < 9){
//        return @"07:01";
//    }else if (hour >= 9 && hour < 11){
//        return @"09:01";
//    }else if (hour >= 11 && hour < 13){
//        return @"11:01";
//    }else if (hour >= 13 && hour < 15){
//        return @"13:01";
//    }else if (hour >= 15 && hour < 17){
//        return @"15:01";
//    }else if (hour >= 17 && hour < 19){
//        return @"17:01";
//    }else if (hour >= 19 && hour < 21){
//        return @"19:01";
//    }else{
//        return @"21:01";
//    }
//
//}

+ (void)scheduleLocalNotification:(NSString *)timeStr notificationId:(NSString *)notificationId content:(NSString *)content{
    // 初始化本地通知
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    NSDate *date = [NSDate date];
//    NSLog(@"date111111 = %@", date);
    NSString *str = [DateUtils getDateByDate:date];
//    NSLog(@"date222222 = %@", str);
    NSArray *array = [str componentsSeparatedByString:@" "];
    NSString *tempStr = [NSString stringWithFormat:@"%@ %@",array[0],timeStr];
//    NSLog(@"tempStr传递的 = %@", tempStr);
    NSDate *curr = [DateUtils getDateByString:tempStr];
    NSLog(@"date444444 = %@", curr);
    //[NSDate dateWithTimeIntervalSinceNow:17*60*60*24]
    // 通知触发时间
    localNotification.fireDate = curr;
    // 触发后，弹出警告框中显示的内容
    localNotification.alertBody = content;
    // 触发时的声音（这里选择的系统默认声音）
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    // 触发频率（repeatInterval是一个枚举值，可以选择每分、每小时、每天、每年等）
    localNotification.repeatInterval = NSCalendarUnitDay;
//     需要在App icon上显示的未读通知数（设置为1时，多个通知未读，系统会自动加1，如果不需要显示未读数，这里可以设置0）
    localNotification.applicationIconBadgeNumber = 1;
    // 设置通知的id，可用于通知移除，也可以传递其他值，当通知触发时可以获取
    localNotification.userInfo = @{@"id" : notificationId};
    
//     注册本地通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

+ (void)removeLocalNotification:(NSString *)notificationId {
    
    // 取出全部本地通知
    NSArray *notifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    // 设置要移除的通知id
    
    // 遍历进行移除
    for (UILocalNotification *localNotification in notifications) {
        
        // 将每个通知的id取出来进行对比
        if ([[localNotification.userInfo objectForKey:@"id"] isEqualToString:notificationId]) {
            
            // 移除某一个通知
            [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
//            [BPush deleteLocalNotification:localNotification];
            
        }
    }
}



@end
