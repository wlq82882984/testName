//
//  MyAdView.h
//  GLKiphone
//
//  Created by 刘锋婷 on 14-4-12.
//  Copyright (c) 2014年 刘锋婷. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MyAdView;
@protocol MyAdViewDelegate <NSObject>

-(void)myAdViewTappedAtIndex:(NSInteger )index;

@end

@interface MyAdView : UIView

@property (strong,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)UIPageControl *pageControl;
@property (strong, nonatomic)UITextField *text;
@property (nonatomic)NSInteger numberOfImages;
@property (nonatomic,strong)NSTimer *timer;

@property (nonatomic, weak)id<MyAdViewDelegate> delegate;

-(void)drawAdViewWithNameArray:(NSArray *)nameArray urlArray:(NSArray *)urlArray animationDurtion:(NSTimeInterval)durition;

@end
