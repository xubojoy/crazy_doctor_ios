//
//  DeviceUtils.m
//  styler
//
//  Created by System Administrator on 13-6-10.
//  Copyright (c) 2013年 mlzj. All rights reserved.
//

#import "DeviceUtils.h"

@implementation DeviceUtils

+(NSString *)deviceUserName{
    NSString *name = [[UIDevice currentDevice] name];
    name = [name stringByReplacingOccurrencesOfString:@"的 iPhone" withString:@""];
    name = [name stringByReplacingOccurrencesOfString:@"'s iPhone" withString:@""];
    name = [name stringByReplacingOccurrencesOfString:@"的 iPod touch" withString:@""];
    name = [name stringByReplacingOccurrencesOfString:@"'s iPod touch" withString:@""];
    name = [name stringByReplacingOccurrencesOfString:@"的 iPad" withString:@""];
    name = [name stringByReplacingOccurrencesOfString:@"'s iPad" withString:@""];
    name = [name stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    name = [name stringByReplacingOccurrencesOfString:@"“" withString:@""];
    name = [name stringByReplacingOccurrencesOfString:@"”" withString:@""];
    return name;
}


+(BOOL) isIpad{
    return  ([[UIDevice currentDevice].model rangeOfString:@"iPad"].location != NSNotFound);
}

@end
