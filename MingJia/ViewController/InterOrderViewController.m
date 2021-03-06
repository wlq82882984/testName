//
//  InterOrderViewController.m
//  MingJia
//
//  Created by admin on 15/12/30.
//  Copyright © 2015年 BCKJ. All rights reserved.
//

#import "InterOrderViewController.h"
#import "MJInterOrderDefultViewController.h"
#import "MJZhuanXianCell.h"

@interface InterOrderViewController ()<ZhuanxianChooseDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>{
    UITextField *companyTxt;
    
    NSMutableArray *arrList;
}

@property(nonatomic,strong)UITableView *mainTabV;

@end

@implementation InterOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"路线查询";
    arrList = [NSMutableArray array];
    [self drawView];
    _mainTabV = [UITableView createTableViewWithFrame:CGRectMake(0, 90, ScreenWidth, ScreenHeight - 64-90) style:UITableViewStylePlain backgroundColor:CLEAN_COLOR delegate:self dataSource:self];
    [_mainTabV setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_mainTabV];
    
    [self requestgetcol]; // 获取收藏列表
}

//http://app.mjxypt.com/api/line/my?companyid=a1fae7f0-8a32-4d66-a572-5d2c3d82d8ac
- (void)requestgetcol{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *urlStr = [NSString stringWithFormat:@"http://app.mjxypt.com/api/line/my?companyid=%@",[[user objectForKey:@"UserLogin"] objectForKey:@"userId"]];
        [Request getRequestWithUrl:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] params:nil showTips:@"查询" tipsType:SVProgressHUDMaskTypeClear sucessBlock:^(id responseObject) {
            [SVProgressHUD dismiss];
            NSArray *dict = (NSArray *)responseObject;
            arrList = [dict mutableCopy];
            [_mainTabV reloadData];
        } failBlock:^(NSError *error) {
            
        } successBackFailedBlock:^(id responseObject) {
            
        }];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [companyTxt resignFirstResponder];
}

- (void)drawView{
    UILabel *title = [UILabel createLabelWithFrame:CGRectMake(20, 13, 70, 14) backgroundColor:CLEAN_COLOR textColor:[UIColor blackColor] font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@"公司名称"];
    [self.view addSubview:title];
    UILabel *tapline = [UILabel createLabelWithFrame:CGRectMake(5, 40, ScreenWidth -10, 1) backgroundColor:COLOR_line_HEAD textColor:BACK_COLL_HEAD font:SYSTEM_FONT_(14) textalignment:NSTextAlignmentLeft text:@""];
    [self.view addSubview:tapline];
    
    companyTxt = [UITextField createTextFieldWithFrame:CGRectMake(90, 0, ScreenWidth - 120, 40) backgroundColor:CLEAN_COLOR borderStyle:UITextBorderStyleNone placeholder:@"请输入物流公司" text:@"" textColor:[UIColor blackColor] font:SYSTEM_FONT_(16) textalignment:NSTextAlignmentLeft];
    companyTxt.delegate = self;
    [self.view addSubview:companyTxt];
    
    UIButton *searchBtn = [UIButton createButtonwithFrame:CGRectMake(10, CGRectGetMaxY(tapline.frame) +10, ScreenWidth - 20, 40) backgroundColor:TABBAR_TEXT_COLOR_SEL image:[UIImage imageNamed:@""]];
    [searchBtn addTarget:self action:@selector(gotosasa) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setTitle:@"查询" forState:UIControlStateNormal];
    [searchBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    searchBtn.layer.cornerRadius = 5;
    [self.view addSubview:searchBtn];
}

//http://app.mjxypt.com/api/line/getbyname?companyName=
- (void)gotosasa{
    [companyTxt resignFirstResponder];
//    MJInterOrderDefultViewController *vc = [[MJInterOrderDefultViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:NO];
    if (companyTxt.text.length == 0) {
        [self requestgetcol];
        return;
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"http://app.mjxypt.com/api/line/getbyname?companyName=%@",companyTxt.text];
    [Request getRequestWithUrl:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] params:nil showTips:@"查询" tipsType:SVProgressHUDMaskTypeClear sucessBlock:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSArray *dict = (NSArray *)responseObject;
        [arrList removeAllObjects];
        arrList = [dict mutableCopy];
        [_mainTabV reloadData];
    } failBlock:^(NSError *error) {
        
    } successBackFailedBlock:^(id responseObject) {
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [companyTxt resignFirstResponder];
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrList.count;
}

- (void)order:(NSInteger)indexRow{
    NSLog(@"选的是%li",indexRow);
    NSDictionary *model = arrList[indexRow];
    MJInterOrderDefultViewController *vc = [[MJInterOrderDefultViewController alloc]init];
    vc.lineId = [model objectForKey:@"LineId"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[model objectForKey:@"StartProvince"] forKey:@"StartProvince"];
    [dic setObject:[model objectForKey:@"StartCity"] forKey:@"StartCity"];
    [dic setObject:[model objectForKey:@"StartAreas"] forKey:@"StartAreas"];
    [dic setObject:[model objectForKey:@"ArrivalProvince"] forKey:@"ArrivalProvince"];
    [dic setObject:[model objectForKey:@"ArrivalCity"] forKey:@"ArrivalCity"];
    [dic setObject:[model objectForKey:@"ArrivalAreas"] forKey:@"ArrivalAreas"];
    vc.placeDic = dic;
    [self.navigationController pushViewController:vc animated:NO];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *model = arrList[indexPath.row];
    MJZhuanXianCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[MJZhuanXianCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.delegate = self;
    cell.indexRow = indexPath.row;
    cell.comNameLab.text = [model objectForKey:@"CompanyName"];
    cell.nameLab.text = [model objectForKey:@"StartContact"];
    cell.rankStar = [[model objectForKey:@"Synthetic"]intValue];
    cell.phoneLab = [model objectForKey:@"StartMobile"];
    cell.teleLab = [model objectForKey:@"StartTel"];
    NSString *s = [model objectForKey:@"StartCity"];
    NSString *a = [model objectForKey:@"ArrivalCity"];
    if ([[model objectForKey:@"StartCity"]isEqualToString:@""]) {
        s = [model objectForKey:@"StartProvince"];
    }
    if ([[model objectForKey:@"ArrivalCity"]isEqualToString:@""]) {
        a = [model objectForKey:@"ArrivalProvince"];
    }
    cell.lineLab.text = [NSString stringWithFormat:@"%@-->%@",s,a];
    cell.addressLab.text = [model objectForKey:@"StartAddr"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//  打电话
//    NSDictionary *model = arrList[indexPath.row];
//    NSString *phoneNo = [model objectForKey:@"StartMobile"];
//    if (![phoneNo isEqualToString:@""]) {
//        [self tele:phoneNo];
//    }
//    else {
//        return;
//    }
}

- (void)daphone:(NSInteger)indexRow{
    NSDictionary *model = arrList[indexRow];
    NSString *phoneNo = [model objectForKey:@"StartMobile"];
    if (![phoneNo isEqualToString:@""]) {
        [self tele:phoneNo];
    }
    else {
        return;
    }
}

@end
