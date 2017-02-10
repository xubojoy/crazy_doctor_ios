//
//  Hospital.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/10.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol Hospital
@end
@interface Hospital : JSONModel
@property (nonatomic ,assign) int id;

@property (nonatomic ,strong) NSString *name;
@property (nonatomic ,strong) NSString *tel;
@property (nonatomic ,strong) NSString *address;// 医院地址


@end
