//
//  UMengSDKProcessor.h
//  styler
//
//  Created by System Administrator on 14-8-26.
//  Copyright (c) 2014年 mlzj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMengSDKProcessor : NSObject

@property int forcedToUpdate;

-(void) checkUpdate;

+(void) initUMengSDK;

+ (UMengSDKProcessor *) sharedInstance;
@end
