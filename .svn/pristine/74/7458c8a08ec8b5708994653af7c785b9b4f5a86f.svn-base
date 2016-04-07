//
//  MJHomeViewController.m
//  MingJia
//
//  Created by admin on 15/12/24.
//  Copyright © 2015年 BCKJ. All rights reserved.
//  home/getadv

#import "MJHomeViewController.h"
#import "MJCreditableViewController.h"
#import "MJLineSearchViewController.h"
#import "MJSearchResultViewController.h"
#import "MJCarChangeViewController.h"
#import "MJCityTruckViewController.h"
#import "InterOrderViewController.h"
#import "MJLoginViewController.h"
#import "MainTabBarController.h"
#import "SweepYardVCtr.h"

#import "MyAdView.h"

@interface MJHomeViewController ()<UITextFieldDelegate>{
    NSArray      *adArr;
    UIScrollView *mainScroll;
    UITextField  *searchText;
    UIButton *btn01;
    UIButton *btn02;
    UIButton *btn03;
    
    UIButton *btn11;
    UIButton *btn12;
    UIButton *btn13;
    UIButton *logBtn;
}

@property(nonatomic,strong)MyAdView *myADview;

@end

@implementation MJHomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"UserLogin"]) {
        if (logBtn) {
            [logBtn removeFromSuperview];
        }
        [self drawLoginBtn];
    }
    else{
        if (logBtn) {
            [logBtn removeFromSuperview];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(notificationpushtoME) name:@"pushtoshopCar" object:nil];
    adArr = [NSArray array];
    self.title = @"首页";
    [self drawView];
    [self sendRequestAD];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"pushtoshopCar" object:nil];
}

- (void)notificationpushtoME{
    // 当此时window的跟控制器就是tabbar的话，在这里的效果就是选中了2号位的控制器了
    MainTabBarController *maintab = (MainTabBarController *)self.tabBarController;
    [maintab selectedTabAtIndex:3];
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
    }
        failBlock:^(NSError *error) {
    }
        successBackFailedBlock:^(id responseObject) {
    }];
}

- (void)drawLoginBtn{
    logBtn = [UIButton createButtonwithFrame:CGRectMake(0, 0, ScreenWidth, SizeScale(40)) backgroundColor:[UIColor colorWithHex:0xffffff alpha:0.6] image:[UIImage imageNamed:@""]];
    [logBtn addTarget:self action:@selector(logAction) forControlEvents:UIControlEventTouchUpInside];
    [logBtn setTitle:@"您尚未登录，点击登录" forState:UIControlStateNormal];
    [logBtn setTitleColor:Color_font_dark forState:UIControlStateNormal];
    logBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:logBtn];
}

- (void)logAction{
//    [self presentLoginScene];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if (![user objectForKey:@"UserLogin"]) {
        BaseNavigationController *vc = [[BaseNavigationController alloc]initWithRootViewController:[[MJLoginViewController alloc]init]];
        [self presentViewController:vc animated:NO completion:^{
            
        }];
        return;
    }
}

- (void)drawView{
    mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenHeight, ScreenHeight - 64 - 48)];
    mainScroll.backgroundColor = CLEAN_COLOR;
    UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignFirst)];
    mainScroll.userInteractionEnabled=YES;
    [mainScroll addGestureRecognizer:Tap];
    [self.view addSubview:mainScroll];
    
    _myADview = [[MyAdView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, SizeScale(54))];
    _myADview.backgroundColor = [UIColor blueColor];
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
    searchText.layer.borderWidth = 1;
    searchText.delegate = self;
    searchText.layer.borderColor = COLOR_line_HEAD.CGColor;
    [mainScroll addSubview:searchText];

    float HH = ScreenHeight-152-SizeScale(54);

    //（h-12）/2
    UIView *view1 = [UIView createViewWithFrame:CGRectMake(6, SizeScale(54)+40, ScreenWidth/2-9, (HH-12)/2) backgroundColor:HEXCOLOR(0xf49c14)];
    view1.layer.cornerRadius = 6;
    [mainScroll addSubview:view1];
    UIImageView *icon1 = [UIImageView createImageViewWithFrame:CGRectMake(0, 0, 30, 30) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"首页_零担"]];
    icon1.frame = CGRectMake(ScreenWidth/4 - 18, SizeScale(60), 30, 30);
    [view1 addSubview:icon1];
    btn01 = [UIButton createButtonwithFrame:view1.bounds backgroundColor:CLEAN_COLOR conrnerRadius:0 borderWidth:0 borderColor:CLEAN_COLOR];
    [btn01 setTitle:@"零担下单" forState:UIControlStateNormal];
    [btn01 addTarget:self action:@selector(btn01Action) forControlEvents:UIControlEventTouchUpInside];
    btn01.titleLabel.font = SYSTEM_FONT_(14);
    [btn01 setTitleEdgeInsets:UIEdgeInsetsMake(SizeScale(20), 0, 0, 0)];
    [btn01 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [view1 addSubview:btn01];
    
    UIView *view2 = [UIView createViewWithFrame:CGRectMake(ScreenWidth/2+3, SizeScale(54)+40, ScreenWidth/2-9, HH/4-6) backgroundColor:HEXCOLOR(0x61a6c3)];
    [mainScroll addSubview:view2];
    view2.layer.cornerRadius = 6;
    UIImageView *icon2 = [UIImageView createImageViewWithFrame:CGRectMake(0, 0, 30, 30) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"首页_信用平台"]];
    icon2.frame = CGRectMake(ScreenWidth/4 - 18, SizeScale(25), 30, 30);
    [view2 addSubview:icon2];
    btn02 = [UIButton createButtonwithFrame:view2.bounds backgroundColor:CLEAN_COLOR conrnerRadius:0 borderWidth:0 borderColor:CLEAN_COLOR];
    [btn02 setTitle:@"信用平台" forState:UIControlStateNormal];
    btn02.titleLabel.font = SYSTEM_FONT_(14);
    [btn02 addTarget:self action:@selector(pushXYPT:) forControlEvents:UIControlEventTouchUpInside];
    [btn02 setTitleEdgeInsets:UIEdgeInsetsMake(SizeScale(40), 0, 0, 0)];
    [btn02 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [view2 addSubview:btn02];
    
    UIView *view3 = [UIView createViewWithFrame:CGRectMake(ScreenWidth/2+3, CGRectGetMaxY(view2.frame)+6, ScreenWidth/2-9, HH/4-6) backgroundColor:HEXCOLOR(0x999a9a)];
    [mainScroll addSubview:view3];
    view3.layer.cornerRadius = 6;
    UIImageView *icon3 = [UIImageView createImageViewWithFrame:CGRectMake(0, 0, 30, 30) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"首页_查询"]];
    icon3.frame = CGRectMake(ScreenWidth/4 - 18, SizeScale(25), 30, 30);
    [view3 addSubview:icon3];
    btn03 = [UIButton createButtonwithFrame:view3.bounds backgroundColor:CLEAN_COLOR conrnerRadius:0 borderWidth:0 borderColor:CLEAN_COLOR];
    [btn03 addTarget:self action:@selector(btn03Action) forControlEvents:UIControlEventTouchUpInside];
    [btn03 setTitle:@"专线信用查询" forState:UIControlStateNormal];
    btn03.titleLabel.font = SYSTEM_FONT_(14);
    [btn03 setTitleEdgeInsets:UIEdgeInsetsMake(SizeScale(40), 0, 0, 0)];
    [btn03 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [view3 addSubview:btn03];
    
    UIView *view4 = [UIView createViewWithFrame:CGRectMake(6, CGRectGetMaxY(view1.frame)+6, ScreenWidth/2-9, (HH-12)/2) backgroundColor:HEXCOLOR(0x3598dc)];
    view4.layer.cornerRadius = 6;
    [mainScroll addSubview:view4];
    UIImageView *icon4 = [UIImageView createImageViewWithFrame:CGRectMake(0, 0, 30, 30) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"首页_网上办单"]];
    icon4.frame = CGRectMake(ScreenWidth/4 - 18, SizeScale(60), 30, 30);
    [view4 addSubview:icon4];
    btn11 = [UIButton createButtonwithFrame:view4.bounds backgroundColor:CLEAN_COLOR conrnerRadius:0 borderWidth:0 borderColor:CLEAN_COLOR];
    [btn11 setTitle:@"网上办单" forState:UIControlStateNormal];
    [btn11 addTarget:self action:@selector(gotointerOrder) forControlEvents:UIControlEventTouchUpInside];
    btn11.titleLabel.font = SYSTEM_FONT_(14);
    [btn11 setTitleEdgeInsets:UIEdgeInsetsMake(SizeScale(20), 0, 0, 0)];
    [btn11 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [view4 addSubview:btn11];
    
    UIView *view5 = [UIView createViewWithFrame:CGRectMake(ScreenWidth/2+3, CGRectGetMaxY(view3.frame)+6, ScreenWidth/2-9, HH/4-6) backgroundColor:HEXCOLOR(0xed6900)];
    [mainScroll addSubview:view5];
    view5.layer.cornerRadius = 6;
    UIImageView *icon5 = [UIImageView createImageViewWithFrame:CGRectMake(0, 0, 30, 30) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"首页_整车"]];
    icon5.frame = CGRectMake(ScreenWidth/4 - 18, SizeScale(25), 30, 30);
    [view5 addSubview:icon5];
    btn12 = [UIButton createButtonwithFrame:view5.bounds backgroundColor:CLEAN_COLOR conrnerRadius:0 borderWidth:0 borderColor:CLEAN_COLOR];
    [btn12 addTarget:self action:@selector(gotoCarOrder) forControlEvents:UIControlEventTouchUpInside];
    [btn12 setTitle:@"整车入单" forState:UIControlStateNormal];
    btn12.titleLabel.font = SYSTEM_FONT_(14);
    [btn12 setTitleEdgeInsets:UIEdgeInsetsMake(SizeScale(40), 0, 0, 0)];
    [btn12 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [view5 addSubview:btn12];

    UIView *view6 = [UIView createViewWithFrame:CGRectMake(ScreenWidth/2+3, CGRectGetMaxY(view5.frame)+6, ScreenWidth/2-9, HH/4-6) backgroundColor:HEXCOLOR(0x696568)];
    [mainScroll addSubview:view6];
    view6.layer.cornerRadius = 6;
    UIImageView *icon6 = [UIImageView createImageViewWithFrame:CGRectMake(0, 0, 30, 30) backgroundColor:CLEAN_COLOR image:[UIImage imageNamed:@"首页_约货"]];
    icon6.frame = CGRectMake(ScreenWidth/4 - 18, SizeScale(25), 30, 30);
    [view6 addSubview:icon6];
    btn13 = [UIButton createButtonwithFrame:view6.bounds backgroundColor:CLEAN_COLOR conrnerRadius:0 borderWidth:0 borderColor:CLEAN_COLOR];
    [btn13 addTarget:self action:@selector(gotoTruck) forControlEvents:UIControlEventTouchUpInside];
    [btn13 setTitle:@"同城货的" forState:UIControlStateNormal];
    btn13.titleLabel.font = SYSTEM_FONT_(14);
    [btn13 setTitleEdgeInsets:UIEdgeInsetsMake(SizeScale(40), 0, 0, 0)];
    [btn13 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [view6 addSubview:btn13];
    
//    CGFloat h = CGRectGetMaxY(view6.frame);
//    mainScroll.contentSize = CGSizeMake(ScreenWidth, h +10);

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [searchText resignFirstResponder];
    return YES;
}

- (void)gotoSweepYardVCtr{
    SweepYardVCtr *vc = [[SweepYardVCtr alloc]init];
    [self resignFirst];
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)gotoCarOrder{
    MJCarChangeViewController *vc = [[MJCarChangeViewController alloc]init];
    [self resignFirst];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if (![user objectForKey:@"UserLogin"]) {
        BaseNavigationController *vc = [[BaseNavigationController alloc]initWithRootViewController:[[MJLoginViewController alloc]init]];
        [self presentViewController:vc animated:NO completion:^{
            
        }];
        return;
    }
    [self.navigationController pushViewController:vc animated:NO];
}

-(void)setADViewImages{
    NSMutableArray *adImageArray=[[NSMutableArray alloc]init];
    
    for (NSInteger i = 0; i<[adArr count]; i++) {
        [adImageArray addObject:adArr[i]];
    }
    [_myADview drawAdViewWithNameArray:nil urlArray:adImageArray animationDurtion:3];
}

- (void)gotointerOrder{
    InterOrderViewController *vc = [[InterOrderViewController alloc]init];
    [self resignFirst];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if (![user objectForKey:@"UserLogin"]) {
        BaseNavigationController *vc = [[BaseNavigationController alloc]initWithRootViewController:[[MJLoginViewController alloc]init]];
        [self presentViewController:vc animated:NO completion:^{
            
        }];
        return;
    }
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)gotoTruck{
    MJCityTruckViewController *vc = [[MJCityTruckViewController alloc]init];
    [self resignFirst];
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)searchList:(id)sender{
    if ([searchText.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"请填写订单号" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    else if (![CheckMethod validateOrderId:searchText.text]){
        [SVProgressHUD showInfoWithStatus:@"请填写单号" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    
    MJSearchResultViewController *vc = [[MJSearchResultViewController alloc]init];
    vc.orderId = searchText.text;
    [self resignFirst];
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    if (![user objectForKey:@"UserLogin"]) {
//        BaseNavigationController *vc = [[BaseNavigationController alloc]initWithRootViewController:[[MJLoginViewController alloc]init]];
//        [self presentViewController:vc animated:NO completion:^{
//            
//        }];
//        return;
//    }
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)btn01Action{   // 零担下单
    MJLineSearchViewController *vc = [[MJLineSearchViewController alloc]init];
    vc.searchType = SETORDERTYPE;  // 下单
    [self resignFirst];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if (![user objectForKey:@"UserLogin"]) {
        BaseNavigationController *vc = [[BaseNavigationController alloc]initWithRootViewController:[[MJLoginViewController alloc]init]];
        [self presentViewController:vc animated:NO completion:^{
            
        }];
        return;
    }

    [self.navigationController pushViewController:vc animated:NO];
}

- (void)btn03Action{
    MJLineSearchViewController *vc = [[MJLineSearchViewController alloc]init];
    vc.searchType = SEARCHORDERTYPE;  // 查询
    [self resignFirst];
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)pushXYPT:(id)sender{
    MJCreditableViewController *vc = [[MJCreditableViewController alloc]init];
    [self resignFirst];
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)resignFirst{
    [searchText resignFirstResponder];
}

@end
