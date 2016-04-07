//
//  MJDetailOrderViewController.m
//  MingJia
//
//  Created by admin on 15/12/31.
//  Copyright © 2015年 BCKJ. All rights reserved.
//   http://app.mjxypt.com/api/order/getbyid?id=

#import "MJDetailOrderViewController.h"

@interface MJDetailOrderViewController (){
    UILabel     *orderidLab;
    UILabel     *dateLab;
    UILabel     *lineLab;
    
    NSString    *transportationId;
    
    UILabel     *phoneLab;
    UILabel     *addrLab;
    
    UILabel     *receveLab;
    
    UILabel     *pronameLab;
    UILabel     *pronumLab;
    UILabel     *weightLab;
    UILabel     *bulkLab;
    UILabel     *meettypeLab;
    UILabel     *receiptLab;
    UILabel     *protypeLab;
    UILabel     *moneyLab;
    UILabel     *payLab;
    UILabel     *remarkLab;
}

@property(nonatomic,strong)UIScrollView *mainScroll;

@end

@implementation MJDetailOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    _mainScroll = [[UIScrollView alloc]init];
    _mainScroll.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64);
    [self.view addSubview:_mainScroll];

    [self drawView];
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
    UILabel *title03 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 110, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"承运专线:"];
    [_mainScroll addSubview:title03];
    
    orderidLab = [UILabel createLabelWithFrame:CGRectMake(90, offset + 30, 150, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@""];
    [_mainScroll addSubview:orderidLab];
    dateLab = [UILabel createLabelWithFrame:CGRectMake(90, offset + 70, 200, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@""];
    [_mainScroll addSubview:dateLab];
    lineLab = [UILabel createLabelWithFrame:CGRectMake(90, offset + 110, 210, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@""];
    [_mainScroll addSubview:lineLab];
    
    //   发货人信息
    offset += 150;
    UIView *view2 = [UIView createViewWithFrame:CGRectMake(0, offset, ScreenWidth, 30) backgroundColor:BACK_COLL_HEAD];
    [_mainScroll addSubview:view2];
    
    UILabel *viewlab2 = [UILabel createLabelWithFrame:CGRectMake(0, 0, ScreenWidth, 30) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"  发货人信息"];
    [view2 addSubview:viewlab2];

    phoneLab = [UILabel createLabelWithFrame:CGRectMake(10, offset + 30, 200, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"手机号"];
    [_mainScroll addSubview:phoneLab];
    addrLab = [UILabel createLabelWithFrame:CGRectMake(10, offset + 70, 200, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"线路"];
    [_mainScroll addSubview:addrLab];

    
    //    收货人信息
    offset += 110;
    UIView *view3 = [UIView createViewWithFrame:CGRectMake(0, offset, ScreenWidth, 30) backgroundColor:BACK_COLL_HEAD];
    [_mainScroll addSubview:view3];
    
    UILabel *viewlab3 = [UILabel createLabelWithFrame:CGRectMake(0, 0, ScreenWidth, 30) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"  收货人信息"];
    [view3 addSubview:viewlab3];
    
    receveLab = [UILabel createLabelWithFrame:CGRectMake(10, offset + 30, ScreenWidth-20, 50) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"广州 广 哈多少萨克的基本cbvc cxvb cb cb cb bxc bcvb cb c bc b"];
    receveLab.numberOfLines = 2;
    [_mainScroll addSubview:receveLab];

    //    货物信息
    offset += 80;
    UIView *view4 = [UIView createViewWithFrame:CGRectMake(0, offset, ScreenWidth, 30) backgroundColor:BACK_COLL_HEAD];
    [_mainScroll addSubview:view4];
    
    UILabel *viewlab4 = [UILabel createLabelWithFrame:CGRectMake(0, 0, ScreenWidth, 30) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"  货物信息"];
    [view4 addSubview:viewlab4];
    
    UILabel *title31 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 30, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"货名:"];
    [_mainScroll addSubview:title31];
    UILabel *title32 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 70, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"数量:"];
    [_mainScroll addSubview:title32];
    UILabel *title33 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 110, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"重量:"];
    [_mainScroll addSubview:title33];
    UILabel *title34 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 150, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"体积:"];
    [_mainScroll addSubview:title34];
    UILabel *title35 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 190, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"交接方式:"];
    [_mainScroll addSubview:title35];
    UILabel *title36 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 230, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"回单:"];
    [_mainScroll addSubview:title36];
    UILabel *title37 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 270, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"货物类型:"];
    [_mainScroll addSubview:title37];
    UILabel *title38 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 310, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"运费:"];
    [_mainScroll addSubview:title38];
    UILabel *title39 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 350, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"支付:"];
    [_mainScroll addSubview:title39];
    UILabel *title310 = [UILabel createLabelWithFrame:CGRectMake(0, offset + 390, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"备注"];
    [_mainScroll addSubview:title310];
    
    pronameLab = [UILabel createLabelWithFrame:CGRectMake(90, offset + 30, 200, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"木箱 "];
    [_mainScroll addSubview:pronameLab];
    pronumLab = [UILabel createLabelWithFrame:CGRectMake(90, offset + 70, 200, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"0 "];
    [_mainScroll addSubview:pronumLab];
    weightLab = [UILabel createLabelWithFrame:CGRectMake(90, offset + 110, 200, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"重量 "];
    [_mainScroll addSubview:weightLab];
    bulkLab = [UILabel createLabelWithFrame:CGRectMake(90, offset + 150, 200, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"体积 "];
    [_mainScroll addSubview:bulkLab];
    meettypeLab = [UILabel createLabelWithFrame:CGRectMake(90, offset + 190, 200, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"交接 "];
    [_mainScroll addSubview:meettypeLab];
    receiptLab = [UILabel createLabelWithFrame:CGRectMake(90, offset + 230, 200, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"回单 "];
    [_mainScroll addSubview:receiptLab];
    protypeLab = [UILabel createLabelWithFrame:CGRectMake(90, offset + 270, 200, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"货物类型 "];
    [_mainScroll addSubview:protypeLab];
    moneyLab = [UILabel createLabelWithFrame:CGRectMake(90, offset + 310, 200, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"价钱 "];
    [_mainScroll addSubview:moneyLab];
    payLab = [UILabel createLabelWithFrame:CGRectMake(90, offset + 350, 200, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"支付 "];
    [_mainScroll addSubview:payLab];
    remarkLab = [UILabel createLabelWithFrame:CGRectMake(90, offset + 390, ScreenWidth - 110, 50) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"啊；圣诞节卡到绿卡河北师大厉害八十多裸婚时代将返回 "];
    remarkLab.numberOfLines = 2;
    [_mainScroll addSubview:remarkLab];
    
    _mainScroll.contentSize = CGSizeMake(ScreenWidth, CGRectGetMaxY(title310.frame)+10);
    [self requestOrderDetail];
    
}

- (void)requestOrderDetail{
    NSString *urlStr = [NSString stringWithFormat:@"http://app.mjxypt.com/api/order/getbyid?id=%@",_orderId];
    [Request getRequestWithUrl:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] params:nil showTips:@"获取详情" tipsType:SVProgressHUDMaskTypeClear sucessBlock:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary *dict = responseObject;
        NSLog(@"%@",dict);
        orderidLab.text = [dict objectForKey:@"OrderNo"];
//        NSMutableString *str = [[dict objectForKey:@"CreateTime"] mutableCopy];
//        if (str.length >0) {
//            
//        }
        dateLab.text = [[dict objectForKey:@"CreateTime"] substringToIndex:16];
        lineLab.text = @"";
        transportationId = [dict objectForKey:@"TransportationId"];
        phoneLab.text = [NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"ShipperContact"],[dict objectForKey:@"ShipperMobile"]];
        
        NSString *sa = @"";
        if (![[dict objectForKey:@"StartAreas"]isEqualToString:@"不限"] || ![[dict objectForKey:@"StartAreas"]isEqualToString:@""]) {
            sa = [dict objectForKey:@"StartAreas"];
        }
        addrLab.text = [NSString stringWithFormat:@"%@ %@ %@ %@",[dict objectForKey:@"StartProvince"],[dict objectForKey:@"StartCity"],sa,[dict objectForKey:@"StartAddr"]];
        
        NSString *aa = @"";
        if (![[dict objectForKey:@"ArrivalAreas"]isEqualToString:@"不限"] || ![[dict objectForKey:@"ArrivalAreas"]isEqualToString:@""]) {
            aa = [dict objectForKey:@"ArrivalAreas"];
        }
        receveLab.text = [NSString stringWithFormat:@"%@ %@      %@ %@ %@ %@",[dict objectForKey:@"ConsigneeContact"],[dict objectForKey:@"ConsigneeMobile"],[dict objectForKey:@"ArrivalProvince"],[dict objectForKey:@"ArrivalCity"],aa,[dict objectForKey:@"ArrivalAddr"]];
        pronameLab.text = [dict objectForKey:@"CargoName"];
        pronumLab.text = [NSString stringWithFormat:@"%i",[[dict objectForKey:@"Qty"] intValue]];
        weightLab.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"Weight"]];
        bulkLab.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"Volume"]];
        meettypeLab.text = [dict objectForKey:@"DeliveryType"];
        receiptLab.text = [dict objectForKey:@"ReceiptReq"];
        protypeLab.text = [dict objectForKey:@"CargoType"];
        moneyLab.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"Freight"]];
        payLab.text = @"未支付";
        remarkLab.text = [dict objectForKey:@"Remark"];
        [self requestlineName]; // 获取承运专线
    } failBlock:^(NSError *error) {
    } successBackFailedBlock:^(id responseObject) {
    }];
}

- (void)requestlineName{
    NSString *urlStr = [NSString stringWithFormat:@"http://app.mjxypt.com/api/line/GetById?lineId=%@",transportationId];
    [Request getRequestWithUrl:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] params:nil showTips:@"获取详情" tipsType:SVProgressHUDMaskTypeClear sucessBlock:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary *dict = responseObject;
        NSLog(@"%@",dict);
        
        lineLab.text = [dict safeObjectForKey:@"CompanyName"];
        
    } failBlock:^(NSError *error) {
    } successBackFailedBlock:^(id responseObject) {
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
