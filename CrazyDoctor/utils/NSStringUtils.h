//
//  NSStringUtils.h
//  styler
//
//  Created by wangwanggy820 on 14-9-4.
//  Copyright (c) 2014年 mlzj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSStringUtils : NSObject

+(BOOL) isBlank:(NSString *) str;
+(BOOL) isNotBlank:(NSString *) str;
+(BOOL) isSpecialBlank:(NSString *)str;
+(BOOL) ispecialNotBlank:(NSString *) str;
+ (NSString *)stringFromInt:(int)num;
+ (BOOL) isEmpty:(NSString *) str;
+(BOOL)isContainsEmoji:(NSString *)string;
+ (NSString *)delSpaceAndNewline:(NSString *)string;
@end
