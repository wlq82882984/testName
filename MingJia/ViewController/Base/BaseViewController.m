//
//  BaseViewController.m
//  RiTao
//
//  Created by admin on 15/12/16.
//  Copyright © 2015年 BCKJ. All rights reserved.
//

#import "BaseViewController.h"
#import "MainTabBarController.h"
#import "MJLoginViewController.h"
#import "AppDelegate.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
        //在这里扫除掉所有原有的tabbar上面的子视图，以免对后来的自定义tabbar造成影响
    if ([self.navigationController.viewControllers count] == 1) {
        for (UIView *child in self.tabBarController.tabBar.subviews) {
            if ([child isKindOfClass:[UIControl class]]) {
                [child removeFromSuperview];
            }
        }
    }
}

- (void)removeNavigationBottomLine{
    // 去除导航栏下方的黑边
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden=YES;
                    }
                }
            }
        }
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"透明"] forBarMetrics:UIBarMetricsCompact];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor colorWithHex:0xf2f2f2 alpha:1.0];
//    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTranslucent:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.backgroundColor = WHITE_COLOR;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"HelveticaNeue-Bold" size:18],NSFontAttributeName,nil]];
}

-(CGSize)getLabelsize:(NSString *)text andTextsize:(int)textsize andLabwidth:(int)width{
    UILabel *label = [[UILabel alloc]init];
    label.text = text;
    label.numberOfLines = 1000;
    CGSize size = CGSizeMake(width, 9999);
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:textsize]};
    CGSize labelSize = [text boundingRectWithSize:size options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return labelSize;
}

// 通过此方法切换程序的跟控制器到登陆页面
-(void)presentLoginScene{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[MJLoginViewController alloc]init]];
    AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.window.rootViewController = nav;
}

// 通过此方法切换程序的跟控制器到应用页面
-(void)presentTab{
    MainTabBarController *main = [[MainTabBarController alloc]init];
    [main selectedTabAtIndex:0];
    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
    mainWindow.rootViewController = main;
}

// 打电话
- (void)tele:(NSString *)phoneNo{ // 打电话
//    UIAlertView *alert=[UIAlertView showAlertViewWithTitle:@"" message:[NSString stringWithFormat:@"确定要拨打电话:%@ ?",phoneNo] cancelButtonTitle:@"取消" otherButtonTitles:@[@"呼叫"] onDismiss:^(int buttonIndex) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phoneNo];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//    } onCancel:^{
//    }];
//    [alert show];
}

// 判断是否float类型

// 判断是否为int类型
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)isPureFloat:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

@end
