//
//  HomeViewController.m
//  LLSimpleCameraExample
//
//  Created by Ömer Faruk Gül on 29/10/14.
//  Copyright (c) 2014 Ömer Faruk Gül. All rights reserved.
//

#import "HomeViewController.h"
#import "ViewUtils.h"
#import "CutPicViewController.h"
@interface HomeViewController ()<CutPicViewControllerDelegate>
@property (strong, nonatomic) LLSimpleCamera *camera;
@property (strong, nonatomic) UIButton *snapButton;
@property (strong, nonatomic) UIButton *switchButton;
@property (strong, nonatomic) UIButton *flashButton;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    // create camera vc
    self.camera = [[LLSimpleCamera alloc] initWithQuality:CameraQualityPhoto];
    
    // attach to the view and assign a delegate
    [self.camera attachToViewController:self withDelegate:self];
    
    // set the camera view frame to size and origin required for your app
    self.camera.view.frame = CGRectMake(0, 0, screenRect.size.width, screenRect.size.height);
    self.camera.cameraPosition = CameraPositionFront;
    
    // read: http://stackoverflow.com/questions/5427656/ios-uiimagepickercontroller-result-image-orientation-after-upload
    // you probably will want to set this to YES, if you are going view the image outside iOS.
    self.camera.fixOrientationAfterCapture = NO;
    // start the camera
    [self.camera start];
    [self switchButtonPressed:nil];

    
    // ----- camera buttons -------- //
    
    
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    bgImgView.image = [UIImage imageNamed:@"bg_abandon_photograph1"];
    [self.view addSubview:bgImgView];
    
    
    // snap button to capture image
    self.snapButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.snapButton.frame = CGRectMake(0, 0, 60.0f, 60.0f);
    self.snapButton.clipsToBounds = YES;
    self.snapButton.layer.cornerRadius = self.snapButton.width / 2.0f;
    self.snapButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.snapButton.layer.borderWidth = 2.0f;
    self.snapButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    self.snapButton.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.snapButton.layer.shouldRasterize = YES;
    [self.snapButton addTarget:self action:@selector(snapButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.snapButton];
    [self.view bringSubviewToFront:self.snapButton];
    
    // button to toggle flash
    self.flashButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.flashButton.frame = CGRectMake(0, 0, 16.0f + 20.0f, 24.0f + 20.0f);
    [self.flashButton setImage:[UIImage imageNamed:@"camera-flash-off.png"] forState:UIControlStateNormal];
    [self.flashButton setImage:[UIImage imageNamed:@"camera-flash-on.png"] forState:UIControlStateSelected];
    self.flashButton.imageEdgeInsets = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    [self.flashButton addTarget:self action:@selector(flashButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.flashButton];
    [self.view bringSubviewToFront:self.flashButton];
    
    // button to toggle camera positions
    self.switchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.switchButton.frame = CGRectMake(0, 0, 29.0f + 20.0f, 22.0f + 20.0f);
    [self.switchButton setImage:[UIImage imageNamed:@"camera-switch.png"] forState:UIControlStateNormal];
    self.switchButton.imageEdgeInsets = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    [self.switchButton addTarget:self action:@selector(switchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.switchButton];
    [self.view bringSubviewToFront:self.switchButton];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(15, screen_height-60-20, 60.0f, 60.0f);
    cancelButton.backgroundColor = [UIColor clearColor];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    [self.view bringSubviewToFront:cancelButton];
    
}

- (void)viewDidAppear:(BOOL)animated{

}
- (void)cancelButtonPressed{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    debugMethod();
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTakeBtn) name:@"重新拍照" object:nil];
   
}

- (void)refreshTakeBtn{
    [self.camera start];
}

/* camera buttons */
- (void)switchButtonPressed:(UIButton *)button {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {
        //无权限 做一个友好的提示
        UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请您设置允许APP访问您的相机\n设置>隐私>相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alart show];
        return ;
    } else {
       [self.camera togglePosition];
    }
}

- (void)flashButtonPressed:(UIButton *)button {
    
    CameraFlash flash = [self.camera toggleFlash];
    if(flash == CameraFlashOn) {
        self.flashButton.selected = YES;
    }
    else {
        self.flashButton.selected = NO;
    }
}

- (void)snapButtonPressed:(UIButton *)button {
    
    // capture the image, delegate will be executed
    [self.camera capture];
}

/* camera delegates */
- (void)cameraViewController:(LLSimpleCamera *)cameraVC didCaptureImage:(UIImage *)image {
    
    // we should stop the camera, since we don't need it anymore. We will open a new vc.
    [self.camera stop];

    CutPicViewController *avc = [[CutPicViewController alloc] initWithImage:image];
    avc.delegate = self;
    
    [self presentViewController:avc animated:YES completion:^{
        // TO DO
    }];
}

- (void)imageCropper:(CutPicViewController *)cropperViewController didFinished:(UIImage *)editedImage{
    if ([self.delegate respondsToSelector:@selector(homeViewController:didFinishPickingMediaWithImage:)]) {
        [self.delegate homeViewController:self didFinishPickingMediaWithImage:editedImage];
    }
}

- (void)cameraViewController:(LLSimpleCamera *)cameraVC didChangeDevice:(AVCaptureDevice *)device {
    
    // device changed, check if flash is available
    if(cameraVC.isFlashAvailable) {
        self.flashButton.hidden = NO;
    }
    else {
        self.flashButton.hidden = YES;
    }
    
    self.flashButton.selected = NO;
}

/* other lifecycle methods */
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.camera.view.frame = self.view.contentBounds;
    
    self.snapButton.center = self.view.contentCenter;
    self.snapButton.bottom = self.view.height - 15;
    
    self.flashButton.center = self.view.contentCenter;
    self.flashButton.top = 5.0f;
    
    self.switchButton.top = 5.0f;
    self.switchButton.right = self.view.width - 5.0f;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
