//
//  MJEvaluationViewController.m
//  MingJia
//
//  Created by admin on 15/12/31.
//  Copyright © 2015年 BCKJ. All rights reserved.
//   http://app.mjxypt.com/api/order/rate

#import "MJEvaluationViewController.h"

@interface MJEvaluationViewController ()<UITextFieldDelegate>{
    UIScrollView      *mainScroll;
    
    UILabel     *orderidLab;
    UILabel     *compnameLab;
    UILabel     *dataLab;
    
    UIButton    *speedBtn1;
    UIButton    *speedBtn2;
    UIButton    *speedBtn3;
    UIButton    *speedBtn4;
    UIButton    *speedBtn5;
    UIButton    *serverBtn1;
    UIButton    *serverBtn2;
    UIButton    *serverBtn3;
    UIButton    *serverBtn4;
    UIButton    *serverBtn5;
    UIButton    *priceBtn1;
    UIButton    *priceBtn2;
    UIButton    *priceBtn3;
    UIButton    *priceBtn4;
    UIButton    *priceBtn5;
    UIButton    *qualitBtn1;
    UIButton    *qualitBtn2;
    UIButton    *qualitBtn3;
    UIButton    *qualitBtn4;
    UIButton    *qualitBtn5;
    
    UITextField *describetxt;
    
    int          speedLeve;
    int          serverLeve;
    int          priceLeve;
    int          qualitLeve;
}

@end

@implementation MJEvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价";
    mainScroll = [[UIScrollView alloc]init];
    mainScroll.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64);
    [self.view addSubview:mainScroll];
    mainScroll.contentSize = CGSizeMake(ScreenWidth, 500);
    UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignFirst)];
    mainScroll.userInteractionEnabled=YES;
    [mainScroll addGestureRecognizer:Tap];
    [self drawView];
}

- (void)resignFirst{
    [describetxt resignFirstResponder];
}

- (void)requestgetComName{
    NSString *urlStr = [NSString stringWithFormat:@"http://app.mjxypt.com/api/line/GetById?lineId=%@",_lineId];
    [Request getRequestWithUrl:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] params:nil showTips:@"查询" tipsType:SVProgressHUDMaskTypeClear sucessBlock:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary *dict = responseObject;
        compnameLab.text = [dict objectForKey:@"CompanyName"];
    } failBlock:^(NSError *error) {
        
    } successBackFailedBlock:^(id responseObject) {
        
    }];

}

- (void)requestInfo{  // 查询信息的界面信息装填
    NSString *urlStr = [NSString stringWithFormat:@"http://app.mjxypt.com/api/order/getbyid?id=%@",_orderId];
    [Request getRequestWithUrl:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] params:nil showTips:@"查询" tipsType:SVProgressHUDMaskTypeClear sucessBlock:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary *dict = responseObject;
        orderidLab.text = [dict objectForKey:@"OrderNo"];
        compnameLab.text = @"";
        
        NSString * V = @"";
        NSString * W = @"";
        if ([[dict objectForKey:@"Volume"] floatValue]>0) {
            V = [NSString stringWithFormat:@"%@方",[dict objectForKey:@"Volume"]];
        }
        if ([[dict objectForKey:@"Weight"] floatValue]>0) {
            W = [NSString stringWithFormat:@"%@吨",[dict objectForKey:@"Weight"]];
        }
        dataLab.text = [NSString stringWithFormat:@"%@ %@ %@",[dict objectForKey:@"CargoName"],V,W];
        _lineId = [dict objectForKey:@"TransportationId"];
        
        [self requestgetComName];
    } failBlock:^(NSError *error) {
        
    } successBackFailedBlock:^(id responseObject) {
        
    }];
    
}

- (void)drawView{
    int offset = 0;
    
    //    订单信息
    UIView *view1 = [UIView createViewWithFrame:CGRectMake(0, offset, ScreenWidth, 30) backgroundColor:BACK_COLL_HEAD];
    [mainScroll addSubview:view1];
    
    //    订单信息
    UILabel *viewlab1 = [UILabel createLabelWithFrame:CGRectMake(0, 0, ScreenWidth, 30) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"  订单信息"];
    [view1 addSubview:viewlab1];
    
    UILabel *title01 = [UILabel createLabelWithFrame:CGRectMake(10, offset + 30, 50, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"单号:"];
    [mainScroll addSubview:title01];
    compnameLab = [UILabel createLabelWithFrame:CGRectMake(10, offset + 70, ScreenWidth - 40, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@""];
    [mainScroll addSubview:compnameLab];
    UILabel *title03 = [UILabel createLabelWithFrame:CGRectMake(10, offset + 110, 50, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"详情:"];
    [mainScroll addSubview:title03];
    
    orderidLab = [UILabel createLabelWithFrame:CGRectMake(50, offset + 30, ScreenWidth - 100, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@""];
    [mainScroll addSubview:orderidLab];
    dataLab = [UILabel createLabelWithFrame:CGRectMake(50, offset + 110, ScreenWidth - 100, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@""];
    [mainScroll addSubview:dataLab];
    
    offset += 150;
    
    //    信用评价
    UIView *view2 = [UIView createViewWithFrame:CGRectMake(0, offset, ScreenWidth, 30) backgroundColor:BACK_COLL_HEAD];
    [mainScroll addSubview:view2];
    UILabel *viewlab2 = [UILabel createLabelWithFrame:CGRectMake(0, 0, ScreenWidth, 30) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"  信用评价"];
    [view2 addSubview:viewlab2];
    
    UILabel *title11 = [UILabel createLabelWithFrame:CGRectMake(10, offset + 30, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"速度:"];
    [mainScroll addSubview:title11];
    UILabel *title12 = [UILabel createLabelWithFrame:CGRectMake(10, offset + 70, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"服务:"];
    [mainScroll addSubview:title12];
    UILabel *title13 = [UILabel createLabelWithFrame:CGRectMake(10, offset + 110, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"价格:"];
    [mainScroll addSubview:title13];
    UILabel *title14 = [UILabel createLabelWithFrame:CGRectMake(10, offset + 150, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"质量:"];
    [mainScroll addSubview:title14];
    UILabel *title15 = [UILabel createLabelWithFrame:CGRectMake(10, offset + 190, 80, 40) backgroundColor:CLEAN_COLOR textColor:Color_font_dark font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentRight text:@"描述:"];
    [mainScroll addSubview:title15];

    describetxt = [UITextField createTextFieldWithFrame:CGRectMake(90, offset + 190, ScreenWidth - 110, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"说点什么吧" text:@"" textColor:[UIColor blackColor] font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft];
    describetxt.delegate = self;
    [mainScroll addSubview:describetxt];
    [self setBtn];
    
    UIButton *btn = [UIButton createButtonwithFrame:CGRectMake(20, 400, ScreenWidth -40, 40) backgroundColor:TABBAR_TEXT_COLOR_SEL image:[UIImage imageNamed:@""]];
    btn.layer.cornerRadius = 5;
    [btn setTitle:@"立即评价" forState:UIControlStateNormal];
    [btn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(evalAction) forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:btn];
    
    [self requestInfo];
}

- (void)setBtn{
    speedBtn1 = [UIButton createButtonwithFrame:CGRectMake(90, 188, 20, 20) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_评价"]];
    speedBtn1.tag = 101;
    [speedBtn1 addTarget:self action:@selector(speedLeve:) forControlEvents:UIControlEventTouchUpInside];
    speedBtn2 = [UIButton createButtonwithFrame:CGRectMake(115, 188, 20, 20) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_评价"]];
    speedBtn2.tag = 102;
    [speedBtn2 addTarget:self action:@selector(speedLeve:) forControlEvents:UIControlEventTouchUpInside];
    speedBtn3 = [UIButton createButtonwithFrame:CGRectMake(140, 188, 20, 20) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_评价"]];
    speedBtn3.tag = 103;
    [speedBtn3 addTarget:self action:@selector(speedLeve:) forControlEvents:UIControlEventTouchUpInside];
    speedBtn4 = [UIButton createButtonwithFrame:CGRectMake(165, 188, 20, 20) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_评价"]];
    speedBtn4.tag = 104;
    [speedBtn4 addTarget:self action:@selector(speedLeve:) forControlEvents:UIControlEventTouchUpInside];
    speedBtn5 = [UIButton createButtonwithFrame:CGRectMake(190, 188, 20, 20) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_评价"]];
    speedBtn5.tag = 105;
    [speedBtn5 addTarget:self action:@selector(speedLeve:) forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:speedBtn1];
    [mainScroll addSubview:speedBtn2];
    [mainScroll addSubview:speedBtn3];
    [mainScroll addSubview:speedBtn4];
    [mainScroll addSubview:speedBtn5];
    
    serverBtn1 = [UIButton createButtonwithFrame:CGRectMake(90, 228, 20, 20) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_评价"]];
    serverBtn1.tag = 201;
    [serverBtn1 addTarget:self action:@selector(serverLeve:) forControlEvents:UIControlEventTouchUpInside];
    serverBtn2 = [UIButton createButtonwithFrame:CGRectMake(115, 228, 20, 20) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_评价"]];
    serverBtn2.tag = 202;
    [serverBtn2 addTarget:self action:@selector(serverLeve:) forControlEvents:UIControlEventTouchUpInside];
    serverBtn3 = [UIButton createButtonwithFrame:CGRectMake(140, 228, 20, 20) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_评价"]];
    serverBtn3.tag = 203;
    [serverBtn3 addTarget:self action:@selector(serverLeve:) forControlEvents:UIControlEventTouchUpInside];
    serverBtn4 = [UIButton createButtonwithFrame:CGRectMake(165, 228, 20, 20) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_评价"]];
    serverBtn4.tag = 204;
    [serverBtn4 addTarget:self action:@selector(serverLeve:) forControlEvents:UIControlEventTouchUpInside];
    serverBtn5 = [UIButton createButtonwithFrame:CGRectMake(190, 228, 20, 20) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_评价"]];
    serverBtn5.tag = 205;
    [serverBtn5 addTarget:self action:@selector(serverLeve:) forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:serverBtn1];
    [mainScroll addSubview:serverBtn2];
    [mainScroll addSubview:serverBtn3];
    [mainScroll addSubview:serverBtn4];
    [mainScroll addSubview:serverBtn5];
    
    priceBtn1 = [UIButton createButtonwithFrame:CGRectMake(90, 268, 20, 20) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_评价"]];
    priceBtn1.tag = 301;
    [priceBtn1 addTarget:self action:@selector(priceLeve:) forControlEvents:UIControlEventTouchUpInside];
    priceBtn2 = [UIButton createButtonwithFrame:CGRectMake(115, 268, 20, 20) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_评价"]];
    priceBtn2.tag = 302;
    [priceBtn2 addTarget:self action:@selector(priceLeve:) forControlEvents:UIControlEventTouchUpInside];
    priceBtn3 = [UIButton createButtonwithFrame:CGRectMake(140, 268, 20, 20) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_评价"]];
    priceBtn3.tag = 303;
    [priceBtn3 addTarget:self action:@selector(priceLeve:) forControlEvents:UIControlEventTouchUpInside];
    priceBtn4 = [UIButton createButtonwithFrame:CGRectMake(165, 268, 20, 20) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_评价"]];
    priceBtn4.tag = 304;
    [priceBtn4 addTarget:self action:@selector(priceLeve:) forControlEvents:UIControlEventTouchUpInside];
    priceBtn5 = [UIButton createButtonwithFrame:CGRectMake(190, 268, 20, 20) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_评价"]];
    priceBtn5.tag = 305;
    [priceBtn5 addTarget:self action:@selector(priceLeve:) forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:priceBtn1];
    [mainScroll addSubview:priceBtn2];
    [mainScroll addSubview:priceBtn3];
    [mainScroll addSubview:priceBtn4];
    [mainScroll addSubview:priceBtn5];
    
    qualitBtn1 = [UIButton createButtonwithFrame:CGRectMake(90, 308, 20, 20) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_评价"]];
    qualitBtn1.tag = 401;
    [qualitBtn1 addTarget:self action:@selector(qualitLeve:) forControlEvents:UIControlEventTouchUpInside];
    qualitBtn2 = [UIButton createButtonwithFrame:CGRectMake(115, 308, 20, 20) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_评价"]];
    qualitBtn2.tag = 402;
    [qualitBtn2 addTarget:self action:@selector(qualitLeve:) forControlEvents:UIControlEventTouchUpInside];
    qualitBtn3 = [UIButton createButtonwithFrame:CGRectMake(140, 308, 20, 20) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_评价"]];
    qualitBtn3.tag = 403;
    [qualitBtn3 addTarget:self action:@selector(qualitLeve:) forControlEvents:UIControlEventTouchUpInside];
    qualitBtn4 = [UIButton createButtonwithFrame:CGRectMake(165, 308, 20, 20) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_评价"]];
    qualitBtn4.tag = 404;
    [qualitBtn4 addTarget:self action:@selector(qualitLeve:) forControlEvents:UIControlEventTouchUpInside];
    qualitBtn5 = [UIButton createButtonwithFrame:CGRectMake(190, 308, 20, 20) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"线路_评价"]];
    qualitBtn5.tag = 405;
    [qualitBtn5 addTarget:self action:@selector(qualitLeve:) forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:qualitBtn1];
    [mainScroll addSubview:qualitBtn2];
    [mainScroll addSubview:qualitBtn3];
    [mainScroll addSubview:qualitBtn4];
    [mainScroll addSubview:qualitBtn5];

}

- (void)speedLeve:(id)sender{
    UIButton *btn = (UIButton *)sender;
    int i = (int)btn.tag - 100;
    speedLeve = i;
    switch (i) {
        case 1:
        {
            [speedBtn1 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [speedBtn2 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
            [speedBtn3 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
            [speedBtn4 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
            [speedBtn5 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
            [speedBtn1 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [speedBtn2 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [speedBtn3 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
            [speedBtn4 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
            [speedBtn5 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
        }
            break;
        case 3:
        {
            [speedBtn1 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [speedBtn2 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [speedBtn3 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [speedBtn4 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
            [speedBtn5 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
        }
            break;
        case 4:
        {
            [speedBtn1 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [speedBtn2 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [speedBtn3 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [speedBtn4 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [speedBtn5 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
        }
            break;
        case 5:
        {
            [speedBtn1 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [speedBtn2 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [speedBtn3 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [speedBtn4 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [speedBtn5 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
}

- (void)serverLeve:(id)sender{
    UIButton *btn = (UIButton *)sender;
    int i = (int)btn.tag - 200;
    serverLeve = i;
    switch (i) {
        case 1:
        {
            [serverBtn1 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [serverBtn2 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
            [serverBtn3 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
            [serverBtn4 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
            [serverBtn5 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
            [serverBtn1 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [serverBtn2 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [serverBtn3 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
            [serverBtn4 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
            [serverBtn5 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
        }
            break;
        case 3:
        {
            [serverBtn1 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [serverBtn2 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [serverBtn3 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [serverBtn4 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
            [serverBtn5 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
        }
            break;
        case 4:
        {
            [serverBtn1 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [serverBtn2 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [serverBtn3 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [serverBtn4 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [serverBtn5 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
        }
            break;
        case 5:
        {
            [serverBtn1 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [serverBtn2 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [serverBtn3 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [serverBtn4 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [serverBtn5 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
}

- (void)priceLeve:(id)sender{
    UIButton *btn = (UIButton *)sender;
    int i = (int)btn.tag - 300;
    priceLeve = i;
    switch (i) {
        case 1:
        {
            [priceBtn1 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [priceBtn2 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
            [priceBtn3 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
            [priceBtn4 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
            [priceBtn5 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
            [priceBtn1 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [priceBtn2 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [priceBtn3 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
            [priceBtn4 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
            [priceBtn5 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
        }
            break;
        case 3:
        {
            [priceBtn1 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [priceBtn2 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [priceBtn3 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [priceBtn4 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
            [priceBtn5 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
        }
            break;
        case 4:
        {
            [priceBtn1 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [priceBtn2 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [priceBtn3 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [priceBtn4 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [priceBtn5 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
        }
            break;
        case 5:
        {
            [priceBtn1 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [priceBtn2 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [priceBtn3 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [priceBtn4 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [priceBtn5 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
}

- (void)qualitLeve:(id)sender{
    UIButton *btn = (UIButton *)sender;
    int i = (int)btn.tag - 400;
    qualitLeve = i;
    switch (i) {
        case 1:
        {
            [qualitBtn1 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [qualitBtn2 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
            [qualitBtn3 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
            [qualitBtn4 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
            [qualitBtn5 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
            [qualitBtn1 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [qualitBtn2 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [qualitBtn3 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
            [qualitBtn4 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
            [qualitBtn5 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
        }
            break;
        case 3:
        {
            [qualitBtn1 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [qualitBtn2 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [qualitBtn3 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [qualitBtn4 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
            [qualitBtn5 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
        }
            break;
        case 4:
        {
            [qualitBtn1 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [qualitBtn2 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [qualitBtn3 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [qualitBtn4 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [qualitBtn5 setImage:[UIImage imageNamed:@"线路_评价"] forState:UIControlStateNormal];
        }
            break;
        case 5:
        {
            [qualitBtn1 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [qualitBtn2 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [qualitBtn3 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [qualitBtn4 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
            [qualitBtn5 setImage:[UIImage imageNamed:@"实心评价"] forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
}

- (void)evalAction{
    if (speedLeve == 0) {
        [SVProgressHUD showInfoWithStatus:@"请对速度进行评价" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    if (serverLeve == 0) {
        [SVProgressHUD showInfoWithStatus:@"请对服务进行评价" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    if (priceLeve == 0) {
        [SVProgressHUD showInfoWithStatus:@"请对价格进行评价" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    if (qualitLeve == 0) {
        [SVProgressHUD showInfoWithStatus:@"请对质量进行评价" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    if (describetxt.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"说点什么呗😊" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    [self requestPingjia];
}

//  http://app.mjxypt.com/api/order/rate
- (void)requestPingjia{
    NSString *urlStr = [Request getUrlStringWithRequestStr:@"order/rate"];
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:_orderId forKey:@"orderId"];
    [dict setObject:[NSString stringWithFormat:@"%i",speedLeve] forKey:@"rate1"];
    [dict setObject:[NSString stringWithFormat:@"%i",serverLeve] forKey:@"rate2"];
    [dict setObject:[NSString stringWithFormat:@"%i",priceLeve] forKey:@"rate3"];
    [dict setObject:[NSString stringWithFormat:@"%i",qualitLeve] forKey:@"rate4"];
    [dict setObject:describetxt.text forKey:@"remark"];
    
    [Request postRequestWithUrl:urlStr params:dict showTips:@"正在申请...." tipsType:SVProgressHUDMaskTypeBlack sucessBlock:^(id responseObject) {
        NSDictionary *dict = responseObject;
        if ([[dict objectForKey:@"Code"]integerValue] == 0) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Message"]] maskType:SVProgressHUDMaskTypeClear];
        }
        if ([[dict objectForKey:@"Code"]integerValue] == 1) {
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Message"]] maskType:SVProgressHUDMaskTypeClear];
            [self.navigationController popViewControllerAnimated:NO];
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
