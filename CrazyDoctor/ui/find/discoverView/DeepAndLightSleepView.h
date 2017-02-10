//
//  DeepAndLightSleepView.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/25.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharkeyData.h"
@interface DeepAndLightSleepView : UIView
@property (weak, nonatomic) IBOutlet UILabel *lightSleepLabel;

@property (weak, nonatomic) IBOutlet UILabel *deepSleepLabel;

- (void)renderDeepAndLightSleepView:(SharkeyData *)sharkeyData;

@end
