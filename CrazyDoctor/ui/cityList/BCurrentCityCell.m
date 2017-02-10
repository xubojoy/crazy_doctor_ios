//
//  BCurrentCityCell.m
//  Bee
//
//  Created by 林洁 on 16/1/12.
//  Copyright © 2016年 Lin. All rights reserved.
//

#import "BCurrentCityCell.h"
#import "BAddressHeader.h"

@implementation BCurrentCityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = BG_CELL;
        [self.contentView addSubview:self.GPSButton];
        [self.contentView addSubview:self.locationManager];
        [self setUp];
    }
    return self;
}

- (void)setUp{
    [self.locationManager startWithBlock:^{
        
    } completionBlock:^(CLLocation *location) {
        [self.searchManager startReverseGeocode:location completeionBlock:^(LNLocationGeocoder *locationGeocoder, NSError *error) {
            if (!error) {
                self.GPSButton.userInteractionEnabled = YES;
                NSMutableString *mutableString = [NSMutableString stringWithFormat:@"%@",locationGeocoder.city];
                NSString *title;
                if ([NSStringUtils isNotBlank:mutableString]) {
                    title = [mutableString stringByReplacingOccurrencesOfString:@"市" withString:@""];
                }else{
                    title = [AppStatus sharedInstance].cityName;
                }
                
                [self.GPSButton setTitle:title forState:UIControlStateNormal];
//                [self.GPSButton setHidden:NO];
            }else{
                self.activityIndicatorView.hidden = NO;
            }
        }];
    } failure:^(CLLocation *location, NSError *error) {
        self.activityIndicatorView.hidden = NO;
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Event Response
- (void)buttonWhenClick:(void (^)(UIButton *))block{
    self.buttonClickBlock = block;
}

- (void)buttonClick:(UIButton*)button{
    self.buttonClickBlock(button);
}

#pragma mark - Getter and Setter
- (UIButton*)GPSButton{
    if (_GPSButton == nil) {
        _GPSButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _GPSButton.frame = CGRectMake(15, 15 , BUTTON_WIDTH, BUTTON_HEIGHT);
        [_GPSButton setTitle:@"定位中..." forState:UIControlStateNormal];
        _GPSButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        _GPSButton.tintColor = [UIColor blackColor];
        _GPSButton.backgroundColor = [UIColor whiteColor];
        _GPSButton.layer.borderColor = [ColorUtils colorWithHexString:common_app_text_color].CGColor;
        _GPSButton.layer.borderWidth = splite_line_height;
        _GPSButton.userInteractionEnabled = NO;
        [_GPSButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _GPSButton;
}

- (LNLocationManager*)locationManager{
    if (_locationManager == nil) {
        _locationManager = [[LNLocationManager alloc] init];
    }
    return _locationManager;
}

- (LNSearchManager*)searchManager{
    if (_searchManager == nil) {
        _searchManager = [[LNSearchManager alloc] init];
    }
    return _searchManager;
}

@end
