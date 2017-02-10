//
//  BAddressPickerController.h
//  Bee
//
//  Created by 林洁 on 16/1/12.
//  Copyright © 2016年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXDCustomIndexView.h"
#import "Area.h"
#import "Province.h"
#import "City.h"
#import "RefreshUIView.h"
@class BAddressPickerController;

@protocol BAddressPickerDataSource <NSObject>
@required
@end

@protocol BaddressPickerDelegate <NSObject>

-(void)addressPicker:(BAddressPickerController*)addressPicker didSelectedCity:(NSString*)city;

@end

@interface BAddressPickerController : BaseViewController<UITableViewDataSource,UITableViewDelegate,YXDCustomIndexViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate,RefreshUIViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
//数据源代理协议
@property (nonatomic, weak) id<BAddressPickerDataSource> dataSource;
//委托代理协议
@property (nonatomic, weak) id<BaddressPickerDelegate> delegate;
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic, strong) UIButton *shareBtn;

@property (nonatomic, strong) UISearchBar *mySearchBar;
@property (nonatomic, strong) UISearchDisplayController *mySearchDisplayController;

@property (nonatomic, strong) YXDCustomIndexView *customIndexView;
@property (nonatomic ,strong) RefreshUIView *refreshUIView;

@property (nonatomic ,strong) Area *area;
@property (nonatomic ,strong) Province *province;
@property (nonatomic ,strong) City *city;
@property (nonatomic ,strong) City *hotCity;
@property (nonatomic ,strong) NSMutableArray *citiesArray;
@property (nonatomic ,strong) NSMutableArray *sortCityArray;
@property (nonatomic ,strong) NSMutableDictionary *sortCityDict;
@property (nonatomic ,strong) NSMutableArray *recentVisitCityArray;
@property (nonatomic ,strong) NSMutableArray *hotCitiesArray;
@property (nonatomic ,strong) NSMutableDictionary *recentCitesDict;

@property (nonatomic ,assign) int pushType;

@end
