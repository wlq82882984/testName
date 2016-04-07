//
//  BaseNavigationController.m
//  WaterMan
//
//  Created by liqiang on 15/11/12.
//  Copyright © 2015年 baichun. All rights reserved.
//

#import "BaseNavigationController.h"

@implementation BaseNavigationController

-(void)viewDidLoad{
    [super viewDidLoad];
    // 添加右滑手势
//    [self addSwipeRecognizer];
}

#pragma mark 添加右滑手势
- (void)addSwipeRecognizer
{
    // 初始化手势并添加执行方法
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(return)];
    // 手势方向
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    // 响应的手指数
    swipeRecognizer.numberOfTouchesRequired = 1;
    // 添加手势
    [[self view] addGestureRecognizer:swipeRecognizer];
}

#pragma mark 返回上一级
- (void)return
{
    // 最低控制器无需返回
    if (self.viewControllers.count <= 1) return;
    // pop返回上一级
    [self popViewControllerAnimated:YES];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count != 0)      //在每次push的时候，将tabbar隐去
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

@end
