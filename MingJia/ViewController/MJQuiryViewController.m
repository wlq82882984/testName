//
//  MJQuiryViewController.m
//  MingJia
//
//  Created by admin on 15/12/31.
//  Copyright © 2015年 BCKJ. All rights reserved.
//  http://app.mjxypt.com/api/order/create
//    http://app.mjxypt.com/api/order/getbyid?id=

#import "MJQuiryViewController.h"
#import "MJMyOrderListViewController.h"
#import "ModelArea.h"

@interface MJQuiryViewController ()<UITextFieldDelegate>{
    UILabel         *beginLab;
    UIButton        *beginBtn;
    UITextField     *beginaddtxt;
    UILabel         *endLab;
    UIButton        *endBtn;
    UITextField     *endaddtxt;
    UITextField     *nametxt;
    UITextField     *phonetxt;
    UITextField     *pronametxt;
    UIButton        *paoBtn;
    UIButton        *zhBtn;
    NSString        *proType;
    UITextField     *weighttxt;
    UITextField     *remarktxt;
    
    UIImageView     *paoImg;
    UIImageView     *zhongImg;
    
    UILabel         *title09;
    
    UIView            *areaView;
    UIScrollView      *scrollV;
    UILabel           *titleLab;
    UIButton          *provinceBtn;
    UIButton          *cityBtn;
    UIButton          *areaBtn;
    int               chooseType;   // 判断是起始还是结束地
    
    NSString          *startProvince;
    NSString          *startCity;
    NSString          *startArea;
    NSString            *startProvinceid;
    NSString            *startCityid;
    NSString            *startAreaid;
    
    NSString            *arrivalProvinceid;
    NSString            *arrivalCityid;
    NSString            *arrivalAreaid;
    NSString          *arrivalProvince;
    NSString          *arrivalCity;
    NSString          *arrivalArea;
    
    NSMutableArray      *dicPro;
    NSMutableArray      *dicCity;
    NSMutableArray      *cityarr;
    NSMutableArray      *dicArea;
    NSMutableArray      *areaarr;
    int                 seleProIndex;
    int                 seleCityIndex;
    int                 seleAreaIndex;
}

@property(nonatomic,strong)UIScrollView *mainScroll;

@end

@implementation MJQuiryViewController

//- (void)requestgetArea{
//    NSString *urlStr = @"http://mjweixin.reeease.com/Home/GetAreaJson";
//    [Request getRequestWithUrl:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] params:nil showTips:@"查询" tipsType:SVProgressHUDMaskTypeClear sucessBlock:^(id responseObject) {
//        [SVProgressHUD dismiss];
//        NSDictionary *dict = [responseObject objectForKey:@"addressData"];
//        _dicAreas = [dict mutableCopy];
//        [self provinceAction];
//    } failBlock:^(NSError *error) {
//        
//    } successBackFailedBlock:^(id responseObject) {
//        
//    }];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary *diccc = [NSMutableDictionary dictionary];
    diccc = [PlistDao readKeyDictionary:@"AreaPlist.plist" key:@"areaPlist"];
    _dicAreas = [[diccc objectForKey:@"myArea"] mutableCopy];
    
    self.view.backgroundColor = BACK_COLL_HEAD;
    self.title = @"一键询价";
    _mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
    _mainScroll.backgroundColor = WHITE_COLOR;
    UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignFirst)];
    _mainScroll.userInteractionEnabled=YES;
    [_mainScroll addGestureRecognizer:Tap];
    [self.view addSubview:_mainScroll];
    [self drawView];
    [self drawArea];
    
    //键盘frame变化的时候会调用该通知的方法
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    proType = @"泡货";
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

- (void)drawArea{
    areaView = [UIView createViewWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight - 64) backgroundColor:TABBAR_TEXT_COLOR_SEL];
    [self.view addSubview:areaView];
    
    titleLab = [UILabel createLabelWithFrame:CGRectMake(0, 0, ScreenWidth, 50) backgroundColor:CLEAN_COLOR textColor:WHITE_COLOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentCenter text:@"全国"];
    [areaView addSubview:titleLab];
    
    provinceBtn = [UIButton createButtonwithFrame:CGRectMake(0, 0, 60, 50) backgroundColor:TABBAR_TEXT_COLOR_SEL image:[UIImage imageNamed:@""]];
    [provinceBtn setTitle:@"返回" forState:UIControlStateNormal];
    [provinceBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    provinceBtn.titleLabel.font = SYSTEM_FONT_(14);
    [provinceBtn addTarget:self action:@selector(provinceAction) forControlEvents:UIControlEventTouchUpInside];
    [areaView addSubview:provinceBtn];
    
    cityBtn = [UIButton createButtonwithFrame:CGRectMake(0, 0, 60, 50) backgroundColor:TABBAR_TEXT_COLOR_SEL image:[UIImage imageNamed:@""]];
    [cityBtn setTitle:@"返回" forState:UIControlStateNormal];
    [cityBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    cityBtn.titleLabel.font = SYSTEM_FONT_(14);
    [cityBtn addTarget:self action:@selector(cityAction) forControlEvents:UIControlEventTouchUpInside];
    [areaView addSubview:cityBtn];
    
    areaBtn = [UIButton createButtonwithFrame:CGRectMake(0, 0, 60, 50) backgroundColor:TABBAR_TEXT_COLOR_SEL image:[UIImage imageNamed:@""]];
    [areaBtn setTitle:@"返回" forState:UIControlStateNormal];
    [areaBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [areaBtn addTarget:self action:@selector(hideAreaV) forControlEvents:UIControlEventTouchUpInside];
    areaBtn.titleLabel.font = SYSTEM_FONT_(14);
    [areaView addSubview:areaBtn];
    
    // scrol装省市区的按钮
    scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, ScreenWidth, ScreenHeight - 114)];
    scrollV.backgroundColor = WHITE_COLOR;
    [areaView addSubview:scrollV];
    [self isPureFloat:@""];
}

- (void)showAreaV:(id)sender{
    UIButton *btn = (UIButton *)sender;
    [areaView bringSubviewToFront:areaBtn];
    titleLab.text = @"全国";
    if (btn.tag == 1001) {
        chooseType = 1;
        [dicPro removeAllObjects];
        [dicCity removeAllObjects];
        [dicArea removeAllObjects];
        [self provinceAction];
    }
    else if (btn.tag == 1002){
        chooseType = 2;
        [dicPro removeAllObjects];
        [dicCity removeAllObjects];
        [dicArea removeAllObjects];
        [self provinceAction];
    }
    [UIView animateWithDuration:0 animations:^{
        areaView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64);
        [self.view bringSubviewToFront:areaView];
    }];
}

- (void)hideAreaV{
    NSString *ss = @"";
    if (![[UtilString getNoNilString:startArea] isEqualToString:@"不限"] && ![[UtilString getNoNilString:startArea] isEqualToString:@""]) {
        ss = [NSString stringWithFormat:@"-%@",[UtilString getNoNilString:startArea]];
    }
    
    NSString *ss2 = @"";
    if (![[UtilString getNoNilString:startCity] isEqualToString:[UtilString getNoNilString:startProvince]] && ![[UtilString getNoNilString:startCity] isEqualToString:@""]) {
        ss2 = [NSString stringWithFormat:@"-%@",[UtilString getNoNilString:startCity]];
    }
    beginLab.text = [NSString stringWithFormat:@"%@%@%@",[UtilString getNoNilString:startProvince],ss2,ss];
    
    NSString *dd = @"";
    if (![[UtilString getNoNilString:arrivalArea] isEqualToString:@"不限"] && ![[UtilString getNoNilString:arrivalArea] isEqualToString:@""]) {
        dd = [NSString stringWithFormat:@"-%@",[UtilString getNoNilString:arrivalArea]];
    }
    NSString *dd2 = @"";
    if (![[UtilString getNoNilString:arrivalProvince] isEqualToString:[UtilString getNoNilString:arrivalCity]] && ![[UtilString getNoNilString:arrivalCity] isEqualToString:@""]) {
        dd2 = [NSString stringWithFormat:@"-%@",[UtilString getNoNilString:arrivalCity]];
    }
    endLab.text = [NSString stringWithFormat:@"%@%@%@",[UtilString getNoNilString:arrivalProvince],dd2,dd];
    
    [UIView animateWithDuration:0 animations:^{
        areaView.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight - 64);
        [self.view bringSubviewToFront:areaView];
    }];
}

- (void)provinceAction{ //  获取省地址信息  province1   --- province6   --- hotProvince
    dicPro = [NSMutableArray array];
    for (int i = 0; i< _dicAreas.count; i++) {
        NSDictionary *dic = _dicAreas[i];
        ModelArea *modelPro = [[ModelArea alloc]init];
        modelPro.keyName = [dic objectForKey:@"Code"];
        modelPro.KeyValue = [dic objectForKey:@"Value"];
        [dicPro addObject:modelPro];
    }

    for (UIView * subView in scrollV.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            [subView removeFromSuperview];
        }
    }
    
    for (int i =0; i<dicPro.count; i++) {
        int row = i/3;
        int col = i%3;
        
        int x = (ScreenWidth/3)*col;
        int y = 50*row;
        UIButton *btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(x, y, ScreenWidth/3, 50);
        btn.tag = i;
        [btn setBackgroundColor:[UIColor colorWithHex:0xfafafa alpha:0.8]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = SYSTEM_FONT_(18);
        btn.layer.borderWidth = 5;
        btn.layer.borderColor = WHITE_COLOR.CGColor;
        [scrollV addSubview:btn];
        
        ModelArea *model = dicPro[i];
        [btn setTitle:model.KeyValue forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(provinceBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    [areaView bringSubviewToFront:areaBtn];
    scrollV.contentSize = CGSizeMake(ScreenWidth, dicPro.count/3*50 +50);
}

- (void)provinceBtn:(id)sender{   // 省按钮事件
    UIButton *btn = (UIButton *)sender;
    seleProIndex = (int)btn.tag;
    ModelArea *model = dicPro[seleProIndex];
    if (chooseType == 1) {
        startProvince = model.KeyValue;
        startProvinceid = model.keyName;
        startAreaid = nil;
        startArea = nil;
        startCityid = nil;
        startCity = nil;
    }
    else if (chooseType == 2){
        arrivalProvince = model.KeyValue;
        arrivalProvinceid = model.keyName;
        arrivalAreaid = nil;
        arrivalArea = nil;
        arrivalCityid = nil;
        arrivalCity = nil;
    }
    [self cityAction];
    titleLab.text = model.KeyValue;
    [areaView bringSubviewToFront:provinceBtn];
}

- (void)cityAction{ //  获取市信息
    NSDictionary *dic = _dicAreas[seleProIndex];
    dicCity = [NSMutableArray array];
    NSArray *arr = [dic objectForKey:@"City"];
    for (int i = 0; i<[arr count]; i++) {
        NSDictionary *dic = arr[i];
        ModelArea *model = [[ModelArea alloc]init];
        model.keyName = [dic objectForKey:@"Code"];
        model.KeyValue = [dic objectForKey:@"Value"];
        [dicCity addObject:model];
    }
    
    for (UIView * subView in scrollV.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            [subView removeFromSuperview];
        }
    }
    
    for (int i =0; i<dicCity.count; i++) {
        int row = i/3;
        int col = i%3;
        
        int x = (ScreenWidth/3)*col;
        int y = 50*row;
        UIButton *btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(x, y, ScreenWidth/3, 50);
        btn.tag = i;
        [btn setBackgroundColor:[UIColor colorWithHex:0xfafafa alpha:0.8]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = SYSTEM_FONT_(18);
        btn.layer.borderWidth = 5;
        btn.layer.borderColor = WHITE_COLOR.CGColor;
        [scrollV addSubview:btn];

        
        ModelArea *model = dicCity[i];
        [btn setTitle:model.KeyValue forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(cityBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    [areaView bringSubviewToFront:provinceBtn];
    scrollV.contentSize = CGSizeMake(ScreenWidth, dicCity.count/3*50);
}

- (void)cityBtn:(id)sender{   // 市按钮事件
    UIButton *btn = (UIButton *)sender;
    seleCityIndex = (int)btn.tag;
    ModelArea *model = dicCity[seleCityIndex];
    if (chooseType == 1) {
        startCity = model.KeyValue;
        startCityid = model.keyName;
    }
    else if (chooseType == 2){
        arrivalCity = model.KeyValue;
        arrivalCityid = model.keyName;
    }
    [self areaAction];
    titleLab.text = model.KeyValue;
    [areaView bringSubviewToFront:cityBtn];
}

- (void)areaAction{     //  获取区
    dicArea = [NSMutableArray array];
    NSDictionary *dic = _dicAreas[seleProIndex];
    NSArray *arr = [dic objectForKey:@"City"];
    NSDictionary *dicc = arr[seleCityIndex];
    dicArea = [NSMutableArray array];
    
    NSArray *arra = [dicc objectForKey:@"Area"];
    for (int i = 0; i<[arra count]; i++) {
        NSDictionary *dic = arra[i];
        ModelArea *model = [[ModelArea alloc]init];
        model.keyName = [dic objectForKey:@"Code"];
        model.KeyValue = [dic objectForKey:@"Value"];
        [dicArea addObject:model];
    }
    
    for (UIView * subView in scrollV.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            [subView removeFromSuperview];
        }
    }
    
    for (int i =0; i<dicArea.count; i++) {
        int row = i/3;
        int col = i%3;
        
        int x = (ScreenWidth/3)*col;
        int y = 50*row;
        UIButton *btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(x, y, ScreenWidth/3, 50);
        btn.tag = i;
        [btn setBackgroundColor:[UIColor colorWithHex:0xfafafa alpha:0.8]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = SYSTEM_FONT_(18);
        btn.layer.borderWidth = 5;
        btn.layer.borderColor = WHITE_COLOR.CGColor;
        [scrollV addSubview:btn];
        
        ModelArea *model = dicArea[i];
        [btn setTitle:model.KeyValue forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(areaBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    [areaView bringSubviewToFront:cityBtn];
    scrollV.contentSize = CGSizeMake(ScreenWidth, dicArea.count/3*50);
}

- (void)areaBtn:(id)sender{   // 区按钮事件
    UIButton *btn = (UIButton *)sender;
    seleAreaIndex = (int)btn.tag;
    ModelArea *model = dicArea[seleAreaIndex];
    if (chooseType == 1) {
        startArea = model.KeyValue;
        startAreaid = model.keyName;
    }
    else if (chooseType == 2){
        arrivalArea = model.KeyValue;
        arrivalAreaid = model.keyName;
    }
    
    [self hideAreaV];
}

//当键盘位置发生改变的时候会调用该方法
-(void)keyboardWillChangeFrame:(NSNotification *)notification{
    //键盘弹出的时间
    CGFloat duration=[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //键盘自己的frame
    CGRect keyBoardFrame=[notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //计算当前view的y方向的偏移量
    CGFloat transfomY=keyBoardFrame.origin.y-ScreenHeight;
    //UIView动画
    [UIView animateWithDuration:duration animations:^{
        //        self.view.transform=CGAffineTransformMakeTranslation(0, transfomY);
        if (transfomY >= 0) {
            _mainScroll.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64);
        }
        else{
            _mainScroll.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 -258);
        }
    }];
}

- (void)drawView{
    UILabel *title01 = [UILabel createLabelWithFrame:CGRectMake(0, 0, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"*起始地:"];
    title01.attributedText = [self changeAttr:title01.text];
    [_mainScroll addSubview:title01];
    beginLab = [UILabel createLabelWithFrame:CGRectMake(90, 0, ScreenWidth - 110, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"江苏-无锡"];
    [_mainScroll addSubview:beginLab];
    UILabel *title02 = [UILabel createLabelWithFrame:CGRectMake(0, 40, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"地址:"];
    [_mainScroll addSubview:title02];
    UILabel *title03 = [UILabel createLabelWithFrame:CGRectMake(0, 80, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"*到达地:"];
    title03.attributedText = [self changeAttr:title03.text];
    [_mainScroll addSubview:title03];
    endLab = [UILabel createLabelWithFrame:CGRectMake(90, 80, ScreenWidth - 110, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"江苏-南京"];
    [_mainScroll addSubview:endLab];
    UILabel *title04 = [UILabel createLabelWithFrame:CGRectMake(0, 120, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"地址:"];
    [_mainScroll addSubview:title04];
    UILabel *title05 = [UILabel createLabelWithFrame:CGRectMake(0, 160, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"发货人:"];
    [_mainScroll addSubview:title05];
    UILabel *title06 = [UILabel createLabelWithFrame:CGRectMake(0, 200, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"*手机号:"];
    title06.attributedText = [self changeAttr:title06.text];
    [_mainScroll addSubview:title06];
    UILabel *title07 = [UILabel createLabelWithFrame:CGRectMake(0, 240, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"*货物名称:"];
    title07.attributedText = [self changeAttr:title07.text];
    [_mainScroll addSubview:title07];
    UILabel *title08 = [UILabel createLabelWithFrame:CGRectMake(0, 280, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"*货物类型:"];
    title08.attributedText = [self changeAttr:title08.text];
    [_mainScroll addSubview:title08];
    title09 = [UILabel createLabelWithFrame:CGRectMake(0, 320, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"*体积(方):"];
    title09.attributedText = [self changeAttr:title09.text];
    [_mainScroll addSubview:title09];
    UILabel *title10 = [UILabel createLabelWithFrame:CGRectMake(0, 360, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"备注:"];
    [_mainScroll addSubview:title10];
    
    beginBtn = [UIButton createButtonwithFrame:beginLab.frame backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@""]];
    beginBtn.tag = 1001;
    [beginBtn addTarget:self action:@selector(showAreaV:) forControlEvents:UIControlEventTouchUpInside];
    [_mainScroll addSubview:beginBtn];
    endBtn = [UIButton createButtonwithFrame:endLab.frame backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@""]];
    endBtn.tag = 1002;
    [endBtn addTarget:self action:@selector(showAreaV:) forControlEvents:UIControlEventTouchUpInside];
    [_mainScroll addSubview:endBtn];
    
    beginaddtxt = [UITextField createTextFieldWithFrame:CGRectMake(90, 40, ScreenWidth-110, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"如需提货请输入详细地址" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft];
    beginaddtxt.delegate = self;
    [_mainScroll addSubview:beginaddtxt];
    endaddtxt = [UITextField createTextFieldWithFrame:CGRectMake(90, 120, ScreenWidth - 110, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"请输入详细地址" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft];
    endaddtxt.delegate = self;
    [_mainScroll addSubview:endaddtxt];
    
    nametxt = [UITextField createTextFieldWithFrame:CGRectMake(90, 160, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft];
    nametxt.delegate = self;
    [_mainScroll addSubview:nametxt];
    phonetxt = [UITextField createTextFieldWithFrame:CGRectMake(90, 200, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft];
    phonetxt.delegate = self;
    [_mainScroll addSubview:phonetxt];
    pronametxt = [UITextField createTextFieldWithFrame:CGRectMake(90, 240, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft];
    pronametxt.delegate = self;
    [_mainScroll addSubview:pronametxt];
    
    paoImg = [UIImageView createImageViewWithFrame:CGRectMake(105, 292, 15, 15) backgroundColor:TABBAR_TEXT_COLOR_SEL image:[UIImage imageNamed:@""]];
    paoImg.layer.borderColor = [UIColor lightGrayColor].CGColor;
    paoImg.layer.borderWidth = 1;
    paoImg.layer.cornerRadius = 7.5;
    [_mainScroll addSubview:paoImg];
    zhongImg = [UIImageView createImageViewWithFrame:CGRectMake(205, 292, 15, 15) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@""]];
    zhongImg.layer.borderColor = [UIColor lightGrayColor].CGColor;
    zhongImg.layer.cornerRadius = 7.5;
    zhongImg.layer.borderWidth = 1;
    [_mainScroll addSubview:zhongImg];
    
    paoBtn = [UIButton createButtonwithFrame:CGRectMake(120, 290, 50, 20) backgroundColor:CLEAN_COLOR conrnerRadius:4 borderWidth:0 borderColor:CLEAN_COLOR];
    [paoBtn setTitle:@"泡货" forState:UIControlStateNormal];
    paoBtn.titleLabel.font = SYSTEM_FONT_(14);
    [paoBtn addTarget:self action:@selector(protype:) forControlEvents:UIControlEventTouchUpInside];
    [paoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_mainScroll addSubview:paoBtn];
    zhBtn = [UIButton createButtonwithFrame:CGRectMake(220, 290, 50, 20) backgroundColor:CLEAN_COLOR conrnerRadius:4 borderWidth:0 borderColor:CLEAN_COLOR];
    [zhBtn setTitle:@"重货" forState:UIControlStateNormal];
    [zhBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [zhBtn addTarget:self action:@selector(protype:) forControlEvents:UIControlEventTouchUpInside];
    zhBtn.titleLabel.font = SYSTEM_FONT_(14);
    [_mainScroll addSubview:zhBtn];
    
    weighttxt = [UITextField createTextFieldWithFrame:CGRectMake(90, 320, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft];
    weighttxt.delegate = self;
    [_mainScroll addSubview:weighttxt];
    weighttxt.keyboardType = UIKeyboardTypeDecimalPad;
    remarktxt = [UITextField createTextFieldWithFrame:CGRectMake(90, 360, 150, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"" text:@"" textColor:TABBAR_TEXT_COLOR_NOR font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft];
    remarktxt.delegate = self;
    [_mainScroll addSubview:remarktxt];
    
    for (int i=0; i<10; i++) {
        UILabel *tapline = [UILabel createLabelWithFrame:CGRectMake(0, 39 + i*40, ScreenWidth, 1) backgroundColor:HEXCOLOR(0xf2f2f2) textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@""];
        [_mainScroll addSubview:tapline];
    }
    
    startProvince = [_placedic objectForKey:@"StartProvince"];
    startCity = [_placedic objectForKey:@"StartCity"];
    startArea = [_placedic objectForKey:@"StartAreas"];
    arrivalProvince = [_placedic objectForKey:@"ArrivalProvince"];
    arrivalCity = [_placedic objectForKey:@"ArrivalCity"];
    arrivalArea = [_placedic objectForKey:@"ArrivalAreas"];
    
    UIButton *askBtn = [UIButton createButtonwithFrame:CGRectMake(10, ScreenHeight - 114, ScreenWidth - 20, 40) backgroundColor:TABBAR_TEXT_COLOR_SEL image:[UIImage imageNamed:@""]];
    askBtn.layer.cornerRadius = 5;
    [askBtn setTitle:@"一键询价" forState:UIControlStateNormal];
    if (_orderId) {
        [askBtn setTitle:@"保存修改" forState:UIControlStateNormal];
    }
    [askBtn addTarget:self action:@selector(askPrice) forControlEvents:UIControlEventTouchUpInside];
    [_mainScroll addSubview:askBtn];
    
    _mainScroll.contentSize = CGSizeMake(ScreenWidth, 600);
    
//    beginLab.text = [NSString stringWithFormat:@"%@ %@ %@",[_placedic objectForKey:@"StartProvince"],[_placedic objectForKey:@"StartCity"],[_placedic objectForKey:@"StartAreas"]];
//    
//    endLab.text = [NSString stringWithFormat:@"%@ %@ %@",[_placedic objectForKey:@"ArrivalProvince"],[_placedic objectForKey:@"ArrivalCity"],[_placedic objectForKey:@"ArrivalAreas"]];
    if (_orderId) {
        [self requestInfo];
    }
    
    if (!_orderId) {
        [self requestMyInfo];
    }
    else{
        
    }
    
    [self hideAreaV];
}

- (void)requestInfo{  // 查询信息的界面信息装填
    NSString *urlStr = [NSString stringWithFormat:@"http://app.mjxypt.com/api/order/getbyid?id=%@",_orderId];
    [Request getRequestWithUrl:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] params:nil showTips:@"查询" tipsType:SVProgressHUDMaskTypeClear sucessBlock:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary *dict = responseObject;
        
        startProvince = [dict objectForKey:@"StartProvince"];
        startCity = [dict objectForKey:@"StartCity"];
        startArea = [dict objectForKey:@"StartAreas"];
        arrivalProvince = [dict objectForKey:@"ArrivalProvince"];
        arrivalCity = [dict objectForKey:@"ArrivalCity"];
        arrivalArea = [dict objectForKey:@"ArrivalAreas"];
        [self hideAreaV];
        beginaddtxt.text = [dict objectForKey:@"StartAddr"];
        endaddtxt.text = [dict objectForKey:@"ArrivalAddr"];
        nametxt.text = [dict objectForKey:@"ShipperContact"];
        phonetxt.text =[dict objectForKey:@"ShipperMobile"];
        pronametxt.text = [dict objectForKey:@"CargoName"];
        if ([[dict safeObjectForKey:@"CargoType"] isEqualToString:@""] || [[dict safeObjectForKey:@"CargoType"] isEqualToString:@"泡货"]) {
            [paoImg setBackgroundColor:TABBAR_TEXT_COLOR_SEL];
            [zhongImg setBackgroundColor:CLEAN_COLOR];
            NSString *str = @"*体积:";
            title09.attributedText = [self changeAttr:str];
            proType = @"泡货";
        }
        else if ([[dict safeObjectForKey:@"CargoType"] isEqualToString:@"重货"]){
            [zhongImg setBackgroundColor:TABBAR_TEXT_COLOR_SEL];
            [paoImg setBackgroundColor:CLEAN_COLOR];
            NSString *str = @"*重量:";
            proType = @"重货";
            title09.attributedText = [self changeAttr:str];
        }
        
        weighttxt.text = [NSString stringWithFormat:@"%.3f",[[dict objectForKey:@"Weight"] floatValue]+[[dict objectForKey:@"Volume"] floatValue]];
        remarktxt.text = [dict objectForKey:@"Remark"];
        
        
    } failBlock:^(NSError *error) {
        
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
    [nametxt resignFirstResponder];
    [phonetxt resignFirstResponder];
    [beginaddtxt resignFirstResponder];
    [endaddtxt resignFirstResponder];
    [pronametxt resignFirstResponder];
    [weighttxt resignFirstResponder];
    [remarktxt resignFirstResponder];
}

-(void)protype:(id)sender{
    UIButton *btn = (UIButton *)sender;
    if ([btn isEqual:paoBtn]) {
        [paoImg setBackgroundColor:TABBAR_TEXT_COLOR_SEL];
        [zhongImg setBackgroundColor:CLEAN_COLOR];
        NSString *str = @"*体积(方):";
        title09.attributedText = [self changeAttr:str];
        proType = @"泡货";
    }
    if ([btn isEqual:zhBtn]) {
        [zhongImg setBackgroundColor:TABBAR_TEXT_COLOR_SEL];
        [paoImg setBackgroundColor:CLEAN_COLOR];
        NSString *str = @"*重量(吨):";
        proType = @"重货";
        title09.attributedText = [self changeAttr:str];
    }
}

- (void)askPrice{
// 询问价格
    if ([beginLab.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请填写起始省市" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    if ([endLab.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请填写目的地省市" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    if (phonetxt.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写手机号" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    else if (![CheckMethod validateMobile:phonetxt.text]){
        [SVProgressHUD showErrorWithStatus:@"请填写正确的手机号" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    if (pronametxt.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写货物名称" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    if (!proType) {
        [SVProgressHUD showErrorWithStatus:@"请填写货物类型" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    if (weighttxt.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写货物量" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    if ([self isPureFloat:weighttxt.text] == NO) {
        UIAlertView *sds = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的数量(别带汉字)" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:@"ok", nil];
        [sds show];
        return;
        
    }
    [self requestXunjia];

}
//http://app.mjxypt.com/api/order/create
- (void)requestXunjia{ // 询价
    NSString *urlStr = [Request getUrlStringWithRequestStr:@"order/create"];
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    Inquiry
    
    if (_linearr.count>0) {
        NSMutableString *linids = [[_linearr firstObject] mutableCopy];
        if (_linearr.count == 1) {
            
        }
        else{
            for (int i = 1; i<_linearr.count; i++) {
                NSString *str = _linearr[i];
                [linids appendFormat:@";%@",str];
            }
        }
        [dict setObject:linids forKey:@"Inquiry"];
    }
    if (!_orderId) {
        [dict setObject:@"00000000-0000-0000-0000-000000000000" forKey:@"OrderId"];
    }
    else {
        [dict setObject:_orderId forKey:@"OrderId"];
    }
    
    [dict setObject:[[user objectForKey:@"UserLogin"] objectForKey:@"userId"] forKey:@"CompanyId"];
    [dict setObject:nametxt.text forKey:@"ShipperContact"];
    [dict setObject:phonetxt.text forKey:@"ShipperMobile"];
    [dict setObject:startProvince forKey:@"StartProvince"];
    [dict setObject:startCity forKey:@"StartCity"];
    [dict setObject:startArea forKey:@"StartAreas"];
    [dict setObject:beginaddtxt.text forKey:@"StartAddr"];
    [dict setObject:arrivalProvince forKey:@"ArrivalProvince"];
    [dict setObject:arrivalCity forKey:@"ArrivalCity"];
    [dict setObject:arrivalArea forKey:@"ArrivalAreas"];
    [dict setObject:endaddtxt.text forKey:@"ArrivalAddr"];
    [dict setObject:proType forKey:@"CargoType"];
    [dict setObject:pronametxt.text forKey:@"CargoName"];

    if ([proType isEqualToString:@"重货"]) {
        [dict setObject:weighttxt.text forKey:@"Weight"];
        [dict setObject:[NSNumber numberWithFloat:0.0] forKey:@"Volume"];
    }
    else{
        [dict setObject:weighttxt.text forKey:@"Volume"];
        [dict setObject:[NSNumber numberWithFloat:0.0] forKey:@"Weight"];
    }
    [dict setObject:remarktxt.text forKey:@"Remark"];
    [dict setObject:[NSNumber numberWithInt:0] forKey:@"Qty"];
    [dict setObject:@"件" forKey:@"Packages"];
    
    [Request postRequestWithUrl:urlStr params:dict showTips:@"正在申请...." tipsType:SVProgressHUDMaskTypeBlack sucessBlock:^(id responseObject) {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
