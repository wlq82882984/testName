//
//  MJRegistViewController.m
//  MingJia
//
//  Created by admin on 15/12/29.
//  Copyright © 2015年 BCKJ. All rights reserved.
//   ResetPwd   改密码
//   string mobile, string opwd, string pwd

#import "MJRegistViewController.h"

@interface MJRegistViewController ()<UITextFieldDelegate>{
    UITextField *phonetxt;
    UITextField *nametxt;
    UITextField *pwd1txt;
    UITextField *pwd2txt;
}

@end

@implementation MJRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注 册";
    [self drawView];
}

- (void)drawView{
    phonetxt = [UITextField createTextFieldWithFrame:CGRectMake(20, 12, ScreenWidth -50, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleRoundedRect placeholder:@"  请输入手机号码" text:@"" textColor:Color_font_dark font:SYSTEM_FONT_(15) textalignment:NSTextAlignmentLeft];
    phonetxt.keyboardType = UIKeyboardTypeNumberPad;
    phonetxt.delegate = self;
    [self.view addSubview:phonetxt];
    
    nametxt = [UITextField createTextFieldWithFrame:CGRectMake(20, 62, ScreenWidth -50, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleRoundedRect placeholder:@"  请输入用户姓名" text:@"" textColor:Color_font_dark font:SYSTEM_FONT_(15) textalignment:NSTextAlignmentLeft];
    nametxt.delegate = self;
    [self.view addSubview:nametxt];
    
    pwd1txt = [UITextField createTextFieldWithFrame:CGRectMake(20, 112, ScreenWidth -50, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleRoundedRect placeholder:@"  请输入密码" text:@"" textColor:Color_font_dark font:SYSTEM_FONT_(15) textalignment:NSTextAlignmentLeft];
    pwd1txt.secureTextEntry = YES;
    pwd1txt.delegate = self;
    [self.view addSubview:pwd1txt];
    
    pwd2txt = [UITextField createTextFieldWithFrame:CGRectMake(20, 162, ScreenWidth -50, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleRoundedRect placeholder:@"  请再次输入密码" text:@"" textColor:Color_font_dark font:SYSTEM_FONT_(15) textalignment:NSTextAlignmentLeft];
    pwd2txt.delegate = self;
    pwd2txt.secureTextEntry = YES;
    [self.view addSubview:pwd2txt];
    
    UIButton *registBtn = [UIButton createButtonwithFrame:CGRectMake(20, 222, ScreenWidth - 50, 40) backgroundColor:TABBAR_TEXT_COLOR_SEL conrnerRadius:5 borderWidth:0 borderColor:CLEAN_COLOR];
    [registBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [registBtn setTitle:@"确认注册" forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(check) forControlEvents:UIControlEventTouchUpInside];
    registBtn.titleLabel.font = SYSTEM_FONT_(16);
    [self.view addSubview:registBtn];
}

- (void)check{
    if ([phonetxt.text isEqualToString:@""]) {
//        [ALToastView toastInView:self.view withText:@"手机号不可为空"];
        [SVProgressHUD showErrorWithStatus:@"手机号不可为空" maskType:SVProgressHUDMaskTypeClear];
        [phonetxt becomeFirstResponder];
        return;
    }
    else if (![CheckMethod validateMobile:phonetxt.text]){
        [SVProgressHUD showErrorWithStatus:@"手机号格式不正确" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    else {
    }
    
    if ([nametxt.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"用户名不可为空" maskType:SVProgressHUDMaskTypeClear];
        [nametxt becomeFirstResponder];
        return;
    }
    else{
    }
    
    if ([pwd1txt.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"密码不可为空" maskType:SVProgressHUDMaskTypeClear];
        [pwd1txt becomeFirstResponder];
        return;
    }
    else if (pwd1txt.text.length < 6){
        [SVProgressHUD showErrorWithStatus:@"密码至少6位" maskType:SVProgressHUDMaskTypeClear];
        [pwd1txt becomeFirstResponder];
        return;
    }
    else if ([pwd2txt.text isEqualToString:@""]){
        [SVProgressHUD showErrorWithStatus:@"请再次输入密码" maskType:SVProgressHUDMaskTypeClear];
        [pwd2txt becomeFirstResponder];
        return;
    }
    else if (![pwd2txt.text isEqualToString:pwd1txt.text]){
        [SVProgressHUD showErrorWithStatus:@"两次输入不一致" maskType:SVProgressHUDMaskTypeClear];
        [pwd2txt becomeFirstResponder];
        return;
    }
    else{
        [self sendRequestRegist];
    }
    
}

- (void)sendRequestRegist{
    NSString *urlStr = [Request getUrlStringWithRequestStr:@"account/register"];
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:phonetxt.text forKey:@"Mobile"];
    [dict setObject:nametxt.text forKey:@"Name"];
    [dict setObject:[MD5 md5HexDigest:pwd2txt.text] forKey:@"Pwd"];
    
    [Request postRequestWithUrl:urlStr params:dict showTips:@"正在申请...." tipsType:SVProgressHUDMaskTypeBlack sucessBlock:^(id responseObject) {
        NSDictionary *dict = responseObject;
        if ([[dict objectForKey:@"Code"]integerValue] == 0) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Message"]] maskType:SVProgressHUDMaskTypeClear];
        }
        if ([[dict objectForKey:@"Code"]integerValue] == 1) {
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Message"]] maskType:SVProgressHUDMaskTypeClear];
            [self.navigationController popViewControllerAnimated:NO];
            [[UIApplication sharedApplication] registerForRemoteNotifications];    //开启推送  尝试
        }
    
    } failBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"服务器未知异常"];
    } successBackFailedBlock:^(id responseObject) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [phonetxt resignFirstResponder];
    [nametxt resignFirstResponder];
    [pwd1txt resignFirstResponder];
    [pwd2txt resignFirstResponder];
}

@end
