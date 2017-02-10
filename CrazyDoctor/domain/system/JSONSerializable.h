//
//  JSONSerializable.h
//  iUser
//
//  Created by System Administrator on 13-4-9.
//  Copyright (c) 2013年 珠元玉睿ray. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSONSerializable <NSObject>

- (void) readFromJSONDictionary:(NSDictionary *)jsonDict;

@end
