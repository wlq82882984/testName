//
//  AppDelegate.m
//  MingJia
//
//  Created by admin on 15/12/24.
//  Copyright © 2015年 BCKJ. All rights reserved.
//  order/GetLineByOrderId?OrderId=&CompanyId=

#import "AppDelegate.h"
#import "APService.h"
#import "MainTabBarController.h"
#import "BaseNavigationController.h"
#import "MJBJViewController.h"    // 询价跳过去
#import "MJQuoteViewController.h"// 报价
#import "MJDetailOrderViewController.h" // 确认
// 接单
#import <AVFoundation/AVFoundation.h>
#import "MJCarChangeViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface AppDelegate ()
@property(nonatomic,strong)AVAudioPlayer *audioplayer;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    MainTabBarController *maintb = [[MainTabBarController alloc]init];
    self.window.rootViewController = maintb;
    [self.window makeKeyAndVisible];
    if (![PlistDao isPlistFileExists:@"AreaPlist.plist"]) {
        [self requestgetArea];
    }
    [self jPush:launchOptions];
    return YES;
}

- (void)requestgetArea{
    NSString *urlStr = @"http://mjweixin.reeease.com/Home/GetAreaJson1";
    [Request getRequestWithUrl:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] params:nil showTips:@"查询" tipsType:SVProgressHUDMaskTypeClear sucessBlock:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSArray *dict = (NSArray *)responseObject;
        NSMutableDictionary *AreaDic = [NSMutableDictionary dictionary];
        [AreaDic setObject:dict forKey:@"myArea"];
        [PlistDao writePlist:AreaDic forKey:@"areaPlist" plistNameStr:@"AreaPlist.plist"];
    } failBlock:^(NSError *error) {
        
    } successBackFailedBlock:^(id responseObject) {
        
    }];
}

- (void)jPush:(NSDictionary *)launchOptions{
    // Required
    #if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            //categories
            [APService
             registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                 UIUserNotificationTypeSound |
                                                 UIUserNotificationTypeAlert)
             categories:nil];
        } else {
            //categories nil
            [APService
             registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                 UIRemoteNotificationTypeSound |
                                                 UIRemoteNotificationTypeAlert)
#else
             //categories nil
             categories:nil];
            [APService
             registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                 UIRemoteNotificationTypeSound |
                                                 UIRemoteNotificationTypeAlert)
#endif
             // Required
             categories:nil];
        }
    [APService setupWithOption:launchOptions];
//    [APService setLocalNotification:[NSDate dateWithTimeIntervalSinceNow:10] alertBody:@"" badge:1 alertAction:@"" identifierKey:@"" userInfo:nil soundName:@"mySong"];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"%@",error);
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Required
    //    [[NSUserDefaults standardUserDefaults] setObject:[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""] stringByReplacingOccurrencesOfString: @">" withString: @""]stringByReplacingOccurrencesOfString: @" " withString: @""] forKey:@"device_id"];
    [APService registerDeviceToken:deviceToken];
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"device_id"]) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"device_id"];
    }
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@", deviceToken] forKey:@"device_id"];
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"device_id"]);
    
    NSString *stra = [APService registrationID];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"registID"]) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"registID"];
    }
//    推送的提示音是有时间限制的，
    [[NSUserDefaults standardUserDefaults] setObject:stra forKey:@"registID"];
    NSLog(@"%@",stra);
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Required
    NSLog(@"userInfo1========>%@",userInfo);
    UIAlertView *ala = [[UIAlertView alloc]initWithTitle:@"后台" message:@"你好" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"ok", nil];
    [ala show];
    
    [APService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void
                        (^)(UIBackgroundFetchResult))completionHandler {
    // IOS 7 Support Required    运行中显示
    NSLog(@"userInfo2========>%@",[userInfo objectForKey:@"MsgType"]);
    NSLog(@"completionHandler========>%@",completionHandler);
    
    
//    [self sound];
    if(application.applicationState == UIApplicationStateActive){
        //推送反馈(app运行时)
        // 程序在运行过程中受到推送通知
        if(userInfo){
            UIAlertView *alert =
            [UIAlertView showAlertViewWithTitle: @"新消息"
                                        message: [[userInfo objectForKey: @"aps"] objectForKey: @"alert"]
                              cancelButtonTitle:@"取消"
                              otherButtonTitles:@[@"确定"]
                                      onDismiss:^(int buttonIndex)
             {
                 if ([self.window.rootViewController isKindOfClass:[MainTabBarController class]])
                 {
                     MainTabBarController *tabbar =  (MainTabBarController *)self.window.rootViewController;
                     [tabbar selectedTabAtIndex:3];  // 科组哦页面跳转
                     
                     if ([[userInfo objectForKey:@"MsgType"] isEqualToString:@"询价"]) {
                         MJBJViewController *VC = [[MJBJViewController alloc]init];
                         VC.orderId = [userInfo objectForKey:@"Id"];
                        [(UINavigationController *)tabbar.selectedViewController pushViewController:VC animated:NO];
                     }
                     else if ([[userInfo objectForKey:@"MsgType"] isEqualToString:@"报价"]){
                         
                         MJQuoteViewController *VC = [[MJQuoteViewController alloc]init];
                         VC.orderId = [userInfo objectForKey:@"Id"];
                         [(UINavigationController *)tabbar.selectedViewController pushViewController:VC animated:NO];
                     }
                     else {
                         if (![userInfo objectForKey:@"MsgType"]) {
                             [self sound];
                             return ;
                         }
                         MJDetailOrderViewController *VC = [[MJDetailOrderViewController alloc]init];
                         VC.orderId = [userInfo objectForKey:@"Id"];
                         [(UINavigationController *)tabbar.selectedViewController pushViewController:VC animated:NO];
                     }
                 }
             }
                onCancel:^{
                }];
            
            [alert show];
        }
    }
    else{
        if ([self.window.rootViewController isKindOfClass:[MainTabBarController class]]){
        MainTabBarController *tabbar =  (MainTabBarController *)self.window.rootViewController;
        [tabbar selectedTabAtIndex:3];
            if ([[userInfo objectForKey:@"MsgType"] isEqualToString:@"询价"]) {
                MJBJViewController *VC = [[MJBJViewController alloc]init];
                VC.orderId = [userInfo objectForKey:@"Id"];
                [(UINavigationController *)tabbar.selectedViewController pushViewController:VC animated:NO];
            }
            else if ([[userInfo objectForKey:@"MsgType"] isEqualToString:@"报价"]){
                
                MJQuoteViewController *VC = [[MJQuoteViewController alloc]init];
                VC.orderId = [userInfo objectForKey:@"Id"];
                [(UINavigationController *)tabbar.selectedViewController pushViewController:VC animated:NO];
            }
            else {
                if (![userInfo objectForKey:@"MsgType"]) {
//                    [self sound];
                    return ;
                }
                MJDetailOrderViewController *VC = [[MJDetailOrderViewController alloc]init];
                VC.orderId = [userInfo objectForKey:@"Id"];
                [(UINavigationController *)tabbar.selectedViewController pushViewController:VC animated:NO];
            }
        }
    }
    
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)sound{
    //1.音频文件的url路径
      NSURL *url=[[NSBundle mainBundle]URLForResource:@"mySong.caf" withExtension:Nil];
    
        //2.创建播放器（注意：一个AVAudioPlayer只能播放一个url）
    self.audioplayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:Nil];
   
         //3.缓冲
      [self.audioplayer prepareToPlay];
   
       //4.播放
      [self.audioplayer play];
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    application.applicationIconBadgeNumber=0;
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
