//
//  HeaderView.m
//  styler
//
//  Created by System Administrator on 14-1-16.
//  Copyright (c) 2014年 mlzj. All rights reserved.
//

#import "HeaderView.h"
#import "UIImage+imagePlus.h"
#import "ColorUtils.h"
@implementation HeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       
    }
    return self;
}

-(id)initWithTitle:(NSString *)titleStr navigationController:(UINavigationController *)navigationController
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:self options:nil] objectAtIndex:0];
        self.backgroundColor = [UIColor whiteColor];
        self.nc = navigationController;
        
        self.bgImg.image = [UIImage imageNamed:@"top_bar"];
        [self.title setFont:[UIFont boldSystemFontOfSize:bigger_1_font_size]];
        [self.title setTextColor:[ColorUtils colorWithHexString:common_app_text_color]];
        [self.title setTextAlignment:NSTextAlignmentCenter];
        [self.title setText:[titleStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        self.title.backgroundColor = [UIColor clearColor];
        
        [self.backBut setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
        [self.backBut addTarget:self action:@selector(popToFrontViewController:) forControlEvents:UIControlEventTouchUpInside];
        [self.backBut setTitle:@"返回" forState:UIControlStateNormal];
        self.backBut.titleLabel.font = [UIFont systemFontOfSize:default_font_size];
        self.backBut.backgroundColor = [UIColor clearColor];
        [self.backBut setTitleColor:[ColorUtils colorWithHexString:black_text_color] forState:UIControlStateNormal];
        
        self.line.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
        self.line.frame = CGRectMake(self.line.frame.origin.x, self.line.frame.origin.y, self.line.frame.size.width,  splite_line_height);
        CGRect titleFrame = self.title.frame;
        CGRect bgImgFrame = self.bgImg.frame;
        CGRect backButFrame = self.backBut.frame;
        CGRect linFrame = self.line.frame;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
            bgImgFrame.size.height = navigation_height + status_bar_height+splite_line_height;
            titleFrame.origin.y = status_bar_height + ((navigation_height-titleFrame.size.height)/2);
            titleFrame.size.width = screen_width - 130;
            backButFrame.origin.x = 0;
            backButFrame.origin.y = status_bar_height+((navigation_height-backButFrame.size.height)/2);
            backButFrame.size.width = 60;
            linFrame.origin.y = status_bar_height + navigation_height+splite_line_height;
            linFrame.size.height = splite_line_height;
            linFrame.size.width = screen_width;
        }else
        {
            bgImgFrame.size.height = navigation_height+splite_line_height;
            titleFrame.origin.y = (navigation_height-titleFrame.size.height)/2;
            titleFrame.size.width = screen_width - 130;
            backButFrame.origin.x = 0;
            backButFrame.origin.y = ((navigation_height-backButFrame.size.height)/2);
            backButFrame.size.width = 60;
            linFrame.origin.y = navigation_height+splite_line_height;
            linFrame.size.height = splite_line_height;
            linFrame.size.width = screen_width;
        }
        self.title.frame = titleFrame;
        self.bgImg.frame = bgImgFrame;
        self.backBut.frame = backButFrame;
        self.line.frame = linFrame;
//        NSLog(@">>>>>>>>>>>>>>>>>bgImgFrame.size.height>>>>>%f",bgImgFrame.size.height);
        self.frame = CGRectMake(0, 0, screen_width, bgImgFrame.size.height);;
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(void)popToFrontViewController:(id)sender
{
    if (self.type == from_order) {
        [self.nc popToRootViewControllerAnimated:YES];
    }else if (self.type == from_set_user_info){
        [[NSNotificationCenter defaultCenter] postNotificationName:notification_name_update_user_avatar object:nil];
        [self.nc popViewControllerAnimated:YES];
    }else if (self.type == from_user_club_order_list){
        [self.nc popToRootViewControllerAnimated:YES];
    }else if (self.type == from_user_shopping_cart){
        [self.nc popToRootViewControllerAnimated:YES];
    }else if (self.type == from_user_commodity_order_detail){
        [self.nc popToRootViewControllerAnimated:YES];
    }else if (self.type == from_user_commodity_order_list){
        [self.nc popToRootViewControllerAnimated:YES];
    }else if (self.type == from_guess_game_vc){
        [self.nc popToRootViewControllerAnimated:YES];
    }
    else if (self.type == from_game_code_search_vc){
        [self.nc popToRootViewControllerAnimated:YES];
    }else if (self.type == from_user_join_game_vc){
        [self.nc popToRootViewControllerAnimated:YES];
    }
    else{
        [self.nc popViewControllerAnimated:YES];
    }
}

@end
