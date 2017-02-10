//
//  ChineseString.h
//  AccountList
//
//  Created by Seiko on 15/10/14.
//  Copyright © 2015年 Seiko. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "pinyin.h"

@interface ChineseString : NSObject
@property(retain,nonatomic)NSString *string;
@property(retain,nonatomic)NSString *pinYin;
/**添加一个属性,保存名字所对应的字典*/
@property(nonatomic, strong)NSDictionary *info;

//-----  返回tableview右方indexArray
+(NSMutableArray*)IndexArray:(NSArray*)stringArr;

//-----  返回联系人
+(NSMutableArray*)LetterSortArray:(NSArray*)stringArr;

@end
