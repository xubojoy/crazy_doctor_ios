//
//  TopReCheckView.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/20.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TopReCheckViewDelegate <NSObject>

- (void)didreCheckBtnClick:(UIButton *)sender;

@end

@interface TopReCheckView : UIView

@property (weak, nonatomic) IBOutlet UILabel *dayCountLbel;
@property (weak, nonatomic) IBOutlet UIButton *reCkeckBtn;
@property (nonatomic ,assign) id<TopReCheckViewDelegate> delegate;

- (void)renderTopReCheckView:(NSString *)str;

@end
