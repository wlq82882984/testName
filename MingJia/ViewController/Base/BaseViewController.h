//
//  BaseViewController.h
//  RiTao
//
//  Created by admin on 15/12/16.
//  Copyright © 2015年 BCKJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppTotalFile.h"

@interface BaseViewController : UIViewController

#pragma mark 获得文本的size
-(CGSize)getLabelsize:(NSString *)text andTextsize:(int)textsize andLabwidth:(int)width;
- (void)removeNavigationBottomLine;
- (BOOL)isPureFloat:(NSString *)string;
- (void)presentLoginScene;
- (void)presentTab;
- (void)tele:(NSString *)phoneNo;

- (BOOL)isPureInt:(NSString*)string;
@end
