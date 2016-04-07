//
//  MJBJViewController.m
//  MingJia
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 BCKJ. All rights reserved.
//

#import "MJBJViewController.h"

@interface MJBJViewController (){
    UILabel     *orderidLab;
    UILabel     *dateLab;
    
    UILabel     *phoneLab;
    UILabel     *addrLab;
    UIButton    *teleBtn;
    
    UILabel     *pronameLab;
    UILabel     *title33;
    UILabel     *weightLab;
    UILabel     *bulkLab;
    UILabel     *remarkLab;
    
    NSString    *teleNo;
    UITextField *moneyText;
    UITextField *timeText;
}
@property(nonatomic,strong)UIScrollView *mainScroll;
@end

@implementation MJBJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"报价确认";
    _mainScroll = [[UIScrollView alloc]init];
    _mainScroll.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64);
    _mainScroll.backgroundColor = WHITE_COLOR;
    [self.view addSubview:_mainScroll];
    UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignFirst)];
    _mainScroll.userInteractionEnabled=YES;
    [_mainScroll addGestureRecognizer:Tap];
    [self drawView];
    self.view.backgroundColor = BACK_COLL_HEAD;
    //键盘frame变化的时候会调用该通知的方法
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
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
        if (transfomY>=0) {
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

- (void)resignFirst{
    [moneyText resignFirstResponder];
    [timeText resignFirstResponder];
}

- (void)drawView{
    int offset = 0;
        
    UIView *view1 = [UIView createViewWithFrame:CGRectMake(0, offset, ScreenWidth, 30) backgroundColor:BACK_COLL_HEAD];
    [_mainScroll addSubview:view1];
        
    //    订单信息
    UILabel *viewlab1 = [UILabel createLabelWithFrame:CGRectMake(0, 0, ScreenWidth, 30) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"  订单信息"];
    [view1 addSubview:viewlab1];
        
    UILabel *title01 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 30, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"订单编号:"];
    [_mainScroll addSubview:title01];
    UILabel *title02 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 70, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"下单日期:"];
    [_mainScroll addSubview:title02];
        
    orderidLab = [UILabel createLabelWithFrame:CGRectMake(90, offset + 30, 150, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"283562376453254"];
    [_mainScroll addSubview:orderidLab];
    dateLab = [UILabel createLabelWithFrame:CGRectMake(90, offset + 70, 200, 40)backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"2017-101-1-1"];
    [_mainScroll addSubview:dateLab];
        
        //   发货人信息
    offset += 110;
    UIView *view2 = [UIView createViewWithFrame:CGRectMake(0, offset, ScreenWidth, 30) backgroundColor:BACK_COLL_HEAD];
    [_mainScroll addSubview:view2];
        
    UILabel *viewlab2 = [UILabel createLabelWithFrame:CGRectMake(0, 0, ScreenWidth, 30) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"  发货人信息"];
        [view2 addSubview:viewlab2];
        
    phoneLab = [UILabel createLabelWithFrame:CGRectMake(10, offset + 30, 200, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"手机号"];
        [_mainScroll addSubview:phoneLab];
    
    teleBtn = [UIButton createButtonwithFrame:CGRectMake(200, offset + 40, 80, 20) backgroundColor:TABBAR_TEXT_COLOR_SEL image:[UIImage imageNamed:@""]];
    [teleBtn setTitle:@"联系他" forState:UIControlStateNormal];
    teleBtn.layer.cornerRadius = 4;
    teleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [teleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_mainScroll addSubview:teleBtn];
    
    
    addrLab = [UILabel createLabelWithFrame:CGRectMake(10, offset + 70, 200, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@""];
    [_mainScroll addSubview:addrLab];

        //    货物信息
    offset += 110;
    UIView *view4 = [UIView createViewWithFrame:CGRectMake(0, offset, ScreenWidth, 30) backgroundColor:BACK_COLL_HEAD];
    [_mainScroll addSubview:view4];
        
    UILabel *viewlab4 = [UILabel createLabelWithFrame:CGRectMake(0, 0, ScreenWidth, 30) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"  货物信息"];
    [view4 addSubview:viewlab4];
        
    UILabel *title31 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 30, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"货名:"];
    [_mainScroll addSubview:title31];
    title33 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 70, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"重量:"];
    [_mainScroll addSubview:title33];
    UILabel *title310 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 110, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"备注:"];
    [_mainScroll addSubview:title310];
        
    pronameLab = [UILabel createLabelWithFrame:CGRectMake(90, offset + 30, 200, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"木箱 "];
    [_mainScroll addSubview:pronameLab];
    weightLab = [UILabel createLabelWithFrame:CGRectMake(90, offset + 70, 200, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@""];
    [_mainScroll addSubview:weightLab];
    remarkLab = [UILabel createLabelWithFrame:CGRectMake(90, offset + 110, ScreenWidth - 110, 50) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"啊；圣诞节卡到绿卡河北师大厉害八十多裸婚时代将返回 "];
    remarkLab.numberOfLines = 2;
    [_mainScroll addSubview:remarkLab];

    //    报价信息
    offset += 150;
    UIView *view5 = [UIView createViewWithFrame:CGRectMake(0, offset, ScreenWidth, 30) backgroundColor:BACK_COLL_HEAD];
    [_mainScroll addSubview:view5];
    
    UILabel *viewlab5 = [UILabel createLabelWithFrame:CGRectMake(0, 0, ScreenWidth, 30) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"  货物信息"];
    [view5 addSubview:viewlab5];

    UILabel *title41 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 30, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"报价金额:"];
    [_mainScroll addSubview:title41];
    UILabel *title42 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 70, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"保障时效:"];
    [_mainScroll addSubview:title42];
    
    moneyText = [UITextField createTextFieldWithFrame:CGRectMake(90, offset +30, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"请输入报价金额" text:@"" textColor:BLACK_COLOR font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft];
    moneyText.keyboardType = UIKeyboardTypeEmailAddress;
    [_mainScroll addSubview:moneyText];
    
    timeText = [UITextField createTextFieldWithFrame:CGRectMake(90, offset +70, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"请输入保障时效" text:@"" textColor:BLACK_COLOR font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft];
    [_mainScroll addSubview:timeText];
    
    UIButton *btn = [UIButton createButtonwithFrame:CGRectMake(10, CGRectGetMaxY(title42.frame)+30, ScreenWidth - 20, 40) backgroundColor:TABBAR_TEXT_COLOR_SEL image:[UIImage imageNamed:@""]];
    [btn addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    btn.titleLabel.font = SYSTEM_FONT_(16);
    btn.layer.cornerRadius = 5;
    [_mainScroll addSubview:btn];
    
    _mainScroll.contentSize = CGSizeMake(ScreenWidth, CGRectGetMaxY(btn.frame)+10);
    [self requestOrderDetail];
}

//  http://app.mjxypt.com/api/order/OfferFreight?companyId=&orderId=&freight=&timeliness=
- (void)okAction{
    if (moneyText.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入报价金额" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    if (timeText.text.length == 0) {
        [SVProgressHUD showSuccessWithStatus:@"请输入保障时效" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *urlStr = [NSString stringWithFormat:@"http://app.mjxypt.com/api/order/OfferFreight?companyId=%@&orderId=%@&freight=%@&timeliness=%@",[[user objectForKey:@"UserLogin"] objectForKey:@"userId"],_orderId,moneyText.text,timeText.text];

    [Request getRequestWithUrl:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] params:nil showTips:@"确认报价" tipsType:SVProgressHUDMaskTypeClear sucessBlock:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary *dict = responseObject;
        NSLog(@"%@",dict);
        if ([[dict objectForKey:@"Code"]integerValue] == 0) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Message"]] maskType:SVProgressHUDMaskTypeClear];
        }
        if ([[dict objectForKey:@"Code"]integerValue] == 1) {
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Message"]] maskType:SVProgressHUDMaskTypeClear];
        }
        
        NSArray *arrvc = self.navigationController.viewControllers;
        int i = (int)arrvc.count;
        [self.navigationController popToViewController:arrvc[i-2] animated:NO];
        
    } failBlock:^(NSError *error) {
        
    } successBackFailedBlock:^(id responseObject) {
        
    }];
}

-(void)teleAction{
    [self tele:teleNo];
}

- (void)requestOrderDetail{
    NSString *urlStr = [NSString stringWithFormat:@"http://app.mjxypt.com/api/order/getbyid?id=%@",_orderId];
    
    [Request getRequestWithUrl:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] params:nil showTips:@"获取详情" tipsType:SVProgressHUDMaskTypeClear sucessBlock:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary *dict = responseObject;
        NSLog(@"%@",dict);
        orderidLab.text = [dict objectForKey:@"OrderNo"];
        dateLab.text = [dict objectForKey:@"CreateTime"];
        phoneLab.text = [NSString stringWithFormat:@"%@  %@",[dict objectForKey:@"ShipperContact"],[dict objectForKey:@"ShipperMobile"]];
        pronameLab.text = [dict objectForKey:@"CargoName"];
        teleNo = [dict objectForKey:@"ShipperMobile"];
        [teleBtn addTarget:self action:@selector(teleAction) forControlEvents:UIControlEventTouchUpInside];
        
        addrLab.text = [NSString stringWithFormat:@"%@ %@ %@ %@",[dict objectForKey:@"StartProvince"],[dict objectForKey:@"StartCity"],[dict objectForKey:@"StartAreas"],[dict objectForKey:@"StartAddr"]];
        if ([[dict objectForKey:@"CargoType"]isEqualToString:@"泡货"]) {
            title33.text = @"体积:";
            weightLab.text = [NSString stringWithFormat:@"%@ 方",[dict objectForKey:@"Volume"]];
        }
        if ([[dict objectForKey:@"CargoType"]isEqualToString:@"重货"]) {
            title33.text = @"重量:";
            weightLab.text = [NSString stringWithFormat:@"%@ 吨",[dict objectForKey:@"Weight"]];
        }
        remarkLab.text = [dict objectForKey:@"Remark"];
        
    } failBlock:^(NSError *error) {
        
    } successBackFailedBlock:^(id responseObject) {
        
    }];
}

@end
