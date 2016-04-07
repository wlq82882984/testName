//
//  MJChangePwdViewController.m
//  MingJia
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 BCKJ. All rights reserved.
//
//   string mobile, string opwd, string pwd

#import "MJChangePwdViewController.h"

@interface MJChangePwdViewController ()<UITextFieldDelegate>{
    UITextField *Opwdtxt;
    UITextField *pwd1txt;
    UITextField *pwd2txt;
    NSString    *phone;
}

@end

@implementation MJChangePwdViewController

- (void)requestMyInfo{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *urlStr = [NSString stringWithFormat:@"http://app.mjxypt.com/api/account/getcompany?companyid=%@",[[user objectForKey:@"UserLogin"] objectForKey:@"userId"]];
    
    [Request getRequestWithUrl:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] params:nil showTips:@"查询" tipsType:SVProgressHUDMaskTypeClear sucessBlock:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary *dict = responseObject;
        NSLog(@"%@",dict);
        phone = [dict objectForKey:@"Mobile"];
        [self sendRequestRegist];
    } failBlock:^(NSError *error) {
        
    } successBackFailedBlock:^(id responseObject) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    [self drawView];
}

- (void)drawView{
    Opwdtxt = [UITextField createTextFieldWithFrame:CGRectMake(20, 12, ScreenWidth -50, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleRoundedRect placeholder:@"  请输入旧密码" text:@"" textColor:Color_font_dark font:SYSTEM_FONT_(15) textalignment:NSTextAlignmentLeft];
    Opwdtxt.secureTextEntry = YES;
    Opwdtxt.delegate = self;
    [self.view addSubview:Opwdtxt];
    
    pwd1txt = [UITextField createTextFieldWithFrame:CGRectMake(20, 62, ScreenWidth -50, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleRoundedRect placeholder:@"  请输入新密码" text:@"" textColor:Color_font_dark font:SYSTEM_FONT_(15) textalignment:NSTextAlignmentLeft];
    pwd1txt.secureTextEntry = YES;
    pwd1txt.delegate = self;
    [self.view addSubview:pwd1txt];
    
    pwd2txt = [UITextField createTextFieldWithFrame:CGRectMake(20, 112, ScreenWidth -50, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleRoundedRect placeholder:@"  请再次输入密码" text:@"" textColor:Color_font_dark font:SYSTEM_FONT_(15) textalignment:NSTextAlignmentLeft];
    pwd2txt.delegate = self;
    pwd2txt.secureTextEntry = YES;
    [self.view addSubview:pwd2txt];
    
    UIButton *registBtn = [UIButton createButtonwithFrame:CGRectMake(20, 162, ScreenWidth - 50, 40) backgroundColor:TABBAR_TEXT_COLOR_SEL conrnerRadius:5 borderWidth:0 borderColor:CLEAN_COLOR];
    [registBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [registBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(check) forControlEvents:UIControlEventTouchUpInside];
    registBtn.titleLabel.font = SYSTEM_FONT_(16);
    [self.view addSubview:registBtn];
}

- (void)check{
    if ([Opwdtxt.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"旧密码不可为空" maskType:SVProgressHUDMaskTypeClear];
        [Opwdtxt becomeFirstResponder];
        return;
    }
    
    if ([pwd1txt.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"密码不可为空" maskType:SVProgressHUDMaskTypeClear];
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
        [self requestMyInfo];
    }
}

- (void)sendRequestRegist{
    NSString *urlStr = [NSString stringWithFormat:@"http://app.mjxypt.com/api/account/ResetPwd?mobile=%@&opwd=%@&pwd=%@",phone,[MD5 md5HexDigest:Opwdtxt.text],[MD5 md5HexDigest:pwd2txt.text]];
    
    [Request getRequestWithUrl:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] params:nil showTips:@"正在保存" tipsType:SVProgressHUDMaskTypeClear sucessBlock:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary *dict = responseObject;
        NSLog(@"%@",dict);
        
        if ([[dict objectForKey:@"Code"]integerValue] == 0) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Message"]] maskType:SVProgressHUDMaskTypeClear];
        }
        if ([[dict objectForKey:@"Code"]integerValue] == 1) {
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Message"]] maskType:SVProgressHUDMaskTypeClear];
            [self.navigationController popViewControllerAnimated:NO];
        }
        
    } failBlock:^(NSError *error) {
        
    } successBackFailedBlock:^(id responseObject) {
        
    }];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [Opwdtxt resignFirstResponder];
    [pwd1txt resignFirstResponder];
    [pwd2txt resignFirstResponder];
}

@end
