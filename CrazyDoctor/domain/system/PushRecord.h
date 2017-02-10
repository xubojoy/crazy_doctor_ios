//
//  PushRecord.h
//  styler
//
//  Created by System Administrator on 13-6-19.
//  Copyright (c) 2013年 mlzj. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PushRecord
@end
@interface PushRecord : JSONModel
@property (nonatomic, copy) NSDictionary *userInfo;
@property (nonatomic, assign) int pId;

@end
