//
//  TongueDiagnosisTestCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/27.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    rightBtn_tag = 0,
    wrongBtn_tag = 1,
} SelectRightOrWrongBtnTag;

@protocol TongueDiagnosisTestCellDelegate <NSObject>

- (void)didSelectRightOrWrongBtnClick:(UIButton *)sender;

@end

@interface TongueDiagnosisTestCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@property (weak, nonatomic) IBOutlet UIButton *rightBtn;





@property (weak, nonatomic) IBOutlet UIButton *wrong;

@property (weak, nonatomic) IBOutlet UIView *downLine;


@property (nonatomic ,assign) id<TongueDiagnosisTestCellDelegate> delegate;

- (void)renderTongueDiagnosisTestCellWithTitle:(NSString *)title;

@end
