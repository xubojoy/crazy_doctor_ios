//
//  RefreshUIView.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/21.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RefreshUIViewDelegate <NSObject>

- (void)didReLoadDataBtnClick:(UIButton *)sender;

@end

@interface RefreshUIView : UIView

@property (weak, nonatomic) IBOutlet UIButton *reLoadDataBtn;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic ,assign) id<RefreshUIViewDelegate> delegate;

@end
