//
//  UserAccountCash.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/6/28.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol UserAccountCash
@end
@interface UserAccountCash : JSONModel
@property (nonatomic ,assign) int id;
@property (nonatomic ,assign) int userId;
@property (nonatomic ,strong) NSString<Optional> *status;// 状态：waiting等待，confirmed确认，canceled取消
@property (nonatomic ,assign) float price;
@property (nonatomic ,strong) NSString<Optional> *accountNo;// 账号
@property (nonatomic ,strong) NSString<Optional> *accountName;// 账号姓名

@end
