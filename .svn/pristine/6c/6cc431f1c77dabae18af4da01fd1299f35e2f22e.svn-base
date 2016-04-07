//
//  MJCreditableViewController.m
//  MingJia
//
//  Created by admin on 15/12/25.
//  Copyright © 2015年 BCKJ. All rights reserved.
//

#import "MJCreditableViewController.h"
#import "MJServiceViewController.h"
#import "MJComplainViewController.h"
#import "MJLineSearchViewController.h"
#import "MJMyOrderListViewController.h"
#import "MJPTJSViewController.h"
#import "MyAdView.h"
#import "SweepYardVCtr.h"
#import "MJCityTruckViewController.h"
#import "MJSearchResultViewController.h"

@interface MJCreditableViewController ()<UITextFieldDelegate>{
    NSArray      *adArr;
    UIScrollView *mainScroll;
    UITextField  *searchText;
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;

    UIButton *btn4;
    UIButton *btn5;
    UIButton *btn6;
}

@property(nonatomic,strong)MyAdView *myADview;

@end

@implementation MJCreditableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    adArr = [NSArray array];
    self.title = @"明佳信用平台";
    [self drawView];
    [self sendRequestAD];
}

- (void)sendRequestAD{
    NSString *urlStr = [Request getUrlStringWithRequestStr:@"home/getadv"];
    [Request getRequestWithUrl:urlStr params:nil showTips:@"获取广告图片" tipsType:SVProgressHUDMaskTypeClear sucessBlock:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSArray *dict = (NSArray *)responseObject;
        
        adArr = dict;
        NSLog(@"%@",adArr);
        NSLog(@"%@",adArr[0]);
        [self setADViewImages];
        
    } failBlock:^(NSError *error) {
        
    } successBackFailedBlock:^(id responseObject) {
        
    }];
}

- (void)gotoSweepYardVCtr{
    SweepYardVCtr *vc = [[SweepYardVCtr alloc]init];
    [searchText resignFirstResponder];
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)searchList:(id)sender{
    if ([searchText.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"请填写订单号" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    else if (![CheckMethod validateOrderId:searchText.text]){
        [SVProgressHUD showInfoWithStatus:@"请填写13位数字单号" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    
    MJSearchResultViewController *vc = [[MJSearchResultViewController alloc]init];
    vc.orderId = searchText.text;
    [searchText resignFirstResponder];
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)drawView{
    mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenHeight, ScreenHeight - 64 - 48)];
    mainScroll.backgroundColor = CLEAN_COLOR;
    [self.view addSubview:mainScroll];
    
    _myADview = [[MyAdView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, SizeScale(54))];
    [mainScroll addSubview:_myADview];
    
    UIView *searchVl = [UIView createViewWithFrame:CGRectMake(6, SizeScale(54)+5, ScreenWidth/2 - 6, 30) backgroundColor:HEXCOLOR(0x999a9a)];
    [mainScroll addSubview:searchVl];
    searchVl.layer.cornerRadius = 6;
    UIImageView *camImg = [UIImageView createImageViewWithFrame:CGRectMake( 8, 3, 30, 25) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"首页_照相机"]];
    [searchVl addSubview:camImg];
    UIButton *camBtn = [UIButton createButtonwithFrame:camImg.frame backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@""]];
    [camBtn addTarget:self action:@selector(gotoSweepYardVCtr) forControlEvents:UIControlEventTouchUpInside];
    [searchVl addSubview:camBtn];
    
    UIView *searchVr = [UIView createViewWithFrame:CGRectMake(ScreenWidth/2, SizeScale(54)+5, ScreenWidth/2 - 6, 30) backgroundColor:HEXCOLOR(0x3598dc)];
    [mainScroll addSubview:searchVr];
    searchVr.layer.cornerRadius = 6;
    UIImageView *seaImg = [UIImageView createImageViewWithFrame:CGRectMake( ScreenWidth/2 -40, 3, 25, 25) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"首页_搜索"]];
    [searchVr addSubview:seaImg];
    UIButton *searBtn = [UIButton createButtonwithFrame:seaImg.frame backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@""]];
    [searBtn addTarget:self action:@selector(searchList:) forControlEvents:UIControlEventTouchUpInside];
    [searchVr addSubview:searBtn];
    searchText = [UITextField createTextFieldWithFrame:CGRectMake(46, SizeScale(54)+5, ScreenWidth-92, 30) backgroundColor:WHITE_COLOR borderStyle:UITextBorderStyleLine placeholder:@" 输入查询单号" text:@"" textColor:[UIColor blackColor] font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft];
    searchText.delegate = self;
    searchText.layer.borderWidth = 1;
    searchText.layer.borderColor = COLOR_line_HEAD.CGColor;
    [mainScroll addSubview:searchText];
    
    int offset = SizeScale(54)+40;
    UIView *view1 = [UIView createViewWithFrame:CGRectMake(6, offset, ScreenWidth/2-9, SizeScale(118)) backgroundColor:HEXCOLOR(0xf49c14)];
    view1.layer.cornerRadius = 6;
    [mainScroll addSubview:view1];
    UIImageView *icon1 = [UIImageView createImageViewWithFrame:CGRectMake(0, 0, 30, 30) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"二维码"]];
    icon1.frame = CGRectMake(ScreenWidth/4 - 18, SizeScale(35), 30, 30);
    [view1 addSubview:icon1];
    btn1 = [UIButton createButtonwithFrame:view1.bounds backgroundColor:CLEAN_COLOR conrnerRadius:0 borderWidth:0 borderColor:CLEAN_COLOR];
    [btn1 setTitle:@"平台介绍" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btn1Action) forControlEvents:UIControlEventTouchUpInside];
    btn1.titleLabel.font = SYSTEM_FONT_(14);
    [btn1 setTitleEdgeInsets:UIEdgeInsetsMake(40, 0, 0, 0)];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [view1 addSubview:btn1];
    
    UIView *view2 = [UIView createViewWithFrame:CGRectMake(ScreenWidth/2 +3, offset, ScreenWidth/2-9, SizeScale(118)) backgroundColor:HEXCOLOR(0x61a6c3)];
    view2.layer.cornerRadius = 6;
    [mainScroll addSubview:view2];
    UIImageView *icon2 = [UIImageView createImageViewWithFrame:CGRectMake(0, 0, 30, 30) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"评价"]];
    icon2.frame = CGRectMake(ScreenWidth/4 - 18, SizeScale(35), 30, 30);
    [view2 addSubview:icon2];
    btn2 = [UIButton createButtonwithFrame:view2.bounds backgroundColor:CLEAN_COLOR conrnerRadius:0 borderWidth:0 borderColor:CLEAN_COLOR];
    [btn2 setTitle:@"信用评价" forState:UIControlStateNormal];
    btn2.titleLabel.font = SYSTEM_FONT_(14);
    [btn2 addTarget:self action:@selector(gotomyOrder:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitleEdgeInsets:UIEdgeInsetsMake(40, 0, 0, 0)];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [view2 addSubview:btn2];
    
    offset +=SizeScale(118)+6;
    UIView *view3 = [UIView createViewWithFrame:CGRectMake(6, offset, ScreenWidth/2-9, SizeScale(118)) backgroundColor:HEXCOLOR(0x999a9a)];
    view3.layer.cornerRadius = 6;
    [mainScroll addSubview:view3];
    UIImageView *icon3 = [UIImageView createImageViewWithFrame:CGRectMake(0, 0, 30, 30) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"查询"]];
    icon3.frame = CGRectMake(ScreenWidth/4 - 18, SizeScale(35), 30, 30);
    [view3 addSubview:icon3];
    btn3 = [UIButton createButtonwithFrame:view3.bounds backgroundColor:CLEAN_COLOR conrnerRadius:0 borderWidth:0 borderColor:CLEAN_COLOR];
    [btn3 setTitle:@"专线查询" forState:UIControlStateNormal];
    btn3.titleLabel.font = SYSTEM_FONT_(14);
    [btn3 addTarget:self action:@selector(btn3Action) forControlEvents:UIControlEventTouchUpInside];
    [btn3 setTitleEdgeInsets:UIEdgeInsetsMake(40, 0, 0, 0)];
    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [view3 addSubview:btn3];
    
    UIView *view4 = [UIView createViewWithFrame:CGRectMake(ScreenWidth/2 +3, offset, ScreenWidth/2-9, SizeScale(118)) backgroundColor:HEXCOLOR(0x3598dc)];
    view4.layer.cornerRadius = 6;
    [mainScroll addSubview:view4];
    UIImageView *icon4 = [UIImageView createImageViewWithFrame:CGRectMake(0, 0, 30, 30) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"电话"]];
    icon4.frame = CGRectMake(ScreenWidth/4 - 18, SizeScale(35), 30, 30);
    [view4 addSubview:icon4];
    btn4 = [UIButton createButtonwithFrame:view4.bounds backgroundColor:CLEAN_COLOR conrnerRadius:0 borderWidth:0 borderColor:CLEAN_COLOR];
    [btn4 setTitle:@"会员投诉" forState:UIControlStateNormal];
    btn4.tag = 1001;
    [btn4 addTarget:self action:@selector(gotocomplain:) forControlEvents:UIControlEventTouchUpInside];
    btn4.titleLabel.font = SYSTEM_FONT_(14);
    [btn4 setTitleEdgeInsets:UIEdgeInsetsMake(40, 0, 0, 0)];
    [btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [view4 addSubview:btn4];
    
    offset +=SizeScale(118)+6;
    UIView *view5 = [UIView createViewWithFrame:CGRectMake(6, offset, ScreenWidth/2-9, SizeScale(118)) backgroundColor:HEXCOLOR(0xed6900)];
    view5.layer.cornerRadius = 6;
    [mainScroll addSubview:view5];
    UIImageView *icon5 = [UIImageView createImageViewWithFrame:CGRectMake(0, 0, 30, 30) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"投诉w"]];
    icon5.frame = CGRectMake(ScreenWidth/4 - 18, SizeScale(35), 30, 30);
    [view5 addSubview:icon5];
    btn5 = [UIButton createButtonwithFrame:view5.bounds backgroundColor:CLEAN_COLOR conrnerRadius:0 borderWidth:0 borderColor:CLEAN_COLOR];
    [btn5 setTitle:@"专线投诉" forState:UIControlStateNormal];
    btn5.tag = 1002;
    [btn5 addTarget:self action:@selector(gotocomplain:) forControlEvents:UIControlEventTouchUpInside];
    btn5.titleLabel.font = SYSTEM_FONT_(14);
    [btn5 setTitleEdgeInsets:UIEdgeInsetsMake(40, 0, 0, 0)];
    [btn5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [view5 addSubview:btn5];
    
    UIView *view6 = [UIView createViewWithFrame:CGRectMake(ScreenWidth/2 +3, offset, ScreenWidth/2-9, SizeScale(118)) backgroundColor:HEXCOLOR(0x636568)];
    view6.layer.cornerRadius = 6;
    [mainScroll addSubview:view6];
    UIImageView *icon6 = [UIImageView createImageViewWithFrame:CGRectMake(0, 0, 30, 30) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"公告"]];
    icon6.frame = CGRectMake(ScreenWidth/4 - 18, SizeScale(35), 30, 30);
    [view6 addSubview:icon6];
    btn6 = [UIButton createButtonwithFrame:view6.bounds backgroundColor:CLEAN_COLOR conrnerRadius:0 borderWidth:0 borderColor:CLEAN_COLOR];
    [btn6 addTarget:self action:@selector(gotogonggao) forControlEvents:UIControlEventTouchUpInside];
    [btn6 setTitle:@"投诉公告" forState:UIControlStateNormal];
    btn6.titleLabel.font = SYSTEM_FONT_(14);
    [btn6 setTitleEdgeInsets:UIEdgeInsetsMake(40, 0, 0, 0)];
    [btn6 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [view6 addSubview:btn6];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [searchText resignFirstResponder];
    return YES;
}

- (void)resignFirst{
    [searchText resignFirstResponder];
}

- (void)gotogonggao{
    MJCityTruckViewController *vc = [[MJCityTruckViewController alloc]init];
    [self resignFirst];
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)btn1Action{
    MJPTJSViewController *vc = [[MJPTJSViewController alloc]init];
    [self resignFirst];
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)gotomyOrder:(id)sender{
    MJMyOrderListViewController *vc = [[MJMyOrderListViewController alloc]init];
    [self resignFirst];
    vc.selected = 3;
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)gotocomplain:(id)sender{
    MJComplainViewController *vc = [[MJComplainViewController alloc]init];
    [self resignFirst];
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)btn3Action{
    MJLineSearchViewController *vc = [[MJLineSearchViewController alloc]init];
    vc.searchType = SEARCHORDERTYPE;  // 查询
    [self resignFirst];
    [self.navigationController pushViewController:vc animated:NO];
}

-(void)setADViewImages
{
    NSMutableArray *adImageArray=[[NSMutableArray alloc]init];
    
    for (NSInteger i = 0; i<[adArr count]; i++) {
        [adImageArray addObject:adArr[i]];
    }
    [_myADview drawAdViewWithNameArray:nil urlArray:adImageArray animationDurtion:3];
}

@end
