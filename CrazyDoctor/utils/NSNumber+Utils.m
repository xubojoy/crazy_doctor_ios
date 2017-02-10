//
//  NSNumber+Utils.m
//  styler
//
//  Created by System Administrator on 13-7-5.
//  Copyright (c) 2013年 mlzj. All rights reserved.
//

#import "NSNumber+Utils.h"

@implementation NSNumber (Utils)

-(NSString *) getChineseCharacter{
    NSString *result = nil;
    switch ([self intValue]) {
    case 1:
        result = @"一";
        break;
    case 2:
        result = @"二";
        break;
    case 3:
        result = @"三";
        break;
    case 4:
        result = @"四";
        break;
    case 5:
        result = @"五";
        break;
    case 6:
        result = @"六";
        break;
    case 7:
        result = @"七";
        break;
    case 8:
        result = @"八";
        break;
    case 9:
        result = @"九";
        break;
    default:
        break;
    }
    
    return result;
}
    
@end
