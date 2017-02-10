//
//  ReadyForTongueDiagnosisBottomView.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/25.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    okBtn_tag = 0,
    noRemindBtn_tag = 1,
} ReadyForTongueDiagnosisBottomViewBtnTag;

@protocol ReadyForTongueDiagnosisBottomViewDelegate <NSObject>

- (void)didReadyForTongueDiagnosisBottomViewBtnClick:(UIButton *)sender;

@end

@interface ReadyForTongueDiagnosisBottomView : UIView


@property (weak, nonatomic) IBOutlet UIView *upLine;


@property (weak, nonatomic) IBOutlet UIButton *okBtn;

@property (weak, nonatomic) IBOutlet UIButton *noRemindBtn;
@property (nonatomic ,assign) id<ReadyForTongueDiagnosisBottomViewDelegate> delegate;

@end
