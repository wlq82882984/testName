//
//  MJCarChangeViewController.m
//  MingJia
//
//  Created by admin on 15/12/30.
//  Copyright © 2015年 BCKJ. All rights reserved.
//

#import "MJCarChangeViewController.h"
#import "MJMyOrderListViewController.h"
#import "MJCarOrderViewController.h"

@interface MJCarChangeViewController ()<UITextFieldDelegate>{
    UITextField *nametxt;
    UITextField *phonetxt;
    
    UITextField *recevenametxt;
    UITextField *recevephonetxt;
    UITextField *receveteletxt;
    UITextField *receveaddtxt;
    
    UITextField *pronametxt;
    UITextField *pronumtxt;
    UITextField *weighttxt;
    UITextField *bulktxt;
    UITextField *freighttxt;
    UITextField *remarktxt;
    
    UITextField *drivernametxt;
    UITextField *driverphonetxt;
    UITextField *platetxt;
    UITextField *cjtxt;
    UITextField *cardtxt;
    UITextField *enginetxt;
}

@property(nonatomic,strong)UIScrollView *mainScroll;

@end

@implementation MJCarChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"整车订单";
    _mainScroll = [[UIScrollView alloc]init];
    _mainScroll.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64);
    [self.view addSubview:_mainScroll];
    [self drawView];
    //键盘frame变化的时候会调用该通知的方法
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)requestMyInfo{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *urlStr = [NSString stringWithFormat:@"http://app.mjxypt.com/api/account/getcompany?companyid=%@",[[user objectForKey:@"UserLogin"] objectForKey:@"userId"]];
    
    [Request getRequestWithUrl:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] params:nil showTips:@"查询" tipsType:SVProgressHUDMaskTypeClear sucessBlock:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary *dict = responseObject;
        NSLog(@"%@",dict);
        nametxt.text = [dict objectForKey:@"CompanyName"];
        phonetxt.text = [dict objectForKey:@"Mobile"];
        
    } failBlock:^(NSError *error) {
        
    } successBackFailedBlock:^(id responseObject) {
        
    }];
}

//当键盘位置发生改变的时候会调用该方法
-(void)keyboardWillChangeFrame:(NSNotification *)notification{
    //键盘弹出的时间
    CGFloat duration=[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //键盘自己的frame
    CGRect keyBoardFrame=[notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //计算当前view的y方向的偏移量
    CGFloat transfomY=keyBoardFrame.origin.y-self.view.frame.size.height;
    //UIView动画
    [UIView animateWithDuration:duration animations:^{
//        self.view.transform=CGAffineTransformMakeTranslation(0, transfomY);
        if (transfomY >= 0) {
            _mainScroll.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64);
        }
        else{
            _mainScroll.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 -254);
        }
        //        NSLog(@"keyboard   %@",NSStringFromCGRect(keyBoardFrame));
        //        NSLog(@"view  %@",NSStringFromCGRect(self.view.frame));
        //        NSLog(@"table %@",NSStringFromCGRect(self.tableView.frame));
    }];
}

- (void)drawView{
    int offset = 0;
    
    UIView *view1 = [UIView createViewWithFrame:CGRectMake(0, offset, ScreenWidth, 30) backgroundColor:BACK_COLL_HEAD];
    [_mainScroll addSubview:view1];
    
    UILabel *viewlab1 = [UILabel createLabelWithFrame:CGRectMake(0, 0, ScreenWidth, 30) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"  发货人信息"];
    [view1 addSubview:viewlab1];
    
    UILabel *title01 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 30, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"*发货人:"];
    NSString *attrStr1= @"*发货人:";
    NSRange range1 = [attrStr1 rangeOfString:@"*"];
    NSMutableAttributedString *attRemain1 = [[NSMutableAttributedString alloc] initWithString:attrStr1];
    [attRemain1 setAttributes:@{NSForegroundColorAttributeName : [UIColor redColor],   NSFontAttributeName : SYSTEM_FONT_(16)} range:range1];
    title01.attributedText=attRemain1;
    [_mainScroll addSubview:title01];
    UILabel *title02 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 70, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"手机:"];
    [_mainScroll addSubview:title02];
    
    nametxt = [UITextField createTextFieldWithFrame:CGRectMake(90, offset +30, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft];
    nametxt.delegate = self;
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    if ([user objectForKey:@"UserLogin"]) {
//        nametxt.text = [[user objectForKey:@"UserLogin"] objectForKey:@""];
//    }
    [_mainScroll addSubview:nametxt];
    phonetxt = [UITextField createTextFieldWithFrame:CGRectMake(90, offset +70, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft];
    phonetxt.delegate = self;
    phonetxt.keyboardType = UIKeyboardTypeNumberPad;
    [_mainScroll addSubview:phonetxt];
    
    offset += 110;
    UIView *view2 = [UIView createViewWithFrame:CGRectMake(0, offset, ScreenWidth, 30) backgroundColor:BACK_COLL_HEAD];
    [_mainScroll addSubview:view2];
    
    UILabel *viewlab2 = [UILabel createLabelWithFrame:CGRectMake(0, 0, ScreenWidth, 30) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"  收货人信息"];
    [view2 addSubview:viewlab2];
    UILabel *title11 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 30, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"姓名:"];
    [_mainScroll addSubview:title11];
    UILabel *title12 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 70, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"手机:"];
    [_mainScroll addSubview:title12];
    UILabel *title13 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 110, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"电话:"];
    [_mainScroll addSubview:title13];
    UILabel *title14 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 150, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"地址:"];
    [_mainScroll addSubview:title14];
    
    recevenametxt = [UITextField createTextFieldWithFrame:CGRectMake(90, offset +30, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft];
    recevenametxt.delegate = self;
    [_mainScroll addSubview:recevenametxt];
    recevephonetxt = [UITextField createTextFieldWithFrame:CGRectMake(90, offset +70, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft];
    recevephonetxt.delegate = self;
    recevephonetxt.keyboardType = UIKeyboardTypeNumberPad;
    [_mainScroll addSubview:recevephonetxt];
    receveteletxt = [UITextField createTextFieldWithFrame:CGRectMake(90, offset +110, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft];
    receveteletxt.delegate = self;
    [_mainScroll addSubview:receveteletxt];
    receveaddtxt = [UITextField createTextFieldWithFrame:CGRectMake(90, offset +150, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft];
    receveaddtxt.delegate = self;
    [_mainScroll addSubview:receveaddtxt];
    
    offset += 190;
    UIView *view3 = [UIView createViewWithFrame:CGRectMake(0, offset, ScreenWidth, 30) backgroundColor:BACK_COLL_HEAD];
    [_mainScroll addSubview:view3];
    
    UILabel *viewlab3 = [UILabel createLabelWithFrame:CGRectMake(0, 0, ScreenWidth, 30) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"  货物信息"];
    [view3 addSubview:viewlab3];
    
    UILabel *title21 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 30, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@""];
    NSString *attrStr= @"*货名:";
    NSRange range = [attrStr rangeOfString:@"*"];
    NSMutableAttributedString *attRemain = [[NSMutableAttributedString alloc] initWithString:attrStr];
    [attRemain setAttributes:@{NSForegroundColorAttributeName : [UIColor redColor],   NSFontAttributeName : SYSTEM_FONT_(16)} range:range];
    title21.attributedText=attRemain;
    [_mainScroll addSubview:title21];
    
    UILabel *title22 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 70, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"件数:"];
    [_mainScroll addSubview:title22];
    UILabel *title23 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 110, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"重量(吨):"];
    [_mainScroll addSubview:title23];
    UILabel *title24 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 150, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"体积(方):"];
    [_mainScroll addSubview:title24];
    UILabel *title25 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 190, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"总运费:"];
    [_mainScroll addSubview:title25];
    UILabel *title26 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 230, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"备注:"];
    [_mainScroll addSubview:title26];
    
    pronametxt = [UITextField createTextFieldWithFrame:CGRectMake(90, offset +30, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft];
    pronametxt.delegate = self;
    [_mainScroll addSubview:pronametxt];
    pronumtxt = [UITextField createTextFieldWithFrame:CGRectMake(90, offset +70, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft];
    pronumtxt.delegate = self;
    pronumtxt.keyboardType = UIKeyboardTypeNumberPad;
    [_mainScroll addSubview:pronumtxt];
    weighttxt = [UITextField createTextFieldWithFrame:CGRectMake(90, offset +110, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft];
    weighttxt.delegate = self;
    weighttxt.keyboardType = UIKeyboardTypeDecimalPad;
    [_mainScroll addSubview:weighttxt];
    bulktxt = [UITextField createTextFieldWithFrame:CGRectMake(90, offset +150, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft];
    bulktxt.delegate = self;
    bulktxt.keyboardType = UIKeyboardTypeDecimalPad;
    [_mainScroll addSubview:bulktxt];
    freighttxt = [UITextField createTextFieldWithFrame:CGRectMake(90, offset +190, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft];
    freighttxt.delegate = self;
    freighttxt.keyboardType = UIKeyboardTypeDecimalPad;
    [_mainScroll addSubview:freighttxt];
    remarktxt = [UITextField createTextFieldWithFrame:CGRectMake(90, offset +230, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft];
    remarktxt.delegate = self;
    [_mainScroll addSubview:remarktxt];
    
    offset += 270;
    UIView *view4 = [UIView createViewWithFrame:CGRectMake(0, offset, ScreenWidth, 30) backgroundColor:BACK_COLL_HEAD];
    [_mainScroll addSubview:view4];
    
    UILabel *viewlab4 = [UILabel createLabelWithFrame:CGRectMake(0, 0, ScreenWidth, 30) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"  司机/专线信息"];
    [view4 addSubview:viewlab4];
    
    UILabel *title31 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 30, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"姓名:"];
    [_mainScroll addSubview:title31];
    UILabel *title32 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 70, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"手机:"];
    [_mainScroll addSubview:title32];
    UILabel *title33 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 110, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"车牌号:"];
    [_mainScroll addSubview:title33];
    UILabel *title34 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 150, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"车架号:"];
    [_mainScroll addSubview:title34];
    UILabel *title35 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 190, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"驾驶证号:"];
    [_mainScroll addSubview:title35];
    UILabel *title36 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 230, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"发动机号:"];
    [_mainScroll addSubview:title36];
    
    drivernametxt = [UITextField createTextFieldWithFrame:CGRectMake(90, offset +30, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft];
    drivernametxt.delegate = self;
    [_mainScroll addSubview:drivernametxt];
    driverphonetxt = [UITextField createTextFieldWithFrame:CGRectMake(90, offset +70, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft];
    driverphonetxt.delegate = self;
    [_mainScroll addSubview:driverphonetxt];
    platetxt = [UITextField createTextFieldWithFrame:CGRectMake(90, offset +110, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft];
    platetxt.delegate = self;
    [_mainScroll addSubview:platetxt];
    cjtxt = [UITextField createTextFieldWithFrame:CGRectMake(90, offset +150, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft];
    cjtxt.delegate = self;
    [_mainScroll addSubview:cjtxt];
    cardtxt = [UITextField createTextFieldWithFrame:CGRectMake(90, offset +190, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft];
    cardtxt.delegate = self;
    [_mainScroll addSubview:cardtxt];
    enginetxt = [UITextField createTextFieldWithFrame:CGRectMake(90, offset +230, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft];
    enginetxt.delegate = self;
    [_mainScroll addSubview:enginetxt];
    
    UIButton *saveBtn = [UIButton createButtonwithFrame:CGRectMake(20, CGRectGetMaxY(title36.frame) +15, ScreenWidth - 40, 40) backgroundColor:TABBAR_TEXT_COLOR_SEL image:[UIImage imageNamed:@""]];
    [saveBtn addTarget:self action:@selector(savedindan) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setTitle:@"保  存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    saveBtn.layer.cornerRadius = 5;
    [_mainScroll addSubview:saveBtn];
    
    _mainScroll.contentSize = CGSizeMake( ScreenWidth, CGRectGetMaxY(saveBtn.frame) +15);
    UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignFirst)];
    _mainScroll.userInteractionEnabled=YES;
    [_mainScroll addGestureRecognizer:Tap];
    
    if (_orderId) {
        [self requestGetOrderInfo];
    }
    else {
        [self requestMyInfo];
    }
}

//http://app.mjxypt.com/api/through/getbyid?id=
- (void)requestGetOrderInfo{
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *urlStr = [NSString stringWithFormat:@"http://app.mjxypt.com/api/through/getbyid?id=%@",_orderId];
        [Request getRequestWithUrl:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] params:nil showTips:@"查询" tipsType:SVProgressHUDMaskTypeClear sucessBlock:^(id responseObject) {
            [SVProgressHUD dismiss];
            NSDictionary *dict = responseObject;
            nametxt.text = [dict objectForKey:@"ShipperContact"];
            phonetxt.text = [dict objectForKey:@"ShipperTel"];
            recevenametxt.text = [dict objectForKey:@"ConsigneeContact"];
            recevephonetxt.text = [dict objectForKey:@"ConsigneeMobile"];
            receveteletxt.text = [dict objectForKey:@"ConsigneeTel"];
            receveaddtxt.text = [dict objectForKey:@"ArrivalAddr"];
            pronametxt.text = [dict objectForKey:@"CargoName"];
            pronumtxt.text = [NSString stringWithFormat:@"%i",[[dict objectForKey:@"Qty"] intValue]];
            weighttxt.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"Weight"]];
            bulktxt.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"Volume"]];
            freighttxt.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"Freight"]];
            remarktxt.text = [dict objectForKey:@"Remark"];
            drivernametxt.text = [dict objectForKey:@"Driver"];
            driverphonetxt.text = [dict objectForKey:@"DriverMobile"];
            platetxt.text = [dict objectForKey:@"LicensePlate"];
            cjtxt.text = [dict objectForKey:@"TrailerNo"];
            cardtxt.text = [dict objectForKey:@"DriverNo"];
            enginetxt.text = [dict objectForKey:@"EngineNo"];
            
        } failBlock:^(NSError *error) {
            
        } successBackFailedBlock:^(id responseObject) {
            
        }];
}

- (void)savedindan{
    if (nametxt.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写发货人姓名" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    if (phonetxt.text.length > 0) {
        if (![CheckMethod validateMobile:phonetxt.text]) {
            [SVProgressHUD showErrorWithStatus:@"请填写正确的手机格式" maskType:SVProgressHUDMaskTypeClear];
            return;
        }
    }
    if (recevephonetxt.text.length > 0) {
        if (![CheckMethod validateMobile:phonetxt.text]) {
            [SVProgressHUD showErrorWithStatus:@"请填写正确的手机格式" maskType:SVProgressHUDMaskTypeClear];
            return;
        }
    }
    if (pronametxt.text.length == 0) {
        [SVProgressHUD showSuccessWithStatus:@"请填货名" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    if([self isPureFloat:weighttxt.text] == NO)
    {
        UIAlertView *ale = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的重量:(别带汉字)" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [ale show];
        return ;
    }
    if([self isPureFloat:freighttxt.text] == NO)
    {
        UIAlertView *ale = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的数字:(别带汉字)" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [ale show];
        return ;
    }
    if([self isPureFloat:bulktxt.text] == NO)
    {
        UIAlertView *ale = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的体积:(别带汉字)" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [ale show];
        return ;
    }


    [self sendRequestRegist];
}

- (void)sendRequestRegist{
    
    NSString *urlStr = [Request getUrlStringWithRequestStr:@"through/create"];
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [dict setObject:[[user objectForKey:@"UserLogin"] objectForKey:@"userId"] forKey:@"CompanyId"];
    if (_orderId) {
        [dict setObject:_orderId forKey:@"ThroughOrderId"];
    }
    else{
        [dict setObject:@"00000000-0000-0000-0000-000000000000" forKey:@"ThroughOrderId"];
    }
    [dict setObject:nametxt.text forKey:@"ShipperContact"];
    [dict setObject:phonetxt.text forKey:@"ShipperTel"];
    [dict setObject:recevenametxt.text forKey:@"ConsigneeContact"];
    [dict setObject:recevephonetxt.text forKey:@"ConsigneeMobile"];
    [dict setObject:receveteletxt.text forKey:@"ConsigneeTel"];
    [dict setObject:receveaddtxt.text forKey:@"ArrivalAddr"];
    [dict setObject:pronametxt.text forKey:@"CargoName"];
    if (pronumtxt.text.length == 0) {
        [dict setObject:[NSNumber numberWithFloat:0.0] forKey:@"Qty"];
    }
    else {
        [dict setObject:pronumtxt.text forKey:@"Qty"];
    }
    if (weighttxt.text.length == 0) {
        [dict setObject:[NSNumber numberWithFloat:0.0] forKey:@"Weight"];
    }
    else {
        [dict setObject:weighttxt.text forKey:@"Weight"];
    }
    if (bulktxt.text.length == 0) {
        [dict setObject:[NSNumber numberWithFloat:0.0] forKey:@"Volume"];
    }
    else {
        [dict setObject:bulktxt.text forKey:@"Volume"];
    }
    if (freighttxt.text.length == 0) {
        [dict setObject:[NSNumber numberWithFloat:0.0] forKey:@"Freight"];
    }
    else {
        [dict setObject:freighttxt.text forKey:@"Freight"];
    }
    [dict setObject:remarktxt.text forKey:@"Remark"];
    [dict setObject:drivernametxt.text forKey:@"Driver"];
    [dict setObject:driverphonetxt.text forKey:@"DriverMobile"];
    [dict setObject:platetxt.text forKey:@"LicensePlate"];
    [dict setObject:cjtxt.text forKey:@"TrailerNo"];
    [dict setObject:cardtxt.text forKey:@"DriverNo"];
    [dict setObject:enginetxt.text forKey:@"EngineNo"];
    

    [Request postRequestWithUrl:urlStr params:dict showTips:@"正在申请...." tipsType:SVProgressHUDMaskTypeBlack sucessBlock:^(id responseObject) {
        NSDictionary *dict = responseObject;
        if ([[dict objectForKey:@"Code"]integerValue] == 0) {
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Message"]] maskType:SVProgressHUDMaskTypeClear];
        }
        if ([[dict objectForKey:@"Code"]integerValue] == 1) {
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Message"]] maskType:SVProgressHUDMaskTypeClear];
            MJCarOrderViewController *vc = [[MJCarOrderViewController alloc]init];
            [self.navigationController pushViewController:vc animated:NO];
        }
    } failBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"服务器未知异常"];
    } successBackFailedBlock:^(id responseObject) {
        
    }];
}

- (void)resignFirst{
    [nametxt resignFirstResponder];
    [phonetxt resignFirstResponder];
    [receveaddtxt resignFirstResponder];
    [recevenametxt resignFirstResponder];
    [recevephonetxt resignFirstResponder];
    [receveteletxt resignFirstResponder];
    [pronumtxt resignFirstResponder];
    [weighttxt resignFirstResponder];
    [pronametxt resignFirstResponder];
    [bulktxt resignFirstResponder];
    [freighttxt resignFirstResponder];
    [remarktxt resignFirstResponder];
    [drivernametxt resignFirstResponder];
    [driverphonetxt resignFirstResponder];
    [platetxt resignFirstResponder];
    [cjtxt resignFirstResponder];
    [cardtxt resignFirstResponder];
    [enginetxt resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
