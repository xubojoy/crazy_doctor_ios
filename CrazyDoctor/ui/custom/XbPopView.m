//
//  XbPopView.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/19.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "XbPopView.h"

@implementation XbPopView

- (id)initWithFrame:(CGRect)frame remindImg:(NSString *)remindImgName
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"XbPopView" owner:self options:nil] objectAtIndex:0];
        self.frame = frame;
        self.layer.cornerRadius = 5;
        self.backgroundColor = [UIColor whiteColor];
        
        self.remindImgView.image = [UIImage imageNamed:remindImgName];
        self.remindImgView.contentMode = UIViewContentModeScaleAspectFit;
        self.remindImgView.clipsToBounds = YES;
    }
    return self;
}

- (IBAction)cancelBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didCancelBtnClick:)]) {
        [self.delegate didCancelBtnClick:sender];
    }
}

@end
