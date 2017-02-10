//
//  WLZBlockButton.h
//  WLZShareView
//
//  Created by lijiarui on 15/11/11.
//  Copyright © 2015年 lijiarui qq:81995383. All rights reserved.
//

#import <UIKit/UIKit.h>


@class WLZBlockButton;
typedef void (^TouchButton)(WLZBlockButton*);
@interface WLZBlockButton : UIButton

@property(nonatomic,copy)TouchButton block;

@end
