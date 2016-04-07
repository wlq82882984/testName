//
//  ClubBARscanViewController.m
//  YWYiphone
//
//  Created by liufengting on 14/10/29.
//  Copyright (c) 2014年 刘锋婷. All rights reserved.
//

#import "SweepYardVCtr.h"
#import "MJSearchResultViewController.h"
//#import "Macros.h"

@interface SweepYardVCtr ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation SweepYardVCtr

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"二维码/条码";
    self.view.backgroundColor = [UIColor blackColor];
    
    UIButton *rightItem = [UIButton createButtonwithFrame:CGRectMake(0, 0, 40, 40) backgroundColor:[UIColor clearColor] image:[UIImage imageNamed:@""]];
    [rightItem setTitle:@"相册" forState:UIControlStateNormal];
    rightItem.selected = NO;
    [rightItem setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    rightItem.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightItem addTarget:self action:@selector(pressButton3:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rightItem];
    [self.navigationItem setRightBarButtonItem:right];

    
//    UIButton * scanButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [scanButton setTitle:@"重试" forState:UIControlStateNormal];
//    scanButton.frame = CGRectMake(100, 420, 120, 40);
//    [scanButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:scanButton];
    
    UIImageView * imageView = [UIImageView createImageViewWithFrame:CGRectMake(40,SizeScale(80), ScreenWidth - 80, ScreenWidth -80) backgroundColor:[UIColor clearColor] image:[UIImage imageNamed:@""] conrnerRadius:0.0f borderWidth:1.0f borderColor:TABBAR_TEXT_COLOR_NOR];
    [self.view addSubview:imageView];
    
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(SizeScale(10) , ScreenWidth -80+SizeScale(80), ScreenWidth-SizeScale(20) , SizeScale(40))];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.textAlignment = NSTextAlignmentCenter;
    labIntroudction.textColor = TABBAR_TEXT_COLOR_NOR;
    labIntroudction.font = SYSTEM_FONT_(12);
    labIntroudction.text=@"将二维码/条码放入框内，即可自动扫描";
    [self.view addSubview:labIntroudction];
    
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(40, SizeScale(80), ScreenWidth - 80, 2)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
}

-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(50,  SizeScale(80)+2*num, ScreenWidth - 80, 2);
        if (2*num >= (ScreenWidth - 81)) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(50,  SizeScale(80)+2*num, ScreenWidth - 80, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [self setupCamera];
}

//开始捕获
- (void)setupCamera
{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    _session.sessionPreset = AVCaptureSessionPreset1280x720;
//    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    else{
        [SVProgressHUD showErrorWithStatus:@"请打开应用的相机设置，否则不能进行扫码" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
//    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
//    _output.metadataObjectTypes =@[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];

    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame = CGRectMake(40,SizeScale(80), ScreenWidth - 80, ScreenWidth -80);
    [self.view.layer insertSublayer:self.preview atIndex:0];
        
    // Start
    [_session startRunning];
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString *stringValue;
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    [_session stopRunning];
    [timer invalidate];
    [self didGetUserId:stringValue];
}
-(void)didGetUserId:(NSString *)userid
{
    if ([self isNumbleText:userid]) {
        MJSearchResultViewController *friendInfo = [[MJSearchResultViewController alloc]init];
        friendInfo.orderId = userid;
        [self.navigationController pushViewController:friendInfo animated:YES];
    }
    else{
        [UIAlertView showAlertViewWithTitle:@"提示"
                                    message:[NSString stringWithFormat:@"无法识别:'%@'\n是否用Safari打开？。",userid]
                          cancelButtonTitle:@"取消"
                          otherButtonTitles:@[@"打开"]
                                  onDismiss:^(int buttonIndex) {
                                      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:userid]];
                                  }
                                   onCancel:^{
                                       
                                       [self backAction];
                                   }];
    }
}

- (void)backAction{
}

//是否是纯数字
-(BOOL)isNumbleText:(NSString *)str{
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"]invertedSet];
    
    NSString *filtered = [[str componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
    
    BOOL canChange = [str isEqualToString:filtered];
    return canChange;
    
    //    NSString * regex = @"(/^[0-9]*$/)";
    //    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    //    return [pred evaluateWithObject:str];
}

- (void)pressButton3:(UIButton *)button
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:^{}];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    [self dismissViewControllerAnimated:YES completion:^{
        [self getURLWithImage:image];
    }
     ];
}

-(void)getURLWithImage:(UIImage *)img{
    
    UIImage *loadImage= img;
    CGImageRef imageToDecode = loadImage.CGImage;
    
    ZXLuminanceSource *source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:imageToDecode];
    ZXBinaryBitmap *bitmap = [ZXBinaryBitmap binaryBitmapWithBinarizer:[ZXHybridBinarizer binarizerWithSource:source]];
    
    NSError *error = nil;
    
    ZXDecodeHints *hints = [ZXDecodeHints hints];
    
    ZXMultiFormatReader *reader = [ZXMultiFormatReader reader];
    ZXResult *result = [reader decode:bitmap
                                hints:hints
                                error:&error];

    if (result) { // 有结果的时候
        // The coded result as a string. The raw data can be accessed with
        // result.rawBytes and result.length.
        NSString *contents = result.text;
        if ([self isNumbleText:contents]) {
            MJSearchResultViewController *friendInfo = [[MJSearchResultViewController alloc]init];
            friendInfo.orderId = contents;
            [self.navigationController pushViewController:friendInfo animated:YES];
        }
        else{
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"不符合订单扫描格式" message:contents delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alter show];
        }
//        NSLog(@"contents =%@",contents);
    } else {
        UIAlertView *alter1 = [[UIAlertView alloc] initWithTitle:@"解析失败" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alter1 show];
    }
}

@end
