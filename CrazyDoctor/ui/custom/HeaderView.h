//
//  HeaderView.h
//  styler
//
//  Created by System Administrator on 14-1-16.
//  Copyright (c) 2014年 mlzj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *bgImg;
@property (weak, nonatomic) IBOutlet UIButton *backBut;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) UINavigationController *nc;
@property (nonatomic, assign) popType type;

-(id) initWithTitle:(NSString *)title navigationController:(UINavigationController *)nc;

@end
