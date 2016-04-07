//
//  MJLoginViewController.m
//  MingJia
//
//  Created by admin on 15/12/29.
//  Copyright © 2015年 BCKJ. All rights reserved.
//

#import "MJLoginViewController.h"
#import "MJRegistViewController.h"
#import <APService.h>
//#import "MainTabBarController.h"

@interface MJLoginViewController ()<UITextFieldDelegate>{
    UITextField *phoneTxt;
    UITextField *pwdTxt;
}

@end

@implementation MJLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.view.backgroundColor = WHITE_COLOR;
    [self drawView];
    UIButton *rightItem = [UIButton createButtonwithFrame:CGRectMake(0, 0, 40, 40) backgroundColor:[UIColor clearColor] image:[UIImage imageNamed:@""]];
    [rightItem setTitle:@"返回" forState:UIControlStateNormal];
    rightItem.selected = NO;
    [rightItem setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    rightItem.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightItem addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rightItem];
    [self.navigationItem setLeftBarButtonItem:right];
//    [self send];
//    [self sendRequestRegist];
}

- (void)dismissVC{
    [self dismissViewControllerAnimated:NO completion:^{
    }];
}

- (NSString *)gotdeviceId{    // 这个也不知道有什么用
    NSString *deviceID =[[[UIDevice currentDevice] identifierForVendor] UUIDString];//设备id
    return deviceID;
}

- (void)drawView{
    UILabel *titLab = [UILabel createLabelWithFrame:CGRectMake(0, 100, ScreenWidth, 20) backgroundColor:CLEAN_COLOR textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(20) textalignment:NSTextAlignmentCenter text:@"明佳信用平台"];
    [self.view addSubview:titLab];
    
    UIImageView *titImg = [UIImageView createImageViewWithFrame:CGRectMake(ScreenWidth/2-40, 10, 80, 80) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"logo"]];
    [self.view addSubview:titImg];
    
    UIView *bodyView = [UIView createViewWithFrame:CGRectMake(10, 150, ScreenWidth - 20, 80) backgroundColor:WHITE_COLOR];
    bodyView.layer.cornerRadius = 5;
    bodyView.layer.borderWidth = 1;
    bodyView.layer.borderColor = COLOR_line_HEAD.CGColor;
    [self.view addSubview:bodyView];
    
    UILabel *accountLab = [UILabel createLabelWithFrame:CGRectMake(0, 12, 50, 14) backgroundColor:CLEAN_COLOR textColor:[UIColor blackColor] font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"账号"];
    [bodyView addSubview:accountLab];
    
    UILabel *tapline = [UILabel createLabelWithFrame:CGRectMake(10, 40, ScreenWidth -40, 1) backgroundColor:COLOR_line_HEAD textColor:[UIColor blackColor] font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@""];
    [bodyView addSubview:tapline];
    
    UILabel *pwdLab = [UILabel createLabelWithFrame:CGRectMake(0, 52, 50, 14) backgroundColor:CLEAN_COLOR textColor:[UIColor blackColor] font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"密码"];
    [bodyView addSubview:pwdLab];
    
    phoneTxt = [UITextField createTextFieldWithFrame:CGRectMake(80, 12, ScreenWidth -110, 14) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"  手机号码" text:@"" textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft];
    phoneTxt.keyboardType = UIKeyboardTypeNumberPad;
    phoneTxt.delegate = self;
    [bodyView addSubview:phoneTxt];
    
    pwdTxt = [UITextField createTextFieldWithFrame:CGRectMake(80, 52, ScreenWidth -110, 14) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"  请输入密码" text:@"" textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft];
    pwdTxt.delegate = self;
    pwdTxt.secureTextEntry = YES;
    [bodyView addSubview:pwdTxt];
    
    [self drawBtn];
   
}

- (void)drawBtn{
    UIButton *logBtn = [UIButton createButtonwithFrame:CGRectMake(10, 280, ScreenWidth - 20, 40) backgroundColor:TABBAR_TEXT_COLOR_SEL conrnerRadius:5 borderWidth:0 borderColor:CLEAN_COLOR];
    [logBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [logBtn setTitle:@"登  录" forState:UIControlStateNormal];
    [logBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    logBtn.titleLabel.font = SYSTEM_FONT_(16);
    [self.view addSubview:logBtn];
    
    UIButton *registBtn = [UIButton createButtonwithFrame:CGRectMake(10, 340, ScreenWidth - 20, 40) backgroundColor:TABBAR_TEXT_COLOR_SEL conrnerRadius:5 borderWidth:0 borderColor:CLEAN_COLOR];
    [registBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [registBtn setTitle:@"注  册" forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(gotoregist) forControlEvents:UIControlEventTouchUpInside];
    registBtn.titleLabel.font = SYSTEM_FONT_(16);
    [self.view addSubview:registBtn];
    
}

- (void)login{
    if ([phoneTxt.text isEqualToString:@""]) {
        //        [ALToastView toastInView:self.view withText:@"手机号不可为空"];
        [SVProgressHUD showErrorWithStatus:@"手机号不可为空" maskType:SVProgressHUDMaskTypeClear];
        [phoneTxt becomeFirstResponder];
        return;
    }
    else if (![CheckMethod validateMobile:phoneTxt.text]){
        [SVProgressHUD showErrorWithStatus:@"手机号格式不正确" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    else {
    }
    
    if ([pwdTxt.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"密码不可为空" maskType:SVProgressHUDMaskTypeClear];
        [pwdTxt becomeFirstResponder];
        return;
    }
    else{
        [phoneTxt resignFirstResponder];
    }
    NSString *urlStr = [Request getUrlStringWithRequestStr:[NSString stringWithFormat:@"account/login?mobile=%@&pwd=%@&deviceId=%@",phoneTxt.text,[MD5 md5HexDigest:pwdTxt.text],[[NSUserDefaults standardUserDefaults]objectForKey:@"registID"]]];
    
    [Request getRequestWithUrl:urlStr params:nil showTips:@"正在登录" tipsType:SVProgressHUDMaskTypeClear sucessBlock:^(id responseObject) {
        NSDictionary *dict = responseObject;
        NSLog(@"%@",dict);
        if ([[dict objectForKey:@"Code"]integerValue] == 0) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Message"]] maskType:SVProgressHUDMaskTypeClear];
        }
        if ([[dict objectForKey:@"Code"]integerValue] == 1) {
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Message"]] maskType:SVProgressHUDMaskTypeClear];
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            if ([user objectForKey:@"UserLogin"]) {
                [user removeObjectForKey:@"UserLogin"];
            }
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:[dict objectForKey:@"Id"] forKey:@"userId"];
            [dic setObject:phoneTxt.text forKey:@"phoneNo"];
            
            [user setObject:dic forKey:@"UserLogin"];
            
            [self dismissViewControllerAnimated:NO completion:^{
                [self presentTab];
            }];
            [[UIApplication sharedApplication] registerForRemoteNotifications];    //开启推送  尝试
        }
        
    } failBlock:^(NSError *error) {
        
    } successBackFailedBlock:^(id responseObject) {
        
    }];
}

//http://mjweixin.reeease.com/Home/GetAreaJson
//[NSString stringWithFormat:@"http://app.mjxypt.com/api/line/get?sp=%@&sc=%@&sa=%@&ap=%@&ac=%@&aa=%@&cn=%@",@"江苏",@"无锡",@"",@"广东",@"广州",@"",@""]   务必加上中文转码stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding


- (void)send{
    NSString *urlStr = [NSString stringWithFormat:@"http://app.mjxypt.com/api/through/getbyid?id=%@",@"f37a0ae7-ef46-4720-931a-ef0f49c32817"];
//      A1FAE7F0-8A32-4D66-A572-5D2C3D82D8AC
    [Request getRequestWithUrl:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] params:nil showTips:@"查询" tipsType:SVProgressHUDMaskTypeClear sucessBlock:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary *dict = responseObject;
        NSLog(@"%@",dict);


    } failBlock:^(NSError *error) {
        
    } successBackFailedBlock:^(id responseObject) {
        
    }];

}

//order/create      [dict setObject:@"bc9e2332-a09a-46b1-9503-106610dbe22a" forKey:@"Inquiry"]; 多条线路以；隔开
- (void)sendRequestRegist{
    
    NSString *urlStr = [Request getUrlStringWithRequestStr:@"complaint/create"];
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:@"a1fae7f0-8a32-4d66-a572-5d2c3d82d8ac" forKey:@"CompanyId"];
    [dict setObject:@"sdds" forKey:@"ShipperContact"];
//    [dict setObject:@"18625432461" forKey:@"StartProvince"];
//    [dict setObject:@"18625432461" forKey:@"StartCity"];
//    [dict setObject:@"18625432461" forKey:@"StartAreas"];
//    [dict setObject:@"18625432461" forKey:@"StartAddr"];
    [dict setObject:@"18625432461" forKey:@"ConsigneeContact"];
    [dict setObject:@"18625432461" forKey:@"ConsigneeMobile"];
//    [dict setObject:@"18625432461" forKey:@"ArrivalProvince"];
//    [dict setObject:@"18625432461" forKey:@"ArrivalCity"];
//    [dict setObject:@"18625432461" forKey:@"ArrivalAreas"];
    [dict setObject:@"18625432461" forKey:@"ArrivalAddr"];
//    [dict setObject:@"18625432461" forKey:@"CargoType"];
    [dict setObject:@"18625432461" forKey:@"CargoName"];
//    [dict setObject:@"18625432461" forKey:@"Packages"];
    [dict setObject:@"1" forKey:@"Qty"];
    [dict setObject:@"18" forKey:@"Weight"];
    [dict setObject:@"18" forKey:@"Volume"];
    [dict setObject:@"1" forKey:@"Remark"];
//    [dict setObject:@"bc9e2332-a09a-46b1-9503-106610dbe22a" forKey:@"Inquiry"];
    
    [dict setObject:@"sdds" forKey:@"ShipperMobile"];
    [dict setObject:@"222" forKey:@"Freight"];
//    [dict setObject:@"sdds" forKey:@"DeliveryType"];
//    [dict setObject:@"2" forKey:@"ReceiptReq"];
//    [dict setObject:@"1" forKey:@"ReceiptQty"];
    
    [dict setObject:@"1" forKey:@"Driver"];
    [dict setObject:@"1" forKey:@"DriverMobile"];
    [dict setObject:@"1" forKey:@"LicensePlate"];
    [dict setObject:@"1" forKey:@"TrailerNo"];
    [dict setObject:@"1" forKey:@"DriverNo"];
    [dict setObject:@"1" forKey:@"EngineNo"];
    [dict setObject:@"18625432461" forKey:@"ConsigneeTel"];

    [Request postRequestWithUrl:urlStr params:dict showTips:@"正在申请...." tipsType:SVProgressHUDMaskTypeBlack sucessBlock:^(id responseObject) {
        NSDictionary *dict = responseObject;
        if ([[dict objectForKey:@"Code"]integerValue] == 1) {
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Message"]] maskType:SVProgressHUDMaskTypeClear];
        }
    } failBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"服务器未知异常"];
    } successBackFailedBlock:^(id responseObject) {
        
    }];
}



- (void)gotoregist{
    MJRegistViewController *vc = [[MJRegistViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [phoneTxt resignFirstResponder];
    [pwdTxt resignFirstResponder];
}

@end
