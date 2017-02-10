//
//  Page.h
//  styler
//
//  Created by wangwanggy820 on 14-3-28.
//  Copyright (c) 2014年 mlzj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Page : NSObject

@property int pageNo;//当前页码
@property int pageSize;//每页的请求的数据量
@property int totalCount;//一共的总数
@property(strong, nonatomic) NSArray *items;

-(id) initWithJSONDictionary:(NSDictionary *)jsonDict;
+(NSArray *) readFromJsonDictionayArray: (NSArray *)jsonDictArray;
-(int) currentPageNo;
-(BOOL) isLastPage;

@end
