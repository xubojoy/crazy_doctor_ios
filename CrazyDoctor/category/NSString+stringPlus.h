//
//  NSString+stringPlsu.h
//  styler
//
//  Created by aypc on 13-10-8.
//  Copyright (c) 2013年 mlzj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (stringPlus)
-(BOOL)isContainString:(NSString *)str;
-(NSString *) urlEncode;

/**
 *   将url上的查询参数转换到字典对象中
 */
-(NSMutableDictionary *) urlParamsChange2Dict;

@end
