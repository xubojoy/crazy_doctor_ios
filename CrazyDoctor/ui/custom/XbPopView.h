//
//  XbPopView.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/19.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XbPopViewDelegate <NSObject>

- (void)didCancelBtnClick:(UIButton *)sender;

@end

@interface XbPopView : UIView


@property (weak, nonatomic) IBOutlet UIImageView *remindImgView;

@property (nonatomic ,assign) id<XbPopViewDelegate> delegate;


- (id)initWithFrame:(CGRect)frame remindImg:(NSString *)remindImgName;

@end
