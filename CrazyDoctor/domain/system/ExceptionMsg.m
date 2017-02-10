//
//  Exception.m
//  styler
//
//  Created by System Administrator on 13-5-16.
//  Copyright (c) 2013年 mlzj. All rights reserved.
//

#import "ExceptionMsg.h"

@implementation ExceptionMsg

-(void) readFromJSONDictionary:(NSDictionary *)jsonDict{
    [self setStatus:[[jsonDict objectForKey:@"status"] intValue]];
    [self setCode:[[jsonDict objectForKey:@"code"] intValue]];
    [self setMessage:[jsonDict objectForKey:@"message"]];
}

@end

