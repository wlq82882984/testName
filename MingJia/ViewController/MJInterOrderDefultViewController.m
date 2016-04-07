//
//  MJInterOrderDefultViewController.m
//  MingJia
//
//  Created by admin on 15/12/30.
//  Copyright © 2015年 BCKJ. All rights reserved.
//   http://app.mjxtpt.com/api/order/proxy

#import "MJInterOrderDefultViewController.h"
#import "MJMyOrderListViewController.h"

@interface MJInterOrderDefultViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    UITextField *nametxt;
    UITextField *phonetxt;
    UITextField *begintxt;
    UITextField *addresstxt;
    
    UITextField *recevenametxt;
    UITextField *recevephonetxt;
    UITextField *endtxt;
    UITextField *receveaddtxt;
    
    UIButton        *paoBtn;
    UIButton        *zhBtn;
    UIImageView     *paoImg;
    UIImageView     *zhongImg;
    
    UITextField *pronametxt;
    UITextField *pronumtxt;
    UITextField *weighttxt;
    UITextField *bulktxt;
    
    UITextField *moneytxt;
    NSString    *delivertype;
    UITextField *receipttxt;
    UITextField *remarktxt;
    
    NSString     *sp;
    NSString     *sc;
    NSString     *sa;
    NSString     *ap;
    NSString     *ac;
    NSString     *aa;
    
    UIView      *pickView;
}

@property(nonatomic,strong)UIScrollView *mainScroll;
@property(nonatomic,strong)UIPickerView *dataPickV;

@end

@implementation MJInterOrderDefultViewController

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 2;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (row == 0) {
        return @"送货";
    }
    else {
        return @"自提";
    }
}

- (void)creatPick{
    _dataPickV = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
    _dataPickV.delegate = self;
    _dataPickV.dataSource = self;
    [pickView addSubview:_dataPickV];
}

- (void)hidepickV{
    [UIView animateWithDuration:.5 animations:^{
        pickView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 150);
    }];
}

- (void)showpickV{
    [UIView animateWithDuration:.5 animations:^{
        pickView.frame = CGRectMake(0, ScreenHeight-214, ScreenWidth, 150);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"网上办单";
    _mainScroll = [[UIScrollView alloc]init];
    _mainScroll.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64);
    [self.view addSubview:_mainScroll];
    pickView = [UIView createViewWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 60) backgroundColor:WHITE_COLOR];
    [self.view addSubview:pickView];
    [self creatPick];
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
        addresstxt.text = [dict objectForKey:@"Addr"];
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
    
//    发货人信息
    UILabel *viewlab1 = [UILabel createLabelWithFrame:CGRectMake(0, 0, ScreenWidth, 30) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"  发货人信息"];
    [view1 addSubview:viewlab1];
    
    UILabel *title01 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 30, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"发货人:"];
    [_mainScroll addSubview:title01];
    
    UILabel *title02 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 70, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"*手机:"];
    NSString *attrStr2= @"*手机:";
    NSRange range2 = [attrStr2 rangeOfString:@"*"];
    NSMutableAttributedString *attRemain2 = [[NSMutableAttributedString alloc] initWithString:attrStr2];
    [attRemain2 setAttributes:@{NSForegroundColorAttributeName : [UIColor redColor],   NSFontAttributeName : SYSTEM_FONT_(16)} range:range2];
    title02.attributedText=attRemain2;
    [_mainScroll addSubview:title02];
    
    UILabel *title03 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 110, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"起始地:"];
    [_mainScroll addSubview:title03];
    UILabel *title04 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 150, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"地址:"];
    [_mainScroll addSubview:title04];
    
    nametxt = [UITextField createTextFieldWithFrame:CGRectMake(90, offset +30, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft];
    nametxt.delegate = self;
    [_mainScroll addSubview:nametxt];
    phonetxt = [UITextField createTextFieldWithFrame:CGRectMake(90, offset +70, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft];
    phonetxt.delegate = self;
    phonetxt.keyboardType = UIKeyboardTypeNumberPad;
    [_mainScroll addSubview:phonetxt];
    begintxt = [UITextField createTextFieldWithFrame:CGRectMake(90, offset +110, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft];
    begintxt.enabled = NO;
    [_mainScroll addSubview:begintxt];
//    加个btn
    UIButton *btnChoose = [UIButton createButtonwithFrame:begintxt.frame backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@""]];
    btnChoose.tag = 101;
    [btnChoose addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    [_mainScroll addSubview:btnChoose];
    addresstxt = [UITextField createTextFieldWithFrame:CGRectMake(90, offset +150, ScreenWidth - 120, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"如需提货请输入详细地址" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft];
    addresstxt.delegate = self;
    [_mainScroll addSubview:addresstxt];
    
    //   收货人信息
    offset += 190;
    UIView *view2 = [UIView createViewWithFrame:CGRectMake(0, offset, ScreenWidth, 30) backgroundColor:BACK_COLL_HEAD];
    [_mainScroll addSubview:view2];
    
    UILabel *viewlab2 = [UILabel createLabelWithFrame:CGRectMake(0, 0, ScreenWidth, 30) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"  收货人信息"];
    [view2 addSubview:viewlab2];
    
    UILabel *title11 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 30, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"收货人:"];
    [_mainScroll addSubview:title11];
    
    UILabel *title12 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 70, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"*手机:"];
    NSString *attrStr1= @"*手机:";
    NSRange range1 = [attrStr1 rangeOfString:@"*"];
    NSMutableAttributedString *attRemain1 = [[NSMutableAttributedString alloc] initWithString:attrStr1];
    [attRemain1 setAttributes:@{NSForegroundColorAttributeName : [UIColor redColor],   NSFontAttributeName : SYSTEM_FONT_(16)} range:range1];
    title12.attributedText=attRemain1;
    [_mainScroll addSubview:title12];
    
    UILabel *title13 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 110, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"到达地:"];
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
    endtxt = [UITextField createTextFieldWithFrame:CGRectMake(90, offset +110, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft];
    endtxt.enabled = NO;
    [_mainScroll addSubview:endtxt];
    //    加个btn
    UIButton *btn2Choose = [UIButton createButtonwithFrame:begintxt.frame backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@""]];
    btn2Choose.tag = 102;
    [btn2Choose addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    [_mainScroll addSubview:btn2Choose];
    receveaddtxt = [UITextField createTextFieldWithFrame:CGRectMake(90, offset +150, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"请输入详细地址" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft];
    receveaddtxt.delegate = self;
    [_mainScroll addSubview:receveaddtxt];
    
//    货物信息
    offset += 190;
    UIView *view3 = [UIView createViewWithFrame:CGRectMake(0, offset, ScreenWidth, 30) backgroundColor:BACK_COLL_HEAD];
    [_mainScroll addSubview:view3];
    
    UILabel *viewlab3 = [UILabel createLabelWithFrame:CGRectMake(0, 0, ScreenWidth, 30) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"  货物信息"];
    [view3 addSubview:viewlab3];
    
    UILabel *title21 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 30, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"*名称:"];
    title21.attributedText = [self changeAttr:title21.text];
    [_mainScroll addSubview:title21];
    UILabel *title22 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 70, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"*件数:"];
    title22.attributedText = [self changeAttr:title22.text];
    [_mainScroll addSubview:title22];
    UILabel *title23 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 110, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"*重量(吨):"];
    title23.attributedText = [self changeAttr:title23.text];
    [_mainScroll addSubview:title23];
    UILabel *title24 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 150, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"*体积(方):"];
    title24.attributedText = [self changeAttr:title24.text];
    [_mainScroll addSubview:title24];
    
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
    
//    订单信息
    offset += 190;
    UIView *view4 = [UIView createViewWithFrame:CGRectMake(0, offset, ScreenWidth, 30) backgroundColor:BACK_COLL_HEAD];
    [_mainScroll addSubview:view4];
    
    UILabel *viewlab4 = [UILabel createLabelWithFrame:CGRectMake(0, 0, ScreenWidth, 30) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"  订单信息"];
    [view4 addSubview:viewlab4];
    
    UILabel *title31 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 30, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"*运费:"];
    title31.attributedText = [self changeAttr:title31.text];
    [_mainScroll addSubview:title31];
    UILabel *title32 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 70, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"交接方式:"];
    [_mainScroll addSubview:title32];
    UILabel *title33 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 110, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"回单:"];
    [_mainScroll addSubview:title33];
    UILabel *title34 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 150, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"备注:"];
    [_mainScroll addSubview:title34];
    
    moneytxt = [UITextField createTextFieldWithFrame:CGRectMake(90, offset +30, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft];
    moneytxt.delegate = self;
    moneytxt.keyboardType = UIKeyboardTypeDecimalPad;
    [_mainScroll addSubview:moneytxt];
    
    paoImg = [UIImageView createImageViewWithFrame:CGRectMake(105, offset +80, 15, 15) backgroundColor:TABBAR_TEXT_COLOR_SEL image:[UIImage imageNamed:@""]];
    paoImg.layer.borderColor = [UIColor lightGrayColor].CGColor;
    paoImg.layer.borderWidth = 1;
    paoImg.layer.cornerRadius = 7.5;
    [_mainScroll addSubview:paoImg];
    zhongImg = [UIImageView createImageViewWithFrame:CGRectMake(205, offset +80, 15, 15) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@""]];
    zhongImg.layer.borderColor = [UIColor lightGrayColor].CGColor;
    zhongImg.layer.cornerRadius = 7.5;
    zhongImg.layer.borderWidth = 1;
    [_mainScroll addSubview:zhongImg];
    
    paoBtn = [UIButton createButtonwithFrame:CGRectMake(120, offset +80, 50, 20) backgroundColor:CLEAN_COLOR conrnerRadius:4 borderWidth:0 borderColor:CLEAN_COLOR];
    [paoBtn setTitle:@"自提" forState:UIControlStateNormal];
    paoBtn.titleLabel.font = SYSTEM_FONT_(14);
    [paoBtn addTarget:self action:@selector(protype:) forControlEvents:UIControlEventTouchUpInside];
    [paoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_mainScroll addSubview:paoBtn];
    zhBtn = [UIButton createButtonwithFrame:CGRectMake(220, offset +80, 50, 20) backgroundColor:CLEAN_COLOR conrnerRadius:4 borderWidth:0 borderColor:CLEAN_COLOR];
    [zhBtn setTitle:@"送货" forState:UIControlStateNormal];
    [zhBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [zhBtn addTarget:self action:@selector(protype:) forControlEvents:UIControlEventTouchUpInside];
    zhBtn.titleLabel.font = SYSTEM_FONT_(14);
    [_mainScroll addSubview:zhBtn];
    delivertype = @"自提";
    
//    delivertype = [UIButton createButtonwithFrame:CGRectMake(90, offset +70, 150, 40) backgroundColor:BACK_COLL_HEAD image:[UIImage imageNamed:@""]];
//    delivertype.tag = 201;
//    [delivertype addTarget:self action:@selector(chooseType:) forControlEvents:UIControlEventTouchUpInside];
//    delivertype.layer.cornerRadius = 5;
//    [delivertype setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [delivertype setTitle:@"送货" forState:UIControlStateNormal];
//    [_mainScroll addSubview:btn2Choose];
//    [_mainScroll addSubview:delivertype];
    
    receipttxt = [UITextField createTextFieldWithFrame:CGRectMake(90, offset +110, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"请输入回单份数" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft];
    receipttxt.delegate = self;
    receipttxt.keyboardType = UIKeyboardTypeNumberPad;
    [_mainScroll addSubview:receipttxt];
    remarktxt = [UITextField createTextFieldWithFrame:CGRectMake(90, offset +150, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft];
    remarktxt.delegate = self;
    [_mainScroll addSubview:remarktxt];
    
    UIButton *saveBtn = [UIButton createButtonwithFrame:CGRectMake(20, CGRectGetMaxY(title34.frame) +15, ScreenWidth - 40, 40) backgroundColor:TABBAR_TEXT_COLOR_SEL image:[UIImage imageNamed:@""]];
    [saveBtn setTitle:@"保  存" forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveline) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    saveBtn.layer.cornerRadius = 5;
    [_mainScroll addSubview:saveBtn];
    
    _mainScroll.contentSize = CGSizeMake( ScreenWidth, CGRectGetMaxY(saveBtn.frame) +15);
    UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignFirst)];
    _mainScroll.userInteractionEnabled=YES;
    [_mainScroll addGestureRecognizer:Tap];
    
    if (_lineId) {
        [self requestGetOrderInfo];
    }
    if (_orderId) {
        [self requestInfo];
    }
    else{
        [self requestMyInfo];
    }
}

-(void)protype:(id)sender{
    UIButton *btn = (UIButton *)sender;
    if ([btn isEqual:paoBtn]) {
        [paoImg setBackgroundColor:TABBAR_TEXT_COLOR_SEL];
        [zhongImg setBackgroundColor:CLEAN_COLOR];
        delivertype = @"自提";
    }
    if ([btn isEqual:zhBtn]) {
        [zhongImg setBackgroundColor:TABBAR_TEXT_COLOR_SEL];
        [paoImg setBackgroundColor:CLEAN_COLOR];
        delivertype = @"送货";
    }
}

- (void)requestInfo{  // 查询信息的界面信息装填
    NSString *urlStr = [NSString stringWithFormat:@"http://app.mjxypt.com/api/order/getbyid?id=%@",_orderId];
    [Request getRequestWithUrl:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] params:nil showTips:@"查询" tipsType:SVProgressHUDMaskTypeClear sucessBlock:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary *dict = responseObject;
        nametxt.text = [dict safeObjectForKey:@"ShipperContact"];
        phonetxt.text = [dict safeObjectForKey:@"ShipperMobile"];
        
        NSString *ss = @"";
        if (![[UtilString getNoNilString:[dict objectForKey:@"StartAreas"]] isEqualToString:@"不限"] && ![[UtilString getNoNilString:[dict objectForKey:@"StartAreas"]] isEqualToString:@""]) {
            ss = [NSString stringWithFormat:@"-%@",[UtilString getNoNilString:[_placeDic objectForKey:@"StartAreas"]]];
        }
        
        NSString *ss2 = @"";
        
        sp = [UtilString getNoNilString:[dict objectForKey:@"StartProvince"]];
        sc = [UtilString getNoNilString:[dict objectForKey:@"StartCity"]];
        sa = [UtilString getNoNilString:[dict objectForKey:@"StartAreas"]];
        ap = [UtilString getNoNilString:[dict objectForKey:@"ArrivalProvince"]];
        ac = [UtilString getNoNilString:[dict objectForKey:@"ArrivalCity"]];
        aa = [UtilString getNoNilString:[dict objectForKey:@"ArrivalAreas"]];
        
        if (![[UtilString getNoNilString:[dict objectForKey:@"StartCity"]] isEqualToString:[UtilString getNoNilString:[dict objectForKey:@"StartProvince"]]] && ![[UtilString getNoNilString:[dict objectForKey:@"StartCity"]] isEqualToString:@""]) {
            ss2 = [NSString stringWithFormat:@"-%@",[UtilString getNoNilString:[dict objectForKey:@"StartCity"]]];
        }
        begintxt.text = [NSString stringWithFormat:@"%@%@%@",[UtilString getNoNilString:[dict objectForKey:@"StartProvince"]],ss2,ss];
        
        NSString *dd = @"";
        if (![[UtilString getNoNilString:[dict objectForKey:@"ArrivalAreas"]] isEqualToString:@"不限"] && ![[UtilString getNoNilString:[dict objectForKey:@"ArrivalAreas"]] isEqualToString:@""]) {
            dd = [NSString stringWithFormat:@"-%@",[UtilString getNoNilString:[dict objectForKey:@"ArrivalAreas"]]];
        }
        NSString *dd2 = @"";
        if (![[UtilString getNoNilString:[dict objectForKey:@"ArrivalProvince"]] isEqualToString:[UtilString getNoNilString:[dict objectForKey:@"ArrivalCity"]]] && ![[UtilString getNoNilString:[dict objectForKey:@"ArrivalCity"]] isEqualToString:@""]) {
            dd2 = [NSString stringWithFormat:@"-%@",[UtilString getNoNilString:[dict objectForKey:@"ArrivalCity"]]];
        }
        endtxt.text = [NSString stringWithFormat:@"%@%@%@",[UtilString getNoNilString:[dict objectForKey:@"ArrivalProvince"]],dd2,dd];
        addresstxt.text = [dict safeObjectForKey:@"StartAddr"];
        recevenametxt.text = [dict safeObjectForKey:@"ConsigneeContact"];
        recevephonetxt.text = [dict safeObjectForKey:@"ConsigneeMobile"];
        receveaddtxt.text = [dict safeObjectForKey:@"ArrivalAddr"];
        pronametxt.text = [dict safeObjectForKey:@"CargoName"];
        pronumtxt.text = [dict safeObjectForKey:@"Qty"];
        weighttxt.text = [dict safeObjectForKey:@"Weight"];
        bulktxt.text = [dict safeObjectForKey:@"Volume"];
        
        moneytxt.text = [dict safeObjectForKey:@"Freight"];
        if ([[dict safeObjectForKey:@"DeliveryType"] isEqualToString:@"自提"]) {
            delivertype = @"自提";
            paoImg.backgroundColor = TABBAR_TEXT_COLOR_SEL;
            zhongImg.backgroundColor = CLEAN_COLOR;
        }
        else{
            delivertype = @"送货";
            paoImg.backgroundColor = CLEAN_COLOR;
            zhongImg.backgroundColor = TABBAR_TEXT_COLOR_SEL;
        }
    
        receipttxt.text = [dict safeObjectForKey:@"ReceiptQty"];
        remarktxt.text = [dict safeObjectForKey:@"Remark"];

    } failBlock:^(NSError *error) {
        
    } successBackFailedBlock:^(id responseObject) {
        
    }];
}

- (void)requestGetOrderInfo{
    NSString *ss = @"";
    if (![[UtilString getNoNilString:[_placeDic objectForKey:@"StartAreas"]] isEqualToString:@"不限"] && ![[UtilString getNoNilString:[_placeDic objectForKey:@"StartAreas"]] isEqualToString:@""]) {
        ss = [NSString stringWithFormat:@"-%@",[UtilString getNoNilString:[_placeDic objectForKey:@"StartAreas"]]];
    }
    
    NSString *ss2 = @"";
    if (![[UtilString getNoNilString:[_placeDic objectForKey:@"StartCity"]] isEqualToString:[UtilString getNoNilString:[_placeDic objectForKey:@"StartProvince"]]] && ![[UtilString getNoNilString:[_placeDic objectForKey:@"StartCity"]] isEqualToString:@""]) {
        ss2 = [NSString stringWithFormat:@"-%@",[UtilString getNoNilString:[_placeDic objectForKey:@"StartCity"]]];
    }
    begintxt.text = [NSString stringWithFormat:@"%@%@%@",[UtilString getNoNilString:[_placeDic objectForKey:@"StartProvince"]],ss2,ss];
    
    NSString *dd = @"";
    if (![[UtilString getNoNilString:[_placeDic objectForKey:@"ArrivalAreas"]] isEqualToString:@"不限"] && ![[UtilString getNoNilString:[_placeDic objectForKey:@"ArrivalAreas"]] isEqualToString:@""]) {
        dd = [NSString stringWithFormat:@"-%@",[UtilString getNoNilString:[_placeDic objectForKey:@"ArrivalAreas"]]];
    }
    NSString *dd2 = @"";
    if (![[UtilString getNoNilString:[_placeDic objectForKey:@"ArrivalProvince"]] isEqualToString:[UtilString getNoNilString:[_placeDic objectForKey:@"ArrivalCity"]]] && ![[UtilString getNoNilString:[_placeDic objectForKey:@"ArrivalCity"]] isEqualToString:@""]) {
        dd2 = [NSString stringWithFormat:@"-%@",[UtilString getNoNilString:[_placeDic objectForKey:@"ArrivalCity"]]];
    }
    endtxt.text = [NSString stringWithFormat:@"%@%@%@",[UtilString getNoNilString:[_placeDic objectForKey:@"ArrivalProvince"]],dd2,dd];  
//    begintxt.text = [NSString stringWithFormat:@"%@ %@ %@",[_placeDic objectForKey:@"StartProvince"],[_placeDic objectForKey:@"StartCity"],[_placeDic objectForKey:@"StartAreas"]];
//    endtxt.text = [NSString stringWithFormat:@"%@ %@ %@",[_placeDic objectForKey:@"ArrivalProvince"],[_placeDic objectForKey:@"ArrivalCity"],[_placeDic objectForKey:@"ArrivalAreas"]];
    
}

- (void)saveline{
    if (phonetxt.text.length == 0) {
        [SVProgressHUD showSuccessWithStatus:@"请填写手机号" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    else if (![CheckMethod validateMobile:phonetxt.text]){
        [SVProgressHUD showSuccessWithStatus:@"请填写正确的手机号" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    
    if (recevephonetxt.text.length == 0) {
        [SVProgressHUD showSuccessWithStatus:@"请填写手机号" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    else if (![CheckMethod validateMobile:recevephonetxt.text]){
        [SVProgressHUD showSuccessWithStatus:@"请填写正确的手机号" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    
    if (pronametxt.text.length == 0) {
        [SVProgressHUD showSuccessWithStatus:@"请填写名称" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    if (pronumtxt.text.length == 0) {
        [SVProgressHUD showSuccessWithStatus:@"请填写件数" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    if (weighttxt.text.length == 0) {
        [SVProgressHUD showSuccessWithStatus:@"请填写重量" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    if (bulktxt.text.length == 0) {
        [SVProgressHUD showSuccessWithStatus:@"请填写体积" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    if (moneytxt.text.length == 0) {
        [SVProgressHUD showSuccessWithStatus:@"请填写运费" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    if([self isPureFloat:weighttxt.text] == NO){
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的重量(别带汉字)" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        
        [alert show];
        return ;
    }
    if([self isPureFloat:bulktxt.text] == NO){
        
        UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的体积(别带汉字)" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        
        [alert1 show];
        return ;
    }
    if([self isPureFloat:moneytxt.text] == NO){
        
        UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的数字(别带汉字)" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        
        [alert1 show];
        return ;
    }



    [self requestpostorder];
}

- (void)requestpostorder{
    NSString *urlStr = [Request getUrlStringWithRequestStr:@"order/proxy"];
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    if (!_orderId) {
        [dict setObject:@"00000000-0000-0000-0000-000000000000" forKey:@"OrderId"];
    }
    else if (_orderId){
        [dict setObject:_orderId forKey:@"OrderId"];
    }
    
    [dict setObject:[UtilString getNoNilString:_lineId] forKey:@"Inquiry"];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [dict setObject:[[user objectForKey:@"UserLogin"] objectForKey:@"userId"] forKey:@"CompanyId"];
    [dict setObject:nametxt.text forKey:@"ShipperContact"];
    [dict setObject:phonetxt.text forKey:@"ShipperMobile"];
    if (_placeDic) {
        [dict setObject:[_placeDic objectForKey:@"StartProvince"] forKey:@"StartProvince"];
        [dict setObject:[_placeDic objectForKey:@"StartCity"] forKey:@"StartCity"];
        [dict setObject:[_placeDic objectForKey:@"StartAreas"] forKey:@"StartAreas"];
        
        [dict setObject:[_placeDic objectForKey:@"ArrivalProvince"] forKey:@"ArrivalProvince"];
        [dict setObject:[_placeDic objectForKey:@"ArrivalCity"] forKey:@"ArrivalCity"];
        [dict setObject:[_placeDic objectForKey:@"ArrivalAreas"] forKey:@"ArrivalAreas"];
    }
    else {
        [dict setObject:[UtilString getNoNilString:sp] forKey:@"StartProvince"];
        [dict setObject:[UtilString getNoNilString:sc] forKey:@"StartCity"];
        [dict setObject:[UtilString getNoNilString:sa] forKey:@"StartAreas"];
        
        [dict setObject:[UtilString getNoNilString:ap] forKey:@"ArrivalProvince"];
        [dict setObject:[UtilString getNoNilString:ac] forKey:@"ArrivalCity"];
        [dict setObject:[UtilString getNoNilString:aa] forKey:@"ArrivalAreas"];
    }
    
    [dict setObject:addresstxt.text forKey:@"StartAddr"];
    [dict setObject:recevenametxt.text forKey:@"ConsigneeContact"];
    [dict setObject:recevephonetxt.text forKey:@"ConsigneeMobile"];

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
    if (moneytxt.text.length == 0) {
        [dict setObject:[NSNumber numberWithFloat:0.0] forKey:@"Freight"];
    }
    else {
        [dict setObject:moneytxt.text forKey:@"Freight"];
    }
    
    [dict setObject:delivertype forKey:@"DeliveryType"];
    [dict setObject:@"" forKey:@"ReceiptReq"];
    [dict setObject:receipttxt.text forKey:@"ReceiptQty"];
    [dict setObject:remarktxt.text forKey:@"Remark"];
    
    [Request postRequestWithUrl:urlStr params:dict showTips:@"正在保存...." tipsType:SVProgressHUDMaskTypeBlack sucessBlock:^(id responseObject) {
        NSDictionary *dict = responseObject;
        if ([[dict objectForKey:@"Code"]integerValue] == 0) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Message"]] maskType:SVProgressHUDMaskTypeClear];
        }
        if ([[dict objectForKey:@"Code"]integerValue] == 1) {
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Message"]] maskType:SVProgressHUDMaskTypeClear];
            MJMyOrderListViewController *vc = [[MJMyOrderListViewController alloc]init];
             [self.navigationController pushViewController:vc animated:NO];
        }
    } failBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"服务器未知异常"];
    } successBackFailedBlock:^(id responseObject) {
        
    }];
}

- (NSMutableAttributedString *)changeAttr:(NSString *)str{
    NSString *attrStr= str;
    NSRange range = [attrStr rangeOfString:@"*"];
    NSMutableAttributedString *attRemain = [[NSMutableAttributedString alloc] initWithString:attrStr];
    [attRemain setAttributes:@{NSForegroundColorAttributeName : [UIColor redColor],   NSFontAttributeName : SYSTEM_FONT_(16)} range:range];
    return attRemain;
}

- (void)resignFirst{
    [self hidepickV];
    [nametxt resignFirstResponder];
    [phonetxt resignFirstResponder];
    [receveaddtxt resignFirstResponder];
    [recevenametxt resignFirstResponder];
    [recevephonetxt resignFirstResponder];
    [pronumtxt resignFirstResponder];
    [weighttxt resignFirstResponder];
    [pronametxt resignFirstResponder];
    [bulktxt resignFirstResponder];
    [addresstxt resignFirstResponder];
    [remarktxt resignFirstResponder];
    [endtxt resignFirstResponder];
    [receveaddtxt resignFirstResponder];
    [moneytxt resignFirstResponder];
    [receipttxt resignFirstResponder];
    [remarktxt resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self hidepickV];
    return YES;
}

- (void)chooseAction:(id)sender{

}

- (void)chooseType:(id)sender{
    [self showpickV];
}

@end
