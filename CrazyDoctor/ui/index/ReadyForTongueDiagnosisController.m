//
//  ReadyForTongueDiagnosisController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/25.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "ReadyForTongueDiagnosisController.h"
#import "TongueDiagnosisCompareController.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import "TongueDiagnosisStore.h"
@interface ReadyForTongueDiagnosisController ()

@end

@implementation ReadyForTongueDiagnosisController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ColorUtils colorWithHexString:white_text_color];
    [self setRightSwipeGestureAndAdaptive];
    [self initUI];
}
- (void)initUI{
    [self initHeadView];
    [self initContentView];
    [self initBottomView];
}

//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"预备舌诊" navigationController:self.navigationController];
    [self.view addSubview:self.headerView];
}

- (void)initContentView{
    self.topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height+splite_line_height, screen_width, 53)];
    self.topBgView.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    [self.view addSubview:self.topBgView];
    
    
    self.topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 13, screen_width, 20)];
    self.topLabel.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    self.topLabel.text = @"舌拍一下为您提供“定制化”养生方案";
    self.topLabel.font = [UIFont boldSystemFontOfSize:default_font_size];
    self.topLabel.textColor = [ColorUtils colorWithHexString:gray_text_color];
    self.topLabel.textAlignment = NSTextAlignmentCenter;
    [self.topBgView addSubview:self.topLabel];
    
    self.remarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.topLabel.bottomY, screen_width, 20)];
    self.remarkLabel.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    self.remarkLabel.text = @"(示意图)";
    self.remarkLabel.font = [UIFont systemFontOfSize:smaller_font_size];
    self.remarkLabel.textColor = [ColorUtils colorWithHexString:light_gray_text_color];
    self.remarkLabel.textAlignment = NSTextAlignmentCenter;
    [self.topBgView addSubview:self.remarkLabel];
    
    self.remindImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.topBgView.bottomY, screen_width, 245)];
    self.remindImgView.backgroundColor = [ColorUtils colorWithHexString:orange_common_color];
    [self.view addSubview:self.remindImgView];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.remindImgView.bottomY+18, screen_width, screen_height-self.remindImgView.bottomY-tabbar_height)];
    self.contentLabel.backgroundColor = [ColorUtils colorWithHexString:white_text_color];
    NSString *contentStr = @"1.请在充足光线在拍照。\n2.刷牙及饭后不要立即做舌像自诊，会有误差。\n3.不要在吃进色素等人为染苔行为下做自诊。";
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:contentStr];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:17];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [contentStr length])];
    [self.contentLabel setAttributedText:attributedString];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.textColor = [ColorUtils colorWithHexString:light_gray_text_color];
    self.contentLabel.font = [UIFont systemFontOfSize:default_font_size];
    self.contentLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentLabel sizeToFit];
    [self.view addSubview:self.contentLabel];

}


- (void)initBottomView{
    self.readyForTongueDiagnosisBottomView = [[ReadyForTongueDiagnosisBottomView alloc] initWithFrame:CGRectMake(0, screen_height-51, screen_width, 51)];
    self.readyForTongueDiagnosisBottomView.backgroundColor = [ColorUtils colorWithHexString:white_text_color];
    self.readyForTongueDiagnosisBottomView.delegate = self;
    [self.view addSubview:self.readyForTongueDiagnosisBottomView];
}

- (void)didReadyForTongueDiagnosisBottomViewBtnClick:(UIButton *)sender{
    switch (sender.tag) {
        case okBtn_tag:
        {
            [self tokePhoto];
        }
            break;
        case noRemindBtn_tag:
        {
            [AppStatus sharedInstance].noRemind = YES;
            [AppStatus saveAppStatus];
            [self tokePhoto];
        }
            break;
            
        default:
            break;
    }

}

- (void)tokePhoto{
   
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
    if (!isCamera) {
        NSLog(@"没有摄像头");
        return ;
    }
    [imagePicker setDelegate:self];
    [imagePicker setAllowsEditing:YES];
    [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self.view.window.rootViewController presentViewController:imagePicker animated:YES completion:nil];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    image = [ImageUtils imageWithImageSimple:image scaledToSize:CGSizeMake(220, 220)];
    [SVProgressHUD showWithStatus:@"图片上传中..." maskType:SVProgressHUDMaskTypeBlack];
    [TongueDiagnosisStore upLoadTongueDiagnosisImg:^(NSString *imgUrl, NSError *err) {
        [SVProgressHUD dismiss];
        if (imgUrl != nil) {
            NSLog(@">>>>>>>>>>>>>>>>>>上传的舌头照片----%@",imgUrl);
            TongueDiagnosisCompareController *tdcvc = [[TongueDiagnosisCompareController alloc] initWithImage:imgUrl];
            [self.navigationController pushViewController:tdcvc animated:YES];
        }else{
            ExceptionMsg *exception = [[err userInfo] objectForKey:@"ExceptionMsg"];
            [self.view makeToast:exception.message duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        }
    } tongueImage:image];
}

// 判断设备是否有摄像头
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

// 前面的摄像头是否可用
- (BOOL) isFrontCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

// 后面的摄像头是否可用
- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) hasMultipleCameras {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    if (devices != nil && [devices count] > 1) {
        return YES;
    }
    return NO;
}

- (AVCaptureDevice *)cameraWithPosition : (AVCaptureDevicePosition) position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices ){
        if ( device.position == position ){
            return device;
        }
    }
    return nil ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
