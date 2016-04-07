//
//  MJLineListViewController.m
//  MingJia
//
//  Created by admin on 15/12/26.
//  Copyright © 2015年 BCKJ. All rights reserved.
//  http://app.mjxypt.com/api/line/get?sp=&sc=&sa=&ap=&ac=&aa=&cn=

#import "MJLineListViewController.h"
#import "MJQuiryViewController.h" // 一键询价
#import "LineListCell.h"

@interface MJLineListViewController ()<UITableViewDataSource,UITableViewDelegate,XunJiaChooseDelegate>{
    UIButton *nextBtn;
    
    BOOL    isAll;
    NSMutableArray    *arrlist;
    NSMutableArray    *lineArr;
}

@property(nonatomic,strong)UITableView *myTabview;

@end

@implementation MJLineListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    lineArr = [NSMutableArray array];
    arrlist = [NSMutableArray array];
    self.title = @"线路列表";
    [self drawView];
    [self requestgetline];
    [self drawBottomV];
    
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
    _myTabview = [UITableView createTableViewWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 60) style:UITableViewStylePlain backgroundColor:CLEAN_COLOR delegate:self dataSource:self];
    [_myTabview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_myTabview];
}

- (void)drawBottomV{
    UIView *bottomV = [UIView createViewWithFrame:CGRectMake(0, ScreenHeight - 64 - 60, ScreenWidth, 60) backgroundColor:[UIColor colorWithHex:0xf5f5f5 alpha:1.0]];
    [self.view addSubview:bottomV];
    
    nextBtn = [UIButton createButtonwithFrame:CGRectMake(10, 10, SizeScale(210), 40) backgroundColor:TABBAR_TEXT_COLOR_SEL image:[UIImage imageNamed:@""]];
    nextBtn.layer.cornerRadius = 5;
    [nextBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    nextBtn.titleLabel.font = SYSTEM_FONT_(14);
    [bottomV addSubview:nextBtn];
    
    UIButton *allBtn = [UIButton createButtonwithFrame:CGRectMake( ScreenWidth - SizeScale(70) -10, 10, SizeScale(70), 40) backgroundColor:TABBAR_TEXT_COLOR_SEL image:[UIImage imageNamed:@""]];
    allBtn.layer.cornerRadius = 5;
    [allBtn addTarget:self action:@selector(allchoose) forControlEvents:UIControlEventTouchUpInside];
    [allBtn setTitle:@"全选" forState:UIControlStateNormal];
    [allBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    allBtn.titleLabel.font = SYSTEM_FONT_(14);
    [bottomV addSubview:allBtn];
    
}

-(void)allchoose{
    isAll = YES;
    [lineArr removeAllObjects];
    for (NSDictionary *tmpDic in arrlist) {
        NSString *line = [tmpDic objectForKey:@"LineId"];
        [lineArr addObject:line];
    }
    [_myTabview reloadData];
}

- (void)order1:(NSInteger)indexRow andbool:(BOOL)seleted{
    NSDictionary *model = arrlist[indexRow];
    isAll = NO;
    NSString *line = [model objectForKey:@"LineId"];
    if (seleted) { // 增加
        [lineArr addObject:line];
    }
    else {    // 删除
        int i;
        for (int k = 0; k < lineArr.count; k++) {
            NSString *mm = lineArr[k];
            if ([mm isEqualToString:line]) {
                i = k;
                break;
            }
        }
        [lineArr removeObjectAtIndex:i];
    }
}

-(void)nextAction{
    if (lineArr.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择一条线路" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    
    MJQuiryViewController *vc = [[MJQuiryViewController alloc]init];
    vc.linearr = lineArr;
    vc.placedic = _placeDic;
//    vc.dicAreas = _dicAreas;
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrlist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *model = arrlist[indexPath.row];
    LineListCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"listCell%i",(int)indexPath.row]];
    if (!cell) {
        cell = [[LineListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"listCell%i",(int)indexPath.row]];
    }
    if (isAll) {
        cell.isChoose = YES;
    }
    cell.delegate = self;
    cell.comNameLab.text = [model objectForKey:@"CompanyName"];
    cell.nameLab.text = [model objectForKey:@"StartContact"];
    cell.rankStar = [[model objectForKey:@"Synthetic"]intValue];
    cell.phoneLab = [model objectForKey:@"StartMobile"];
    if (![[model objectForKey:@"StartTel"] isEqualToString:@""]) {
        cell.teleLab = [model objectForKey:@"StartTel"];
    }
    NSString *s = [model objectForKey:@"StartCity"];
    NSString *a = [model objectForKey:@"ArrivalCity"];
    if ([[model objectForKey:@"StartCity"]isEqualToString:@""]) {
        s = [model objectForKey:@"StartProvince"];
    }
    if ([[model objectForKey:@"ArrivalCity"]isEqualToString:@""]) {
        a = [model objectForKey:@"ArrivalProvince"];
    }
    
    NSString *str = [model objectForKey:@"ArrivalCity"];
    NSRange sasa = [str rangeOfString:@"信用专线"];
    if(sasa.length>0) {
        cell.isZX = YES;
    a =[str stringByReplacingOccurrencesOfString:@"(明佳信用专线)" withString:@""];
    }
    else cell.isZX = NO;
    
    
    cell.lineLab.text = [NSString stringWithFormat:@"%@--->%@",s,a];
    cell.addressLab.text = [model objectForKey:@"StartAddr"];    cell.indexRow = indexPath.row;
    return cell;
}

#pragma mark TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 130;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //  打电话
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
