//
//  GaodeMapProcessor.h
//  styler
//
//  Created by System Administrator on 13-7-16.
//  Copyright (c) 2013年 mlzj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
@interface GaodeMapProcessor : NSObject<MAMapViewDelegate, AMapSearchDelegate>
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;

@property BOOL locating;
-(void) startLocation;
+ (GaodeMapProcessor *) sharedInstance;

@end
