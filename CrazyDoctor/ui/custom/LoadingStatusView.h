//
//  LoadingStatusView.h
//  styler
//
//  Created by System Administrator on 14-1-14.
//  Copyright (c) 2014年 mlzj. All rights reserved.
//

#import <UIKit/UIKit.h>

#define loading_view_height 40
@interface LoadingStatusView : UIView

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UILabel *note;

-(void) updateStatus:(NSString *)noteTxt
           animating:(BOOL)animating;

@end
