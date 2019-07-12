//
//  ShootViewController.m
//  Something
//
//  Created by 王亚振 on 2019/7/8.
//  Copyright © 2019 cn.krvision. All rights reserved.
//

#import "ShootViewController.h"
#import <AVFoundation/AVFoundation.h>
#define MAX_RECORD_TIME_LENGTH 10.0
#define MAX_TAP_FLAG_SPACE 0.5
@interface ShootViewController ()<AVCapturePhotoCaptureDelegate>

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureDeviceInput *videoInput;
@property (nonatomic, strong) AVCaptureVideoDataOutput *vedioOutput;
@property (nonatomic, strong) AVCapturePhotoOutput *photoOutput;
@property (nonatomic, strong) AVCaptureDevice *device;

@property (strong, nonatomic) UIView *timeLineView;
@property (strong, nonatomic) UIView *controlRoundView;

@property (assign, nonatomic) BOOL effectiveTap;
@property (assign, nonatomic) BOOL isRecordFlag;
@property (nonatomic, strong) dispatch_source_t recordTimer;
@property (nonatomic, strong) dispatch_source_t tapFlagTimer;

@property (strong, nonatomic) NSMutableArray <UIImageView *>*imageViewArray;
@property (assign, nonatomic) NSInteger imageTag;
@end

@implementation ShootViewController

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
//    if (self.session) {
//        [self.session stopRunning];
//    }
//    [KJCommonMethods hiddenStatus:NO];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
//    if (self.session) {
//        [self.session startRunning];
//    }
//    [KJCommonMethods hiddenStatus:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.imageViewArray = [NSMutableArray arrayWithCapacity:0];
//    [self commonDeviceComplete];
//    [self controlDeviceUI];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:RECT(200, 200, 3.9, 3.9)];
    imageView.image = IMAGE(@"1.jpg");
    [self.view addSubview:imageView];
}

#pragma mark --
#pragma mark -- PRIVATE 设备控制

- (void)commonDeviceComplete {
    self.session = [[AVCaptureSession alloc] init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    NSError *error;
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:self.device error:&error];
    self.vedioOutput = [[AVCaptureVideoDataOutput alloc] init];
    self.photoOutput = [[AVCapturePhotoOutput alloc] init];
    
    if (error) {
        NSLog(@"%@",error);
    }
    if ([self.session canAddInput:self.videoInput]) {
        [self.session addInput:self.videoInput];
    }
    if ([self.session canAddOutput:self.vedioOutput]) {
        [self.session addOutput:self.vedioOutput];
    }
    if ([self.session canAddOutput:self.photoOutput]) {
        [self.session addOutput:self.photoOutput];
    }
    // 初始化预览图层
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    self.previewLayer.frame = [UIScreen mainScreen].bounds;
    [self.view.layer addSublayer:self.previewLayer];
}

#pragma mark --
#pragma mark -- PRIVATE 灯光控制

- (void)openLight:(BOOL)open {
    // 更改这个设置的时候必须先锁定设备，修改完后再解锁，否则崩溃
    [self.device lockForConfiguration:nil];
    // 设置闪光灯为自动
    if (open) {
        [self.device setTorchMode:AVCaptureTorchModeOn];
    }else {
        [self.device setTorchMode:AVCaptureTorchModeOff];
    }
    [self.device unlockForConfiguration];
}

#pragma mark --
#pragma mark -- PRIVATE 定时器

- (void)startRecordTimer {
    [self cancelRecordTimer];
    self.isRecordFlag = YES;
    @weakify(self);
    __block NSInteger time = 0;
    dispatch_queue_t queue = dispatch_get_main_queue();
    self.recordTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(1 * NSEC_PER_SEC);
    dispatch_source_set_timer(self.recordTimer, start, interval, 0);
    dispatch_source_set_event_handler(self.recordTimer, ^{
        // do something
        time ++;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"录中。。。");
            if (time >= MAX_RECORD_TIME_LENGTH) {
                NSLog(@"时间到");
                [weak_self cancelRecordTimer];
                [weak_self doneRecordMethod:YES];
            }
        });
    });
    dispatch_resume(self.recordTimer);
}
- (void)cancelRecordTimer {
    if (_recordTimer) {
        dispatch_cancel(_recordTimer);
        _recordTimer = nil;
    }
}
- (void)startTapFlagTimer {
    [self cancelTapFlagTimer];
    @weakify(self);
    __block float time = 0;
    dispatch_queue_t queue = dispatch_get_main_queue();
    self.tapFlagTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(0.1 * NSEC_PER_SEC);
    dispatch_source_set_timer(self.tapFlagTimer, start, interval, 0);
    dispatch_source_set_event_handler(self.tapFlagTimer, ^{
        // do something
        time = time + 0.1;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"等待");
            if (time >= MAX_TAP_FLAG_SPACE) {
                // 结束判定，认定为录视频
                [weak_self cancelTapFlagTimer];
                [weak_self startRecordMethod];
                NSLog(@"等待结束 开始录像");
            }
        });
    });
    dispatch_resume(self.tapFlagTimer);
}
- (void)cancelTapFlagTimer {
    if (_tapFlagTimer) {
        dispatch_cancel(_tapFlagTimer);
        _tapFlagTimer = nil;
    }
}

#pragma mark --
#pragma mark -- PRIVATE 开始录制视频 照片

- (void)startRecordMethod {
    [self startRecordTimer];
}
- (void)doneRecordMethod:(BOOL)success {
    [self cancelRecordTimer];
    if (success) {
        
    }else {
        
    }
}
- (void)takePhoto {
    AVCaptureConnection *connection = [self.photoOutput connectionWithMediaType:AVMediaTypeVideo];
    if (!connection) {
        NSLog(@"失败");
        return;
    }
    //设置焦距
    [connection setVideoScaleAndCropFactor:1];
    
    [self.photoOutput capturePhotoWithSettings:[AVCapturePhotoSettings photoSettings] delegate:self];
}
- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo error:(NSError *)error  API_AVAILABLE(ios(11.0)) {
    if (error) return;
    if (self.imageTag >= self.imageViewArray.count) return;
    UIImage *image = [self imageFromPixelBuffer:photo.pixelBuffer];
    UIImageView *imageView = self.imageViewArray [self.imageTag];
    imageView.image = image;
    imageView.hidden = NO;
}
- (UIImage *)imageFromPixelBuffer:(CVPixelBufferRef)pixelBufferRef {
    CVImageBufferRef imageBuffer =  pixelBufferRef;

    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    size_t bufferSize = CVPixelBufferGetDataSize(imageBuffer);
    size_t bytesPerRow = CVPixelBufferGetBytesPerRowOfPlane(imageBuffer, 0);
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, baseAddress, bufferSize, NULL);
    
    CGImageRef cgImage = CGImageCreate(width, height, 8, 32, bytesPerRow, rgbColorSpace, kCGImageAlphaNoneSkipFirst | kCGBitmapByteOrderDefault, provider, NULL, true, kCGRenderingIntentDefault);
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(rgbColorSpace);
    
    CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
    return image;
}

#pragma mark --
#pragma mark -- PRIVATE UI 部分

- (void)controlDeviceUI {
    CGPoint point = POINT(SCREEN_WIDTH / 2.0, SCREEN_HEIGHT - 100);
    CGRect bounds = RECT(0, 0, 70, 70);
    
    self.controlRoundView = [[UIView alloc] init];
    self.controlRoundView.bounds = bounds;
    self.controlRoundView.center = point;
    self.controlRoundView.backgroundColor = [UIColor whiteColor];
    [self.controlRoundView borderWithRadius:bounds.size.width / 2.0
                                borderWidth:4
                                borderColor:@"ccc5b5"];
    [self.view addSubview:self.controlRoundView];
    
    self.timeLineView = [[UIView alloc] initWithFrame:RECT(0, 0, 0, 4)];
    self.timeLineView.backgroundColor = [UIColor colorWithHexString:@"ffba1b"];
    [self.view addSubview:self.timeLineView];
    
    CGFloat width = (SCREEN_WIDTH - 50) / 4.0;
    for (int i = 0; i < 4; i ++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = RECT(10 + (width + 10) * i, SCREEN_HEIGHT - 150 - width, width, width);
        imageView.backgroundColor = [UIColor blackColor];
        [imageView cornerWithRadius:5];
        [self.view addSubview:imageView];
        
        [self.imageViewArray addObject:imageView];
    }
}

#pragma mark --
#pragma mark -- INTERFACE

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self.view];
    if (CGRectContainsPoint(self.controlRoundView.frame, point)) {
        self.effectiveTap = YES;
        [self startTapFlagTimer];
        NSLog(@"开始计算按下时间");
    }else {
        self.effectiveTap = NO;
    }
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.effectiveTap) {
        if (self.isRecordFlag) {
            // 录像结束
            [self doneRecordMethod:YES];
            NSLog(@"录结束");
        }else {
            // 开始拍照
            [self takePhoto];
            NSLog(@"开始拍照");
        }
        [self cancelRecordTimer];
        [self cancelTapFlagTimer];
    }
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self cancelRecordTimer];
    [self cancelTapFlagTimer];
    self.isRecordFlag = NO;
    [self doneRecordMethod:NO];
    self.effectiveTap = NO;
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"移动");
}
- (void)dealloc {
    [self cancelRecordTimer];
    [self cancelTapFlagTimer];
}
@end
