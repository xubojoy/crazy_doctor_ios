//
//  UMengSDKProcessor.m
//  styler
//
//  Created by System Administrator on 14-8-26.
//  Copyright (c) 2014年 mlzj. All rights reserved.
//

#import "UMengSDKProcessor.h"
@implementation UMengSDKProcessor

+(void) initUMengSDK
{
//    AppStatus *as = [AppStatus sharedInstance];
    //友盟初始化
//    [MobClick startWithAppkey:umeng_app_key reportPolicy:BATCH channelId:nil];
    UMConfigInstance.appKey = umeng_app_key;
//    UMConfigInstance.secret = @"secretstringaldfkals";
    UMConfigInstance.ePolicy = BATCH;
    //    UMConfigInstance.eSType = E_UM_GAME;
    [MobClick startWithConfigure:UMConfigInstance];

    [MobClick setLogSendInterval:2];
}

+ (UMengSDKProcessor *) sharedInstance{
    static UMengSDKProcessor *sharedInstance = nil;
    if(sharedInstance == nil){
        sharedInstance = [[UMengSDKProcessor alloc] init];
    }
    
    return sharedInstance;
}

-(void) checkUpdate{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    
    NSString *nowVersion = [infoDict objectForKey:@"CFBundleVersion"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@", @"985114578"]];
    NSString * file =  [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    NSRange substr = [file rangeOfString:@"\"version\":\""];
    NSRange range1 = NSMakeRange(substr.location+substr.length,10);
    NSRange substr2 =[file rangeOfString:@"\"" options:NSBackwardsSearch range:range1];
    NSRange range2 = NSMakeRange(substr.location+substr.length, substr2.location-substr.location-substr.length);
    NSString *newVersion =[file substringWithRange:range2];
    if(![nowVersion isEqualToString:newVersion])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"版本有更新"delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"更新",nil];
        [alert show];
    }
}

-(void)umengEvent:(NSString *)eventId attributes:(NSDictionary *)attributes number:(NSNumber *)number{
    NSString *numberKey = @"__ct__";
    NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:attributes];
    [mutableDictionary setObject:[number stringValue] forKey:numberKey];
    [MobClick event:eventId attributes:mutableDictionary];
}

-(void) displayUpdateNote:(NSDictionary *)dict{
    NSString *update = (NSString*)[dict objectForKey:@"update"];
    NSString *updateLog = (NSString*)[dict objectForKey:@"update_log"];
//    NSLog(@">>>>>>>>>>友盟检查版本更新>>>>>%@>>>>>>>-------%@",dict,update);
    if ([update isEqualToString:@"YES"]) {
        
        if (self.forcedToUpdate == 0) {  // 提示更新
            UIAlertView *alertUpdate = [[UIAlertView alloc] initWithTitle:@"版本更新"
                                                                  message:updateLog
                                                                 delegate:[UMengSDKProcessor sharedInstance]
                                                        cancelButtonTitle:@"暂不更新"
                                                        otherButtonTitles:@"立即更新", nil];
            [alertUpdate show];
        }else{ // 强制更新
            UIAlertView *alertUpdate = [[UIAlertView alloc] initWithTitle:@"版本更新"
                                                                  message:updateLog
                                                                 delegate:[UMengSDKProcessor sharedInstance]
                                                        cancelButtonTitle:nil
                                                        otherButtonTitles:@"立刻更新", nil];
            [alertUpdate show];
        }
    }
}

- (void)willPresentAlertView:(UIAlertView *)alertView{
    for( UIView * view in alertView.subviews )
    {
        if( [view isKindOfClass:[UILabel class]] )
        {
            UILabel* label = (UILabel*) view;
            label.textAlignment = NSTextAlignmentLeft;
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSURL *appUrl = [[NSURL alloc] initWithString:crazy_doctor_app_url];
        [[UIApplication sharedApplication] openURL:appUrl];
    }
}

@end
