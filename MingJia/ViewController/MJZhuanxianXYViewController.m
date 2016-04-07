//
//  MJZhuanxianXYViewController.m
//  MingJia
//
//  Created by admin on 16/1/5.
//  Copyright © 2016年 BCKJ. All rights reserved.
//   http://app.mjxypt.com/api/line/get?sp=&sc=&sa=&ap=&ac=&aa=&cn=

#import "MJZhuanxianXYViewController.h"
#import "MJInterOrderDefultViewController.h"
#import "SpecificLineCell.h"

@interface MJZhuanxianXYViewController ()<UITableViewDataSource,UITableViewDelegate,SpecificChooseDelegate>{

    NSMutableArray    *arrlist;
    NSMutableArray    *arrcoll;
}

@property(nonatomic,strong)UITableView *myTabview;

@end

@implementation MJZhuanxianXYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrlist = [NSMutableArray array];
    arrcoll = [NSMutableArray array];
    self.title = @"专线信用列表";
    [self drawView];
    [self requestgetline];
}

- (void)requestgetline{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[_placeDic safeObjectForKey:@"StartProvince"] forKey:@"sp"];
    [dic setObject:[_placeDic safeObjectForKey:@"StartCity"] forKey:@"sc"];
    [dic setObject:[_placeDic safeObjectForKey:@"StartAreas"] forKey:@"sa"];
    if ([dic objectForKey:@"sa"]) {
        [dic setObject:@"" forKey:@"sa"];
    }
    [dic setObject:[_placeDic safeObjectForKey:@"ArrivalProvince"] forKey:@"ap"];
    [dic setObject:[_placeDic safeObjectForKey:@"ArrivalCity"] forKey:@"ac"];
    [dic setObject:[_placeDic safeObjectForKey:@"ArrivalAreas"] forKey:@"aa"];
    if ([dic objectForKey:@"aa"]) {
        [dic setObject:@"" forKey:@"aa"];
    }
    [dic setObject:[_placeDic safeObjectForKey:@"cnName"] forKey:@"cn"];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://app.mjxypt.com/api/line/get?sp=%@&sc=%@&sa=%@&ap=%@&ac=%@&aa=%@&cn=%@",[dic objectForKey:@"sp"],[dic objectForKey:@"sc"],[dic objectForKey:@"sa"],[dic objectForKey:@"ap"],[dic objectForKey:@"ac"],[dic objectForKey:@"aa"],[dic objectForKey:@"cn"]];
    
    [Request getRequestWithUrl:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] params:nil showTips:@"查询" tipsType:SVProgressHUDMaskTypeClear sucessBlock:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSArray *dict = (NSArray *)responseObject;
        NSLog(@"%@",dict);
        arrlist = [dict mutableCopy];
        [_myTabview reloadData];
        
        
    } failBlock:^(NSError *error) {
        
    } successBackFailedBlock:^(id responseObject) {
        
    }];
}

- (void)drawView{
    _myTabview = [UITableView createTableViewWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain backgroundColor:CLEAN_COLOR delegate:self dataSource:self];
    [_myTabview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_myTabview];
}

- (void)deCollect:(NSInteger)indexRow{
    NSLog(@"收藏的%i",(int)indexRow);
    [self requestcollline:(int)indexRow];  //LineId
}

- (void)requestcollline:(int)row{
    NSDictionary *model = arrlist[row];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *urlStr = [NSString stringWithFormat:@"http://app.mjxypt.com/api/line/fav?companyId=%@&lineId=%@",[[user objectForKey:@"UserLogin"] objectForKey:@"userId"],[model objectForKey:@"LineId"]];

    [Request getRequestWithUrl:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] params:nil showTips:@"添加收藏" tipsType:SVProgressHUDMaskTypeClear sucessBlock:^(id responseObject) {
//        [SVProgressHUD dismiss];
        NSDictionary *dict = responseObject;
        if ([[dict objectForKey:@"Code"]integerValue] == 0) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Message"]] maskType:SVProgressHUDMaskTypeClear];
        }
        if ([[dict objectForKey:@"Code"]integerValue] == 1) {
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Message"]] maskType:SVProgressHUDMaskTypeClear];
            [arrcoll addObject:[NSString stringWithFormat:@"%@",[model objectForKey:@"LineId"]]];
            [_myTabview reloadData];
        }
        
        
    } failBlock:^(NSError *error) {
        
    } successBackFailedBlock:^(id responseObject) {
        
    }];

}

- (void)order:(NSInteger)indexRow{
    NSLog(@"下单的%i",(int)indexRow);
    NSDictionary *model = arrlist[indexRow];
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

#pragma mark TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrlist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *model = arrlist[indexPath.row];
    SpecificLineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[SpecificLineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    for (NSString *str in arrcoll) {
        if ([str isEqualToString:[model objectForKey:@"LineId"]]) {
            [cell.collBtn setImage:[UIImage imageNamed:@"线路_收藏"] forState:UIControlStateNormal];
        }
    }
    cell.delegate = self;
    cell.indexRow = indexPath.row;
    cell.nameLab.text = [model objectForKey:@"StartContact"];
    cell.comNameLab.text = [model objectForKey:@"CompanyName"];
    cell.rankStar = [[model objectForKey:@"Synthetic"]intValue];
    cell.phoneLab = [model objectForKey:@"StartMobile"];
    cell.teleLab = [model objectForKey:@"StartTel"];
    cell.lab2.text = @"收藏";
    NSString *s = [model objectForKey:@"StartCity"];
    NSString *a = [model objectForKey:@"ArrivalCity"];
    if ([[model objectForKey:@"StartCity"]isEqualToString:@""]) {
        s = [model objectForKey:@"StartProvince"];
    }
    if ([[model objectForKey:@"ArrivalCity"]isEqualToString:@""]) {
        a = [model objectForKey:@"ArrivalProvince"];
    }
    cell.lineLab.text = [NSString stringWithFormat:@"%@--->%@",s,a];
    cell.addressLab.text = [model objectForKey:@"StartAddr"];
    return cell;    return cell;
}

#pragma mark TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 130;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //  打电话
//    NSDictionary *model = arrlist[indexPath.row];
//    NSString *phoneNo = [model objectForKey:@"StartMobile"];
//    if (![phoneNo isEqualToString:@""]) {
//        [self tele:phoneNo];
//    }
//    else {
//        return;
//    }
}

- (void)daphone:(NSInteger)indexRow{
    NSDictionary *model = arrlist[indexRow];
    NSString *phoneNo = [model objectForKey:@"StartMobile"];
    if (![phoneNo isEqualToString:@""]) {
        [self tele:phoneNo];
    }
    else {
        return;
    }
}


@end
