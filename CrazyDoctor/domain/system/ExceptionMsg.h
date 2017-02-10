//
//  Exception.h
//  styler
//
//  Created by System Administrator on 13-5-16.
//  Copyright (c) 2013年 mlzj. All rights reserved.
//

#import "JSONSerializable.h"
#import <Foundation/Foundation.h>

@interface ExceptionMsg : NSObject<JSONSerializable>

@property int status;
@property int code;
@property (nonatomic, copy) NSString *message;



@end
