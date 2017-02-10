//
//  URLDispatcher.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/8.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLDispatcher : NSObject
+(BOOL) dispatch:(NSURL *)url nav:(UINavigationController *)nav;
+(BOOL) dispatchWithContentSort:(int)contentSortId
                contentSortName:(NSString *)contentSortName
                    extendParam:(NSString *)extendParam
                contentModeType:(int)contentModeType
                            nav:(UINavigationController *)nav;
@end
