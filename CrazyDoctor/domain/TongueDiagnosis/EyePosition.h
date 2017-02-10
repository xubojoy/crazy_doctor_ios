//
//  EyePosition.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/29.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol EyePosition
@end
@interface EyePosition : JSONModel
@property (nonatomic ,assign) int positionId;// 位置
@property (nonatomic ,strong) NSString<Optional> *organ;//  器官
@property (nonatomic ,strong) NSString<Optional> *imgUrl;// 器官图片
@property (nonatomic ,strong) NSString<Optional> *remark;

@end
