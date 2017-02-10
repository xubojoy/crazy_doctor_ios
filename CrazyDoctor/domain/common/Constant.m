//
//  Constant.m
//  styler
//
//  Created by System Administrator on 13-5-10.
//  Copyright (c) 2013年 mlzj. All rights reserved.
//

#import "ColorUtils.h"
#import "Constant.h"

#define waterfall_bg_color_green  @"#b6d7b4"
#define waterfall_bg_color_yellow @"#f1e6d6"
#define waterfall_bg_color_blue   @"#ceeefb"
#define waterfall_bg_color_red    @"#f2d6c2"
@implementation Constant
-(UIColor *) getWaterfallBgColor{
    return (UIColor *)[self.bgColors objectAtIndex:(arc4random() % 3)];
}

+(Constant *) sharedInstance{
    static Constant *constant = nil;
    if(!constant){
        constant = [[super allocWithZone:nil] init];
        
        NSMutableArray *bgColors = [[NSMutableArray alloc] init];
        [bgColors addObject:[ColorUtils colorWithHexString:waterfall_bg_color_blue]];
        [bgColors addObject:[ColorUtils colorWithHexString:waterfall_bg_color_green]];
        [bgColors addObject:[ColorUtils colorWithHexString:waterfall_bg_color_red]];
        [bgColors addObject:[ColorUtils colorWithHexString:waterfall_bg_color_yellow]];
        
        constant.bgColors = bgColors;
    }
    
    return constant;
}

+(NSString *)getPriceString:(float)minPrice{
    NSString * tmpMinPrice;
    int price = (int)minPrice;
    float tmpPrice = minPrice-price;
    if (tmpPrice > 0) {
        tmpMinPrice = [NSString stringWithFormat:@"%.2f",minPrice];
    }else if(tmpPrice == 0){
        tmpMinPrice = [NSString stringWithFormat:@"%.0f",minPrice];
    }
    return tmpMinPrice;
}


+(id) allocWithZone:(NSZone *)zone{
    return [self sharedInstance];
}

@end
