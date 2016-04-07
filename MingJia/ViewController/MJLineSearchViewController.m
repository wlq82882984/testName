//
//  MJLineSearchViewController.m
//  MingJia
//
//  Created by admin on 15/12/26.
//  Copyright © 2015年 BCKJ. All rights reserved.

#import "MJLineSearchViewController.h"
#import "MJLineListViewController.h"
#import "MJZhuanxianXYViewController.h"
#import "ModelArea.h"

@interface MJLineSearchViewController ()<UITextFieldDelegate>{
    UITextField       *beginText;
    UITextField       *endText;
    UITextField       *nameText;
    
    NSMutableArray   *dicAreas;
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
    NSMutableArray      *dicArea;
    int                 seleProIndex;
    int                 seleCityIndex;
    int                 seleAreaIndex;

}

@end

@implementation MJLineSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dicAreas = [NSMutableArray array];
    if (_searchType == SETORDERTYPE) {
        self.title = @"路线查询";
    }
    else if (_searchType == SEARCHORDERTYPE){
        self.title = @"专线信用查询";
    }
//    [self requestgetArea];
    NSMutableDictionary *diccc = [NSMutableDictionary dictionary];
    diccc = [PlistDao readKeyDictionary:@"AreaPlist.plist" key:@"areaPlist"];
    dicAreas = [[diccc objectForKey:@"myArea"] mutableCopy];
    [self drawView];
    [self drawArea];
}

- (void)showAreaV:(id)sender{
    [nameText resignFirstResponder];
    UIButton *btn = (UIButton *)sender;
    [areaView bringSubviewToFront:provinceBtn];
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
    beginText.text = [NSString stringWithFormat:@"%@%@%@",[UtilString getNoNilString:startProvince],ss2,ss];
    
    NSString *dd = @"";
    if (![[UtilString getNoNilString:arrivalArea] isEqualToString:@"不限"] && ![[UtilString getNoNilString:arrivalArea] isEqualToString:@""]) {
        dd = [NSString stringWithFormat:@"-%@",[UtilString getNoNilString:arrivalArea]];
    }
    NSString *dd2 = @"";
    if (![[UtilString getNoNilString:arrivalProvince] isEqualToString:[UtilString getNoNilString:arrivalCity]] && ![[UtilString getNoNilString:arrivalCity] isEqualToString:@""]) {
        dd2 = [NSString stringWithFormat:@"-%@",[UtilString getNoNilString:arrivalCity]];
    }
    endText.text = [NSString stringWithFormat:@"%@%@%@",[UtilString getNoNilString:arrivalProvince],dd2,dd];
    
    [UIView animateWithDuration:0 animations:^{
        areaView.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight - 64);
        [self.view bringSubviewToFront:areaView];
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
}

- (void)drawView{
    UIView *headV = [UIView createViewWithFrame:CGRectMake(0, 0, ScreenWidth, 60) backgroundColor:TABBAR_TEXT_COLOR_SEL];
    [self.view addSubview:headV];
    
    UILabel *headLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 21, ScreenWidth, 18)];
    headLab.text = @"请选择起始地、到达地";
    headLab.textColor = WHITE_COLOR;
    headLab.backgroundColor = CLEAN_COLOR;
    headLab.textAlignment = NSTextAlignmentCenter;
    [headV addSubview:headLab];
    
    UIView *bodyV = [UIView createViewWithFrame:CGRectMake(0, 60, ScreenWidth, 150) backgroundColor:CLEAN_COLOR];
    [self.view addSubview:bodyV];
    
    int offset = 18;
    UILabel *qsdLab = [UILabel createLabelWithFrame:CGRectMake(0, offset, 80, 14) backgroundColor:CLEAN_COLOR textColor:[UIColor blackColor] font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"起始地："];
    [bodyV addSubview:qsdLab];
    UILabel *tapline1 = [UILabel createLabelWithFrame:CGRectMake(0, 49, ScreenWidth, 1) backgroundColor:COLOR_line_HEAD textColor:CLEAN_COLOR font:SYSTEM_FONT_(2) textalignment:NSTextAlignmentRight text:@""];
    [bodyV addSubview:tapline1];
    
    offset += 50;
    UILabel *dddLab = [UILabel createLabelWithFrame:CGRectMake(0, offset, 80, 14) backgroundColor:CLEAN_COLOR textColor:[UIColor blackColor] font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"到达地："];
    [bodyV addSubview:dddLab];
    UILabel *tapline2 = [UILabel createLabelWithFrame:CGRectMake(0, 99, ScreenWidth, 1) backgroundColor:COLOR_line_HEAD textColor:CLEAN_COLOR font:SYSTEM_FONT_(2) textalignment:NSTextAlignmentRight text:@""];
    [bodyV addSubview:tapline2];
    
    offset += 50;
    UILabel *compenyLab = [UILabel createLabelWithFrame:CGRectMake(0, offset, 80, 14) backgroundColor:CLEAN_COLOR textColor:[UIColor blackColor] font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"公司名称："];
//    [bodyV addSubview:compenyLab];
    UILabel *tapline3 = [UILabel createLabelWithFrame:CGRectMake(0, 149, ScreenWidth, 1) backgroundColor:COLOR_line_HEAD textColor:CLEAN_COLOR font:SYSTEM_FONT_(2) textalignment:NSTextAlignmentRight text:@""];
//    [bodyV addSubview:tapline3];

    beginText = [UITextField createTextFieldWithFrame:CGRectMake(90, 0, ScreenWidth - 90, 50) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"点击选择地区" text:@"" textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft];
    beginText.delegate = self;
    beginText.enabled = NO;
    [bodyV addSubview:beginText];
    UIButton *beginBtn = [UIButton createButtonwithFrame:beginText.frame backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@""]];
    beginBtn.tag = 1001;
    [beginBtn addTarget:self action:@selector(showAreaV:) forControlEvents:UIControlEventTouchUpInside];
    [bodyV addSubview:beginBtn];
    
    endText = [UITextField createTextFieldWithFrame:CGRectMake(90, 50, ScreenWidth - 90, 50) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"点击选择地区" text:@"" textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft];
    endText.delegate = self;
    endText.enabled = NO;
    [bodyV addSubview:endText];
    UIButton *endBtn = [UIButton createButtonwithFrame:endText.frame backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@""]];
    endBtn.tag = 1002;
    [endBtn addTarget:self action:@selector(showAreaV:) forControlEvents:UIControlEventTouchUpInside];
    [bodyV addSubview:endBtn];
    
    nameText = [UITextField createTextFieldWithFrame:CGRectMake(90, 100, ScreenWidth - 90, 50) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"请输入物流公司" text:@"" textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft];
    nameText.delegate = self;
//    [bodyV addSubview:nameText];
    
    [self addSearchBtn];
    
    startProvince = @"江苏";
    startCity = @"无锡";
    beginText.text = [NSString stringWithFormat:@"%@-%@",startProvince,startCity];
}

//http://mjweixin.reeease.com/Home/GetAreaJson
//http://mjweixin.reeease.com/Home/GetAreaJson1
- (void)requestgetArea{
    NSString *urlStr = @"http://mjweixin.reeease.com/Home/GetAreaJson1";
    [Request getRequestWithUrl:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] params:nil showTips:@"查询" tipsType:SVProgressHUDMaskTypeClear sucessBlock:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSArray *dict = (NSArray *)responseObject;
        NSMutableDictionary *AreaDic = [NSMutableDictionary dictionary];
        [AreaDic setObject:dict forKey:@"myArea"];
        [PlistDao writePlist:AreaDic forKey:@"areaPlist" plistNameStr:@"abc.plist"];
        dicAreas = [dict mutableCopy];
//        NSMutableDictionary *diccc = [NSMutableDictionary dictionary];
//        diccc = [PlistDao readKeyDictionary:@"abc.plist" key:@"areaPlist"];
//        NSLog(@"%@",diccc);
        [self provinceAction];
    } failBlock:^(NSError *error) {
        
    } successBackFailedBlock:^(id responseObject) {
        
    }];
}

- (void)provinceAction{ //  获取省地址信息  province1   --- province6   --- hotProvince
    dicPro = [NSMutableArray array];
    for (int i = 0; i< dicAreas.count; i++) {
        NSDictionary *dic = dicAreas[i];
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
    ModelArea *model = dicPro[(int)btn.tag];
    seleProIndex = (int)btn.tag;
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
    NSDictionary *dic = dicAreas[seleProIndex];
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
    NSDictionary *dic = dicAreas[seleProIndex];
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

- (void)addSearchBtn{
    UIButton *searchBtn = [UIButton createButtonwithFrame:CGRectMake(10, 180, ScreenWidth-20, 40) backgroundColor:TABBAR_TEXT_COLOR_SEL image:[UIImage imageNamed:@""]];
    searchBtn.layer.cornerRadius = 5;
    [searchBtn setTitle:@"查询" forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(listLine) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    searchBtn.titleLabel.font = SYSTEM_FONT_(14);
    [self.view addSubview:searchBtn];
}

- (void)listLine{
    if ([beginText.text isEqualToString:@""] || !startProvince) {
        [SVProgressHUD showErrorWithStatus:@"请填写起始省市" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    if ([endText.text isEqualToString:@""] || !arrivalProvince) {
        [SVProgressHUD showErrorWithStatus:@"请填写目的地省市" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[UtilString getNoNilString:startProvince] forKey:@"StartProvince"];
    [dic setObject:[UtilString getNoNilString:startCity] forKey:@"StartCity"];
    [dic setObject:[UtilString getNoNilString:startArea] forKey:@"StartAreas"];
    [dic setObject:[UtilString getNoNilString:arrivalProvince] forKey:@"ArrivalProvince"];
    [dic setObject:[UtilString getNoNilString:arrivalCity] forKey:@"ArrivalCity"];
    [dic setObject:[UtilString getNoNilString:arrivalArea] forKey:@"ArrivalAreas"];
    [dic setObject:[UtilString getNoNilString:nameText.text] forKey:@"cnName"];
    if (_searchType == SETORDERTYPE) {  // 下单
        MJLineListViewController *vc = [[MJLineListViewController alloc]init];
        vc.placeDic = dic;
//        vc.dicAreas = dicAreas;
        [self.navigationController pushViewController:vc animated:NO];
    }
    else if (_searchType == SEARCHORDERTYPE){    //   查询
        MJZhuanxianXYViewController *vc = [[MJZhuanxianXYViewController alloc]init];
        vc.placeDic = dic;
        [self.navigationController pushViewController:vc animated:NO];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [nameText resignFirstResponder];
}

@end
