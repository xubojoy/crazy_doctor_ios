//
//  Detailid.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/12.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol Detailid
@end
@interface Detailid : JSONModel
@property (nonatomic ,strong) NSString<Optional> *docitemid;
@property (nonatomic ,strong) NSString<Optional> *itemcode;
@property (nonatomic ,assign) int itemno;
@property (nonatomic ,assign) int itemsubno;
@property (nonatomic ,strong) NSString<Optional> *itemclass;
@property (nonatomic ,strong) NSString<Optional> *outpclass;
@property (nonatomic ,strong) NSString<Optional> *itemname;
@property (nonatomic ,strong) NSString<Optional> *medspec;
@property (nonatomic ,assign) int medjl;
@property (nonatomic ,strong) NSString<Optional> *medjldw;
@property (nonatomic ,assign) int leastnumber;
@property (nonatomic ,strong) NSString<Optional> *freqid;
@property (nonatomic ,assign) float price;
@property (nonatomic ,strong) NSString<Optional> *dosetypeid;
@property (nonatomic ,assign) int daynumber;
@property (nonatomic ,strong) NSString<Optional> *leastunit;
@property (nonatomic ,assign) float itemamount;

@end
