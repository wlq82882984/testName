//
//  MJSearchResultViewController.m
//  MingJia
//
//  Created by admin on 15/12/30.
//  Copyright © 2015年 BCKJ. All rights reserved.
//  http://app.mjxypt.com/api/waybill/search?waybillno=

#import "MJSearchResultViewController.h"
#import "MJHomeViewController.h"
#import "SweepYardVCtr.h"
#import "MLlogdetailCell.h"

@interface MJSearchResultViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UILabel *okLab;
    UILabel * orderLab;
    UILabel *compName;
    UIImageView *imgv;
    
    NSArray      *stateArr;
    NSArray      *logArr;
}

@property(nonatomic,strong)UITableView *mainTabV;

@end

@implementation MJSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查询结果";
    stateArr = [NSArray array];
    logArr = [NSArray array];
    
    self.view.backgroundColor = WHITE_COLOR;
    [self drawHead];
    [self sendRequestOrder];
    
    UIButton *btnBackCustom = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBackCustom.frame = CGRectMake(0, 0, 40, 35);
    [btnBackCustom setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    btnBackCustom.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [btnBackCustom addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:btnBackCustom];
}

- (void)backAction{
    NSArray *arr = self.navigationController.viewControllers;
    int i = (int)arr.count;
    if ([arr[i-2] isKindOfClass:[SweepYardVCtr class]]) {
        [self.navigationController popToViewController:arr[i-3] animated:NO];
    }
    else {
        [self.navigationController popViewControllerAnimated:NO];
    }
  
}

- (void)sendRequestOrder{
    NSString *urlStr;
    if (_myOrderorderId) {
        urlStr = [NSString stringWithFormat:@"http://app.mjxypt.com/api/waybill/getbyorderno?orderid=%@",_myOrderorderId];
    }
    
    if (_orderId) {
        urlStr = [NSString stringWithFormat:@"http://app.mjxypt.com/api/waybill/search?waybillno=%@",_orderId];
    }

    [Request getRequestWithUrl:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] params:nil showTips:@"获取运单信息" tipsType:SVProgressHUDMaskTypeClear sucessBlock:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary *dict = responseObject;
        orderLab.text = [NSString stringWithFormat:@"运单号：%@",[dict objectForKey:@"WaybillNo"]];
        compName.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"CompanyName"]];
        stateArr = [dict objectForKey:@"StateDetails"];
        logArr = [dict objectForKey:@"LogDetails"];
        okLab.text = @"查询成功";
        
        _mainTabV = [UITableView createTableViewWithFrame:CGRectMake(0, 41, ScreenWidth, ScreenHeight - 105) style:UITableViewStylePlain backgroundColor:CLEAN_COLOR delegate:self dataSource:self];
        [_mainTabV setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.view addSubview:_mainTabV];
        _mainTabV.tableHeaderView = [self tabheadV];
        
    } failBlock:^(NSError *error) {
        [self drawBodyV]; // 没有数据的情况
        okLab.text = @"查询失败";
        imgv.image = [UIImage imageNamed:@"不开心"];
        compName.text = @"";
    } successBackFailedBlock:^(id responseObject) {
        
    }];
}

- (void)drawBodyV{
// 是否有数据
    UIView *body = [UIView createViewWithFrame:CGRectMake(0, 40, ScreenWidth, 130) backgroundColor:WHITE_COLOR];
    [self.view addSubview:body];
    
    UIImageView *errorImg = [UIImageView createImageViewWithFrame:CGRectMake(ScreenWidth/2-20, 20, 40, 40) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"123"]];
    [body addSubview:errorImg];
    
    UILabel *sorryLab = [UILabel createLabelWithFrame:CGRectMake(0, 90, ScreenWidth, 16) backgroundColor:CLEAN_COLOR textColor:[UIColor blackColor] font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentCenter text:@"很抱歉，没有查到相关信息"];
    [body addSubview:sorryLab];
    
    UILabel *titLab = [UILabel createLabelWithFrame:CGRectMake(50, 220, ScreenWidth - 50, 16) backgroundColor:CLEAN_COLOR textColor:[UIColor blackColor] font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft text:@"可能原因"];
    [self.view addSubview:titLab];
    UILabel *tit1Lab = [UILabel createLabelWithFrame:CGRectMake(50, 250, ScreenWidth - 50, 16) backgroundColor:CLEAN_COLOR textColor:[UIColor blackColor] font:SYSTEM_FONT_(15) textalignment:NSTextAlignmentLeft text:@"  >您的货物刚刚提货，还未来得及录入"];
    [self.view addSubview:tit1Lab];
    UILabel *tit2Lab = [UILabel createLabelWithFrame:CGRectMake(50, 280, ScreenWidth - 50, 16) backgroundColor:CLEAN_COLOR textColor:[UIColor blackColor] font:SYSTEM_FONT_(15) textalignment:NSTextAlignmentLeft text:@"  >您输入的单号有或超过六个月"];
    [self.view addSubview:tit2Lab];
    UILabel *tit3Lab = [UILabel createLabelWithFrame:CGRectMake(50, 310, ScreenWidth - 50, 16) backgroundColor:CLEAN_COLOR textColor:[UIColor blackColor] font:SYSTEM_FONT_(15) textalignment:NSTextAlignmentLeft text:@"  >请联系客服"];
    [self.view addSubview:tit3Lab];
    
    UIButton *teleBtn = [UIButton createButtonwithFrame:CGRectMake(150, 303, 130, 30) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@""]];
    teleBtn.titleLabel.font = SYSTEM_FONT_(16);
    [teleBtn addTarget:self action:@selector(tele:) forControlEvents:UIControlEventTouchUpInside];
    [teleBtn setTitleColor:TABBAR_TEXT_COLOR_SEL forState:UIControlStateNormal];
    [teleBtn setTitle:@"18961872005" forState:UIControlStateNormal];
    [self.view addSubview:teleBtn];
    
}

- (void)tele:(NSString *)phoneNo{ // 打电话
//    UIAlertView *alert=[UIAlertView showAlertViewWithTitle:@"" message:[NSString stringWithFormat:@"联系电话:%@",@"18961872005"] cancelButtonTitle:@"取消" otherButtonTitles:@[@"呼叫"] onDismiss:^(int buttonIndex) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"18961872005"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//    } onCancel:^{
//    }];
//    [alert show];
}

- (void)drawHead{
    UIView *head = [UIView createViewWithFrame:CGRectMake(0, 0, ScreenWidth, 40) backgroundColor:WHITE_COLOR];
    [self.view addSubview:head];
    
    orderLab = [UILabel createLabelWithFrame:CGRectMake(10, 5, SizeScale(200), 14) backgroundColor:CLEAN_COLOR textColor:[UIColor blackColor] font:SYSTEM_FONT_BOLD_(14) textalignment:NSTextAlignmentLeft text:@"运单号："];
    [head addSubview:orderLab];
    
    compName = [UILabel createLabelWithFrame:CGRectMake(10, 23, SizeScale(200), 14) backgroundColor:CLEAN_COLOR textColor:[UIColor redColor] font:SYSTEM_FONT_(12) textalignment:NSTextAlignmentLeft text:@"无锡市XXX运货有限公司"];
    [head addSubview:compName];
    
    UILabel *tapline = [UILabel createLabelWithFrame:CGRectMake(10, 39, ScreenWidth, 1) backgroundColor:[UIColor colorWithHex:0xe2e2e2 alpha:1.0] textColor:[UIColor redColor] font:SYSTEM_FONT_(12) textalignment:NSTextAlignmentLeft text:@""];
    [head addSubview:tapline];
    
    UILabel *tapline2 = [UILabel createLabelWithFrame:CGRectMake(SizeScale(201), 0, 1, 40) backgroundColor:[UIColor colorWithHex:0xe2e2e2 alpha:1.0] textColor:[UIColor redColor] font:SYSTEM_FONT_(12) textalignment:NSTextAlignmentLeft text:@""];
    [head addSubview:tapline2];
    
    imgv = [UIImageView createImageViewWithFrame:CGRectMake(SizeScale(210), 10, 20, 20) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"开心"]];
    [head addSubview:imgv];
    
    okLab = [UILabel createLabelWithFrame:CGRectMake(SizeScale(210)+ 30, 12, 70, 14) backgroundColor:CLEAN_COLOR textColor:[UIColor blackColor] font:SYSTEM_FONT_BOLD_(14) textalignment:NSTextAlignmentLeft text:@"查询成功"];
    [head addSubview:okLab];
}

- (UIView *)tabheadV{
    UIView *tabheadV = [UIView createViewWithFrame:CGRectMake(0, 0, ScreenWidth, 70) backgroundColor:WHITE_COLOR];
    UILabel *tapline = [UILabel createLabelWithFrame:CGRectMake(0, 69, ScreenWidth, 1) backgroundColor:[UIColor lightGrayColor] textColor:WHITE_COLOR font:SYSTEM_FONT_(1) textalignment:NSTextAlignmentLeft text:@""];
    [tabheadV addSubview:tapline];
    
//    stateArr
    for (int i=0; i<stateArr.count; i++) {
        NSDictionary *model = stateArr[i];
        UIButton *btn = [UIButton createButtonwithFrame:CGRectMake(50+60*i, 10, 10, 10) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@""]];
        btn.layer.cornerRadius = 5;
        btn.layer.borderWidth = 2;
        [tabheadV addSubview:btn];
        UIButton *btn2 = [UIButton createButtonwithFrame:CGRectMake(53+60*i, 40, 4, 4) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@""]];
        btn2.layer.cornerRadius = 2;
        [tabheadV addSubview:btn2];
        UILabel *line1 = [UILabel createLabelWithFrame:CGRectMake(btn2.center.x-0.5, 20, 1, 20) backgroundColor:TABBAR_TEXT_COLOR_SEL textColor:[UIColor blackColor] font:SYSTEM_FONT_BOLD_(14) textalignment:NSTextAlignmentCenter text:@""];
        [tabheadV addSubview:line1];
        UILabel *line2 = [UILabel createLabelWithFrame:CGRectMake(btn.center.x+5, 15, 50, 2) backgroundColor:TABBAR_TEXT_COLOR_SEL textColor:[UIColor blackColor] font:SYSTEM_FONT_BOLD_(14) textalignment:NSTextAlignmentCenter text:@""];
        [tabheadV addSubview:line2];
        
        UILabel *note = [UILabel createLabelWithFrame:CGRectMake(0, 0, 60, 14) backgroundColor:CLEAN_COLOR textColor:[UIColor blackColor] font:SYSTEM_FONT_BOLD_(14) textalignment:NSTextAlignmentCenter text:[model objectForKey:@"State"]];
        note.center = CGPointMake(btn2.center.x, 55);
        [tabheadV addSubview:note];
        
        if ([[model objectForKey:@"Active"]intValue] == 1) {
            btn.layer.borderColor = TABBAR_TEXT_COLOR_SEL.CGColor;
            [btn2 setBackgroundColor:TABBAR_TEXT_COLOR_SEL];
            note.textColor = [UIColor blackColor];
            line1.backgroundColor = TABBAR_TEXT_COLOR_SEL;
        }
        else{
            btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            [btn2 setBackgroundColor:[UIColor lightGrayColor]];
            note.textColor = [UIColor lightGrayColor];
            line1.backgroundColor = [UIColor lightGrayColor];
        }
        
        if (i == stateArr.count - 1) {
            [line2 removeFromSuperview];
        }
        
        if(i+1 < stateArr.count){
            if ([[stateArr[i+1] objectForKey:@"Active"]intValue] == 0) {
                line2.backgroundColor = [UIColor lightGrayColor];
            }
        }
    }
    return tabheadV;
}

#pragma mark  delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return logArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *model = logArr[indexPath.row];
    MLlogdetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[MLlogdetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.timeLab.text = [model objectForKey:@"CreateTime"];
    cell.dateLab.text = [model objectForKey:@"CreateDate"];
    cell.noteLab.text = [model objectForKey:@"Note"];
    
    if (indexPath.row <= 1) {
     cell.contentView.backgroundColor = WHITE_COLOR;
    }
    
    return cell;
}

#pragma mark  datasouce
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
