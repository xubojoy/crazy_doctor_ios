//
//  ReadyForTongueDiagnosisController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/25.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AVFoundation/AVCaptureSession.h>
#import <AVFoundation/AVCaptureInput.h>
#import "ReadyForTongueDiagnosisBottomView.h"
@interface ReadyForTongueDiagnosisController : BaseViewController<ReadyForTongueDiagnosisBottomViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) UIView *topBgView;
@property (nonatomic ,strong) UILabel *topLabel;
@property (nonatomic ,strong) UILabel *remarkLabel;
@property (nonatomic ,strong) UIImageView *remindImgView;
@property (nonatomic ,strong) UILabel *contentLabel;
@property (nonatomic ,strong) AVCaptureSession *captureSession;
@property (nonatomic ,strong) ReadyForTongueDiagnosisBottomView *readyForTongueDiagnosisBottomView;


@end
