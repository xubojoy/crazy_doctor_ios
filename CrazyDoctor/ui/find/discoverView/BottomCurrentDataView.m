//
//  BottomCurrentDataView.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/18.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "BottomCurrentDataView.h"

@implementation BottomCurrentDataView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"BottomCurrentDataView" owner:self options:nil] objectAtIndex:0];
        self.frame = frame;
        self.downLine.backgroundColor = [UIColor whiteColor];
        
        self.remindLabel.layer.cornerRadius = self.remindLabel.frame.size.width/2;
        self.remindLabel.layer.masksToBounds = YES;
        self.remindLabel.layer.borderWidth = splite_line_height;
        self.remindLabel.layer.borderColor = [UIColor whiteColor].CGColor;
        self.remindLabel.textColor = [ColorUtils colorWithHexString:common_app_text_color];
        self.numLabel.textColor = [UIColor whiteColor];
    }
    return self;
}

- (void)renderBottomCurrentDataViewWithremindTitile:(NSString *)remindTitle numStr:(NSString *)numStr{
    self.remindLabel.text = remindTitle;
    self.numLabel.text = numStr;
}

@end
