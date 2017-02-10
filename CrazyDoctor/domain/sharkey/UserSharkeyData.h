//
//  UserSharkeyData.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/25.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol UserSharkeyData
@end
@interface UserSharkeyData : JSONModel
@property (nonatomic ,assign) int userId;
@property (nonatomic ,strong) NSString<Optional> *name;
@property (nonatomic ,strong) NSString<Optional> *avatarUrl;
@property (nonatomic ,assign) int userGender;
@property (nonatomic ,assign) int step;
@property (nonatomic ,assign) int orderInx;

@end
