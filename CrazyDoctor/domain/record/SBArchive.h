//
//  SBArchive.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/12.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyDoctor.h"
@protocol SBArchive
@end
@interface SBArchive : JSONModel
@property (nonatomic ,strong) NSString *returnCode;
@property (nonatomic ,strong) NSString *returnMessage;
@end
