//
//  UserAccountRecharge.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/6/28.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol UserAccountRecharge
@end
@interface UserAccountRecharge : JSONModel

@property (nonatomic ,assign) int id;
@property (nonatomic ,assign) int userId;
@property (nonatomic ,strong) NSString<Optional> *orderNumber;// 订单编号;
@property (nonatomic ,strong) NSString<Optional> *payType;//支付类型：weixinPay，aliPay
@property (nonatomic ,strong) NSString<Optional> *buyer;// 支付人账号
@property (nonatomic ,strong) NSString<Optional> *tradeNo;// 交易流水号
@property (nonatomic ,strong) NSString<Optional> *status;// 订单状态 unpay,paied
@property (nonatomic ,assign) float price;// 交易金额



@end
