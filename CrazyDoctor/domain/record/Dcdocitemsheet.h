//
//  Dcdocitemsheet.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/12.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Detailid.h"
@protocol Dcdocitemsheet
@end
@interface Dcdocitemsheet : JSONModel
@property (nonatomic ,strong) NSString<Optional> *docitemid;
@property (nonatomic ,strong) NSString<Optional> *reid;
@property (nonatomic ,strong) NSString<Optional> *itemType;
@property (nonatomic ,strong) NSArray<Detailid *><Optional> *detailid;
@end
