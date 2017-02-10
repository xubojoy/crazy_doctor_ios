//
//  BottomCurrentDataView.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/18.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomCurrentDataView : UIView


@property (weak, nonatomic) IBOutlet UILabel *remindLabel;

@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@property (weak, nonatomic) IBOutlet UIView *downLine;

- (void)renderBottomCurrentDataViewWithremindTitile:(NSString *)remindTitle numStr:(NSString *)numStr;

@end
