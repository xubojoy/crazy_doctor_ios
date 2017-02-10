//
//  CDAlertViewController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/18.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "CDAlertViewController.h"
#import "AppDelegate.h"
@implementation SHBAction

- (id)initWithTitle:(NSString *)title action:(dispatch_block_t)action {
    self = [super init];
    if (self) {
        _title = title;
        _action = action;
    }
    return self;
}

+ (SHBAction *)actionWithTitle:(NSString *)title action:(dispatch_block_t)action {
    SHBAction *ac = [[SHBAction alloc] initWithTitle:title action:action];
    return ac;
}

@end
@interface CDAlertViewController ()<UITextFieldDelegate>
{
    NSString            *_title;
    UIImage             *_image;
    NSString            *_message;
    
    UIView              *_backView;
    
    UILabel             *_titleLbl;
    UIImageView         *_photo;
    UILabel             *_messageLbl;
    UITextField         *_textField;
    
    UIButton            *_cancel;
    UIButton            *_send;
    
    UIView              *_hLine;
    UIView              *_vLine;
    
    CGFloat             _backBottom;
    NSLayoutConstraint  *_bottom;
    
    NSMutableArray      *_actions;
}

@end
CGFloat backViewH = 140;
@implementation CDAlertViewController

- (id)initWithTitle:(NSString *)title image:(UIImage *)image message:(NSString *)message {
    self = [super init];
    if (self) {
        _title = title;
        _image = image;
        _message = message;
        _actions = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    _backBottom = -(CGRectGetHeight(self.view.frame) - backViewH) / 2.;
    
    _backView = [[UIView alloc] initWithFrame:CGRectMake((screen_width-280)/2, (CGRectGetHeight(self.view.frame) - backViewH) / 2., 280, 140)];
    _backView.backgroundColor = [UIColor whiteColor];
    _backView.layer.cornerRadius = 5;
    _backView.layer.masksToBounds = true;
    [self.view addSubview:_backView];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 25, 260, 40)];
    _textField.layer.borderColor = [ColorUtils colorWithHexString:@"#e2e1e1"].CGColor;
    _textField.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
    _textField.layer.cornerRadius = 2;
    _textField.delegate = self;
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.placeholder = @"    请输入运动目标步数";
    [_textField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [_backView addSubview:_textField];
    
    
    UIColor *lineColor = [ColorUtils colorWithHexString:splite_line_color];
    
    _hLine = [[UIView alloc] initWithFrame:CGRectMake(0, 90, 280, 0.5)];
    _hLine.backgroundColor = lineColor;
    [_backView addSubview:_hLine];
    
    _vLine = [[UIView alloc] initWithFrame:CGRectMake(140, 90, 0.5, 50)];
    _vLine.backgroundColor = lineColor;
    [_backView addSubview:_vLine];
    
    _cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancel.frame = CGRectMake(0, 90, 140, 50);
    NSString *cancel = [(SHBAction *)_actions[0] title];
    [_cancel setTitle:cancel forState:UIControlStateNormal];
    [_cancel setTitleColor:[ColorUtils colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    _cancel.titleLabel.font = [UIFont systemFontOfSize:15];
    [_cancel addTarget:self action:@selector(shbClickedBtn:) forControlEvents:UIControlEventTouchUpInside];
    _cancel.tag = 100;
    [_backView addSubview:_cancel];
    
    _send = [UIButton buttonWithType:UIButtonTypeCustom];
    _send.frame = CGRectMake(140, 90, 140, 50);
    NSString *send = [(SHBAction *)_actions[1] title];
    [_send setTitle:send forState:UIControlStateNormal];
    [_send setTitleColor:[ColorUtils colorWithHexString:common_app_text_color] forState:UIControlStateNormal];
    _send.titleLabel.font = [UIFont systemFontOfSize:15];
    [_send addTarget:self action:@selector(shbClickedBtn:) forControlEvents:UIControlEventTouchUpInside];
    _send.tag = 200;
    [_backView addSubview:_send];
    
    [self registerKeyBoard];
}

-(void)textFieldDidChanged:(UITextField *)textField
{
    
    if (textField == _textField) {
        
//        NSLog(@">>>>>self.price>>>>>>>>>%f",self.price);
        if ([_textField.text floatValue] > 999999) {
            _textField.text = [_textField.text substringToIndex:(int)_textField.text.length-1];
            [self.view makeToast:@"步数不能大于999999" duration:2.0 position:[NSValue valueWithCGPoint:CGPointMake(screen_width/2, 200)]];
            return;
        }else{
            _textField.text = _textField.text;
        }
        
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string

{
    //emoji无效
    if([NSStringUtils isContainsEmoji:string])
        
    {
        return NO;
        
    }else{
        if (textField == _textField) {
            if (![self validateNumber:string]) {
                return NO;
            }else{
                return YES;
            }
        }
        else{
            return YES;
        }
    }
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}


- (void)keyBoardShow:(NSNotification *)info {
    
    NSValue *keyBoardRect = [[info userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyRect = [keyBoardRect CGRectValue];
    
    if (_backBottom > -keyRect.size.height) {
        _bottom.constant = -30 - keyRect.size.height;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyBoardHidden:(NSNotification *)info {
    _bottom.constant = _backBottom;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}


- (void)shbClickedBtn:(UIButton *)btn {
    _content = _textField.text;
    if (btn.tag == 100) {
        SHBAction *action = _actions[0];
        if (action.action) {
            action.action();
        }
    } else {
        SHBAction *action = _actions[1];
        if (action.action) {
            action.action();
        }
    }
    [self dismiss];
}

- (void)addAction:(SHBAction *)action {
    [_actions addObject:action];
}


- (void)show {
    UIViewController *result = [self currentController];
    [result addChildViewController:self];
    [result.view addSubview:self.view];
}

- (void)dismiss {
    __weak typeof(self) SHB = self;
    [UIView animateWithDuration:0.1 animations:^{
        [SHB.view removeFromSuperview];
        [SHB removeFromParentViewController];
    } completion:^(BOOL finished) {
        [SHB removeKeyBoard];
    }];
}

- (UIViewController *)currentController {
    UIViewController *result = nil;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        
        for (UIWindow *temWin in windows) {
            if (temWin.windowLevel == UIWindowLevelNormal) {
                window = temWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nestResponder = [frontView nextResponder];
    if ([nestResponder isKindOfClass:[UIViewController class]]) {
        result = nestResponder;
    } else {
        result = window.rootViewController;
    }
    return result;
}

#pragma mark - Keyboard
- (void)registerKeyBoard {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHidden:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)removeKeyBoard {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_textField resignFirstResponder];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
