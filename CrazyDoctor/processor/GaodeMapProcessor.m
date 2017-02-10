//
//  GaodeMapProcessor.m
//  styler
//
//  Created by System Administrator on 13-7-16.
//  Copyright (c) 2013年 mlzj. All rights reserved.
//


#import "GaodeMapProcessor.h"
#import "LBSUtils.h"

@implementation GaodeMapProcessor

-(void) startLocation{
    self.mapView.showsUserLocation = YES;
}

-(void)mapView:(MAMapView*)mapView didUpdateUserLocation:(MAUserLocation*)userLocation updatingLocation:(BOOL)updatingLocation
{
//    33.9348470000,116.4560270000
//    33.0175460000,114.0294650000
    CLLocation *currentLocation = userLocation.location;
//    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:33.0175460000 longitude:114.0294650000];
    if (currentLocation) {
        
        //取出当前位置的坐标
        
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
//        CLLocation * location = [userLocation firstObject];
        [AppStatus sharedInstance].lastLat = userLocation.location.coordinate.latitude;
        [AppStatus sharedInstance].lastLng = userLocation.location.coordinate.longitude;
        [AppStatus saveAppStatus];
        
//        NSMutableArray *provinceArray = [[NSMutableArray alloc] initWithObjects:@"北京",@"天津",@"上海",@"重庆",@"河北",@"山西",@"辽宁",@"吉林",@"黑龙江",@"江苏",@"浙江",@"安徽",@"福建",@"江西",@"山东",@"河南",@"湖北",@"湖南",@"广东",@"海南",@"四川",@"贵州",@"云南",@"陕西",@"甘肃",@"青海",@"台湾",@"内蒙古",@"广西",@"西藏",@"宁夏",@"新疆",@"香港",@"澳门", nil];
               //
        
        CLGeocoder * geocoder = [[CLGeocoder alloc]init];
        
        [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (error == nil && [placemarks count] > 0) {
                //这时的placemarks数组里面只有一个元素
                CLPlacemark * placemark = [placemarks firstObject];
//                NSLog(@"%@",placemark.addressDictionary); //根据经纬度会输出该经纬度下的详细地址 国家 地区 街道 之类的
//                NSLog(@">>>>>>>>City>>>>>>>>%@",[placemark.addressDictionary valueForKey:@"City"]);
//                NSLog(@">>>>>>>>>FormattedAddressLines>>>>>>>%@",[placemark.addressDictionary valueForKey:@"FormattedAddressLines"][0]);
//                NSLog(@">>>>>>>Country>>>>>>>>>%@",[placemark.addressDictionary valueForKey:@"Country"]);
//                NSLog(@">>>>>>>>>Name>>>>>>>%@",[placemark.addressDictionary valueForKey:@"Name"]);
//                NSLog(@">>>>>>>>>>SubLocality>>>>>>%@",[placemark.addressDictionary valueForKey:@"SubLocality"]);
//                NSLog(@">>>>>>>>>State>>>>>>>%@",[placemark.addressDictionary valueForKey:@"State"]);
                NSDictionary *dictionary = [placemark addressDictionary];
                
                NSMutableString *mutableString = [NSMutableString stringWithFormat:@"%@",dictionary[@"City"]];
//                NSString *tmpCity = [mutableString stringByReplacingOccurrencesOfString:@"市" withString:@""];
                [AppStatus sharedInstance].cityName = mutableString;
                [AppStatus saveAppStatus];
                NSLog(@">>>>>>>>>>>保存的省份>>>>>%@",[AppStatus sharedInstance].cityName);
                //                NSString *cityStr = [placemark.addressDictionary valueForKey:@"State"];
                //                for (int i = 0; i < provinceArray.count; i ++) {
                //                    NSString *tmpProvinceStr = provinceArray[i];
                //                    if ([cityStr hasPrefix:tmpProvinceStr]) { //用来比较定位出的省份是否有数组里的字符串
                //                        [AppStatus sharedInstance].cityName = tmpProvinceStr;
                //                        NSLog(@">>>>>>>>>>>保存的省份>>>>>%@",[AppStatus sharedInstance].cityName);
                //                        [[NSNotificationCenter defaultCenter] postNotificationName:notification_name_refresh_mainVC_city_name object:tmpProvinceStr];
                //                        [[NSNotificationCenter defaultCenter] postNotificationName:notification_name_load_mainVC_recommend_club object:tmpProvinceStr];
                //                        [AppStatus saveAppStatus];
                //                    }
                //                }
                
            }
        }];

        self.mapView.showsUserLocation = NO;
        [AppStatus sharedInstance].lastLat = userLocation.location.coordinate.latitude;
        [AppStatus sharedInstance].lastLng = userLocation.location.coordinate.longitude;
        [AppStatus saveAppStatus];
        //初始化检索对象
        self.search = [[AMapSearchAPI alloc] initWithSearchKey:gaode_map_key Delegate:self];
        
        AMapReGeocodeSearchRequest *regeoRequest = [[AMapReGeocodeSearchRequest alloc] init];
        regeoRequest.searchType = AMapSearchType_ReGeocode;
        regeoRequest.location = [AMapGeoPoint locationWithLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude];
        regeoRequest.radius = 2000;
        regeoRequest.requireExtension = YES;
        [self.search AMapReGoecodeSearch: regeoRequest];  // 逆地理位置查询

    }
}

#pragma mark --逆地理位置的查询结果回调
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
//    NSString *result = [NSString stringWithFormat:@"ReGeocode: %@", response.regeocode];
//    NSLog(@"ReGeo: %@", result);
    
    AMapReGeocode *aMapReGeocode = response.regeocode;
    NSString *currentLocationStr  = aMapReGeocode.formattedAddress;
//    NSLog(@">>>>>>>>>>>>>temp--地址是-----%@",currentLocationStr);
    NSArray *pois = aMapReGeocode.pois;
    if (pois.count == 0) {
        return;
    }
//    [AppStatus sharedInstance].currentLocation = [NSString stringWithFormat:@"%@%@", [pois[0] address], [pois[0] name]];
    [AppStatus sharedInstance].currentLocation = currentLocationStr;
    
    NSLog(@">>>>>>>>>>>[AppStatus sharedInstance].currentLocation >>>>>>>>>>%@",[AppStatus sharedInstance].currentLocation );
    [AppStatus saveAppStatus];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"user_location_change" object:nil];
//    self.mapView.showsUserLocation = NO;
}

-(void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
//    self.locating = NO;
    if (error != nil)
		NSLog(@"locate failed: %@", [error localizedDescription]);
	else {
		NSLog(@"locate failed");
	}
}

-(NSString*)keyForMap{
    return gaode_map_key;
}

+ (GaodeMapProcessor *) sharedInstance{
    static GaodeMapProcessor *sharedInstance = nil;
    if(sharedInstance == nil){
        [MAMapServices sharedServices].apiKey = gaode_map_key;
        
        sharedInstance = [[GaodeMapProcessor alloc] init];
        sharedInstance.mapView = [[MAMapView alloc] init];
        sharedInstance.mapView.delegate = sharedInstance;
        sharedInstance.search = [[AMapSearchAPI alloc] initWithSearchKey:gaode_map_key Delegate:sharedInstance];
    }
    return sharedInstance;
}

@end
