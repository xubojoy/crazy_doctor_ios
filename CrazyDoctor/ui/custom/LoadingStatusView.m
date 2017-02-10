//
//  LoadingStatusView.m
//  styler
//
//  Created by System Administrator on 14-1-14.
//  Copyright (c) 2014年 mlzj. All rights reserved.
//

#import "LoadingStatusView.h"

@implementation LoadingStatusView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"LoadingStatusView" owner:self options:nil] objectAtIndex:0];
        self.frame = frame;
    }
    self.note.font = [UIFont systemFontOfSize:default_font_size];
    self.note.numberOfLines = 0;
    self.note.textColor = [ColorUtils colorWithHexString:gray_text_color];
    self.backgroundColor = [UIColor clearColor];
    return self;
}

-(void) updateStatus:(NSString *)noteTxt animating:(BOOL)animating
{
    self.note.text = noteTxt;
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:default_font_size]};
    CGSize noteTxtSize = [self.note.text boundingRectWithSize:CGSizeMake(screen_width, 0)
                                          options:
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                       attributes:attribute
                                          context:nil].size;
    
    float width = self.indicator.frame.size.width + 5 + noteTxtSize.width;
    float x = (screen_width-width)/2;
    
    CGRect indicatorFrame = self.indicator.frame;
    indicatorFrame.origin.x = x;
    self.indicator.frame = indicatorFrame;
    
    x = x + self.indicator.frame.size.width + 5;
    self.note.frame = CGRectMake(x, self.note.frame.origin.y, noteTxtSize.width, 40);
    self.indicator.hidesWhenStopped = YES;
    if (animating) {
        [self.indicator startAnimating];
    }else{
        [self.indicator stopAnimating];
        CGRect frame = self.note.frame;
        frame.origin.x = (screen_width - self.note.frame.size.width)/2;
        self.note.frame = frame;
    }
    if ([noteTxt isEqualToString:network_status_no_more]) {
        self.indicator.hidden = YES;
    }else if (!noteTxt && !animating) {
        self.hidden = YES;
    }
}

@end
