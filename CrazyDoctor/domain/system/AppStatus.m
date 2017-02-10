//
//  AppStatus.m
//  styler
//
//  Created by System Administrator on 13-5-13.
//  Copyright (c) 2013年 mlzj. All rights reserved.
//

#import "AppStatus.h"

@implementation AppStatus

-(NSString *) ua{
    NSMutableString *ua = [[NSMutableString alloc] init];
    [ua appendFormat:@"ios,%@", [[UIDevice currentDevice] systemVersion]];
    [ua appendFormat:@";%@,%d*%d",[[UIDevice currentDevice] model],  (int)[[UIScreen mainScreen] bounds].size.width,  (int)[[UIScreen mainScreen]bounds].size.height];
    
    NSDictionary *dicInfo = [[NSBundle mainBundle] infoDictionary];
    [ua appendFormat:@";%@,%@", @"cd_ios",  [dicInfo objectForKey:@"CFBundleShortVersionString"]];
    [ua appendFormat:@";%@", [OpenUDID value]];
    [ua appendFormat:@";%@", self.deviceToken==nil?@"unknow":self.deviceToken];
//    [ua appendFormat:@";%f,%f", self.lastLng, self.lastLat];
    NSLog(@">>>>>>>>>>>>>>>>>%@",ua);
    return ua;
}

//是否登录
-(BOOL) logined{
    if(self.user != nil && self.user.accessToken != nil && (NSNull *)self.user.accessToken != [NSNull null])
        return YES;
    return NO;
}

-(BOOL)isConnetInternet{
    if (self.networkStatus == NotReachable) {
        return NO;
    }
    return YES;
}

-(float)iosVersion{
   return [[[UIDevice currentDevice] systemVersion] floatValue];
}

-(NSString *)appVersion{
    NSDictionary *dicInfo = [[NSBundle mainBundle] infoDictionary];
    return [dicInfo objectForKey:@"CFBundleShortVersionString"];
}

-(float) getLastLat{
    if (_lastLat == 0) {
        return 39.921787;
    }
    return _lastLat;
}
-(float) getLastLng{
    if (_lastLng == 0) {
        return 116.487922;
    }
    return _lastLng;
}

- (void)addRecentCity:(NSString *)recentCity{
    [self.recentCityDicy setObject:recentCity forKey:recentCity];
}

-(void) removeRecentCity:(NSString *)city{
    NSMutableDictionary *cityDict = [NSMutableDictionary new];
    for (NSString *str in self.recentCityDicy.allKeys) {
        if(![str isEqualToString:city]){
            NSLog(@">>>>>保存的>>>>>%@",str);
            [cityDict setObject:str forKey:str];
        }
    }
    self.recentCityDicy = cityDict;
}

- (BOOL)hasAddRecentCity:(NSString *)recentCity{
    if (self.recentCityDicy != nil) {
        for (NSString *keyStr in self.recentCityDicy.allKeys) {
            if ([recentCity isEqualToString:keyStr]) {
                return YES;
            }
        }
    }
    return NO;
}

- (void)addRecentCityArray:(NSString *)recentCity{
    if (self.recentCityArray == nil) {
        self.recentCityArray = [NSMutableArray new];
    }
    NSMutableArray *cityArray = [[NSMutableArray alloc] initWithArray:self.recentCityArray];
    [cityArray addObject:recentCity];
    self.recentCityArray = cityArray;
}

-(void) removeRecentCityArray:(NSString *)city{
    NSMutableArray *cityArray = [NSMutableArray new];
    for (NSString *str in self.recentCityArray) {
        if(![str isEqualToString:city]){
            [cityArray addObject:str];
        }
    }
    self.recentCityArray = cityArray;
}

- (BOOL)hasAddRecentCityArray:(NSString *)recentCity{
    if (self.recentCityArray != nil) {
        for (NSString *keyStr in self.recentCityArray) {
            if ([recentCity isEqualToString:keyStr]) {
                return YES;
            }
        }
    }
    return NO;
}


-(void) addHasReadArticle:(int)recommendId{
    if(self.hasReadArticleIds == nil){
        self.hasReadArticleIds = [[NSMutableSet alloc] init];
    }
    NSMutableSet *articleIds = [[NSMutableSet alloc] initWithSet:self.hasReadArticleIds];
    [articleIds addObject:@(recommendId)];
    self.hasReadArticleIds = articleIds;
}
-(BOOL) hasReadAddArticle:(int)recommendId{
    if(self.hasReadArticleIds != nil){
        for (NSNumber *favId in self.hasReadArticleIds) {
            if([favId intValue] == recommendId){
                return YES;
            }
        }
    }
    return NO;
}


-(void) removeCrazyDoctorUA{
    NSDictionary *registeredDefaults = [[NSUserDefaults standardUserDefaults] volatileDomainForName:NSRegistrationDomain];
    if ([registeredDefaults objectForKey:@"UserAgent"] != nil) {
        NSLog(@">>>>>>> before remove styler ua:%@", [registeredDefaults objectForKey:@"UserAgent"]);
        NSMutableDictionary *mutableCopy = [NSMutableDictionary dictionaryWithDictionary:registeredDefaults];
        [mutableCopy removeObjectForKey:@"UserAgent"];
        [[NSUserDefaults standardUserDefaults] setVolatileDomain:[mutableCopy copy] forName:NSRegistrationDomain];
    }
}

-(void) setCrazyDoctorUA{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:[self ua], @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
}

-(void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeDouble:self.lastLat forKey:@"lastLat"];
    [aCoder encodeDouble:self.lastLng forKey:@"lastLng"];
    [aCoder encodeObject:self.cityName forKey:@"City"];
    [aCoder encodeObject:self.currentLocation forKey:@"currentLocation"];
    [aCoder encodeObject:self.deviceToken forKey:@"deviceToken"];
    [aCoder encodeObject:self.user forKey:@"user"];
    [aCoder encodeObject:self.sharkey forKey:@"sharkey"];
//    [aCoder encodeObject:self.saveSharkey forKey:@"saveSharkey"];
    [aCoder encodeObject:self.targetNum forKey:@"targetNum"];
    [aCoder encodeObject:self.localMeridian forKey:@"localMeridian"];
    [aCoder encodeObject:self.saveDate forKey:@"saveDate"];
    [aCoder encodeInt:self.didIndexPathRow forKey:@"didIndexPathRow"];
    [aCoder encodeObject:self.recentCityArray forKey:@"recentCityArray"];
    [aCoder encodeObject:self.recentCityDicy forKey:@"recentCityDicy"];
    [aCoder encodeObject:self.meridianDict forKey:@"meridianDict"];
    [aCoder encodeBool:self.noRemind forKey:@"noRemind"];
    [aCoder encodeBool:self.isComplete forKey:@"isComplete"];
    [aCoder encodeBool:self.defaultSwitch forKey:@"defaultSwitch"];
    [aCoder encodeBool:self.customSwitch forKey:@"customSwitch"];
    [aCoder encodeObject:self.remarkDataStr forKey:@"remarkDataStr"];
    [aCoder encodeObject:self.acupointName forKey:@"acupointName"];
    [aCoder encodeObject:self.recommendAcupointTime forKey:@"recommendAcupointTime"];
    if(self.hasReadArticleIds != nil){
        [aCoder encodeObject:self.hasReadArticleIds forKey:@"hasReadArticleIds"];
    }
}

-(id) initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if(self){
        self.lastLat = [aDecoder decodeDoubleForKey:@"lastLat"];
        self.lastLng = [aDecoder decodeDoubleForKey:@"lastLng"];
        self.cityName = [aDecoder decodeObjectForKey:@"City"];
        self.currentLocation = [aDecoder decodeObjectForKey:@"currentLocation"];
        self.deviceToken = [aDecoder decodeObjectForKey:@"deviceToken"];
        self.user = [aDecoder decodeObjectForKey:@"user"];
        self.sharkey = [aDecoder decodeObjectForKey:@"sharkey"];
//        self.saveSharkey = [aDecoder decodeObjectForKey:@"saveSharkey"];
        self.targetNum = [aDecoder decodeObjectForKey:@"targetNum"];
        self.localMeridian = [aDecoder decodeObjectForKey:@"localMeridian"];
        self.saveDate = [aDecoder decodeObjectForKey:@"saveDate"];
        self.didIndexPathRow = [aDecoder decodeIntForKey:@"didIndexPathRow"];
        self.recentCityArray = [aDecoder decodeObjectForKey:@"recentCityArray"];
        self.recentCityDicy = [aDecoder decodeObjectForKey:@"recentCityDicy"];
        self.meridianDict = [aDecoder decodeObjectForKey:@"meridianDict"];
        self.noRemind = [aDecoder decodeBoolForKey:@"noRemind"];
        self.isComplete = [aDecoder decodeBoolForKey:@"isComplete"];
        self.defaultSwitch = [aDecoder decodeBoolForKey:@"defaultSwitch"];
        self.customSwitch = [aDecoder decodeBoolForKey:@"customSwitch"];
        self.remarkDataStr = [aDecoder decodeObjectForKey:@"remarkDataStr"];
        self.acupointName = [aDecoder decodeObjectForKey:@"acupointName"];
        self.recommendAcupointTime = [aDecoder decodeObjectForKey:@"recommendAcupointTime"];
        self.hasReadArticleIds = [aDecoder decodeObjectForKey:@"hasReadArticleIds"];
//        if (self.recentCityDicy == nil) {
//            self.recentCityDicy = [NSMutableDictionary new];
//        }
    }
    return self;
}

+(void) saveAppStatus{
    NSLog(@"AppStatus to be saving:%@", [AppStatus sharedInstance].description);
    [NSKeyedArchiver archiveRootObject:[AppStatus sharedInstance] toFile:[AppStatus savedPath]];
}

+(NSString *) savedPath{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    documentDirectory = [documentDirectory stringByAppendingPathComponent:@"appStatus.archive"];
//    NSLog(@"____________________%@",documentDirectory);
    return documentDirectory;
}

+(AppStatus *)sharedInstance{
    static AppStatus *sharedInstance = nil;
    if(sharedInstance == nil){
        NSString *path = [AppStatus savedPath];
        sharedInstance = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if(sharedInstance == nil){
            sharedInstance = [[AppStatus alloc] init];
        }
        NSDictionary *dicInfo = [[NSBundle mainBundle] infoDictionary];
        sharedInstance.apiUrl = [dicInfo objectForKey:@"apiUrl"];
        sharedInstance.searcherUrl = [dicInfo objectForKey:@"searcherUrl"];
        sharedInstance.cmsUrl = [dicInfo objectForKey:@"cmsUrl"];
        sharedInstance.hostUrl = [dicInfo objectForKey:@"hostUrl"];
        sharedInstance.env = [dicInfo objectForKey:@"env"];
        sharedInstance.umengAppKey = [dicInfo objectForKey:@"umengAppKey"];
        sharedInstance.paymentUrl = [dicInfo objectForKey:@"paymentUrl"];
        sharedInstance.wxpubUrl = [dicInfo objectForKey:@"wxpubUrl"];
        sharedInstance.gameBlockIds = [dicInfo objectForKey:@"gameBlockIds"];
        sharedInstance.umengPushAppKey = [dicInfo objectForKey:@"umengPushAppKey"];
    }
    return sharedInstance;
}

/**
 *  初始化AppStatus 基本数据。
 */
-(void) initBaseData{
    self.recentCityArray = [NSMutableArray new];
    self.recentCityDicy = [NSMutableDictionary new];
    self.hasReadArticleIds = [NSMutableSet new];
    self.meridianDict = [NSMutableDictionary new];
    self.user = nil;
    self.sharkey = nil;
}


-(NSString *) description{
    return [NSString stringWithFormat:@"deviceToken:%@, user:%@, lastLat:%f, lastLng:%f sharkey:%@", self.deviceToken, self.user.description, self.lastLat, self.lastLng,self.sharkey];
}

@end
