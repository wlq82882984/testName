//
//  MyAdView.m
//  GLKiphone
//
//  Created by 刘锋婷 on 14-4-12.
//  Copyright (c) 2014年 刘锋婷. All rights reserved.
//

#import "MyAdView.h"
#import "UIImageView+ProgressView.h"
#import "AppTotalFile.h"

@interface MyAdView() <UIScrollViewDelegate>

@end

@implementation MyAdView

#define WIDTH            self.bounds.size.width
#define HEIGHT           self.bounds.size.height

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

-(void)drawAdViewWithNameArray:(NSArray *)nameArray urlArray:(NSArray *)urlArray animationDurtion:(NSTimeInterval) durition
{
    _numberOfImages=[urlArray count];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _scrollView.bounces = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.userInteractionEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(120,HEIGHT-20,WIDTH,30)]; // 初始化mypagecontrol
    [_pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
    [_pageControl setPageIndicatorTintColor:[UIColor colorWithHex:0xffffff alpha:0.5]];
    _pageControl.numberOfPages =_numberOfImages;
    _pageControl.currentPage = 0;
//    [_pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged]; // 触摸mypagecontrol触发change这个方法事件
//    [self addSubview:_pageControl];
    
    for (int i = 0;i<[urlArray count];i++){
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(WIDTH*(i+1),0, WIDTH,HEIGHT);
        [_scrollView addSubview:imageView]; // 首页是第0页,默认从第1页开始的。所以+320。。。
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",urlArray[i]]]  placeholderImage:[UIImage imageNamed:@"查询"]];

        imageView.tag=i;
        UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressed:)];
        imageView.userInteractionEnabled=YES;
        [imageView addGestureRecognizer:Tap];
    }
    // 添加最后1页在首页 循环
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[urlArray lastObject]]] placeholderImage:[UIImage imageNamed:@"查询"]];
    [_scrollView addSubview:imageView];
    
    // 取数组第一张图片 放在最后1页
    UIImageView *lastimageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[urlArray firstObject]]]];
    lastimageView.frame = CGRectMake((WIDTH * (_numberOfImages+1)) , 0, WIDTH, HEIGHT);
    [lastimageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[urlArray firstObject]]] placeholderImage:[UIImage imageNamed:@"查询"]];
    [_scrollView addSubview:lastimageView];

    //  +上第1页和第4页  原理：4-[1-2-3-4]-1// 默认从序号1位置放第1页 ，序号0位置位置放第4页
    [_scrollView setContentSize:CGSizeMake(WIDTH * (_numberOfImages + 2), HEIGHT)];
    [_scrollView setContentOffset:CGPointMake(0, 0)];
    [_scrollView scrollRectToVisible:CGRectMake(WIDTH,0,WIDTH,HEIGHT) animated:NO];
    
    _timer=[NSTimer scheduledTimerWithTimeInterval:durition target:self selector:@selector(timerActins) userInfo:nil repeats:YES];
}
// scrollview 委托函数
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pagewidth/(_numberOfImages+2))/pagewidth)+1;
    page --;  // 默认从第二页开始
    _pageControl.currentPage = page;
}
// scrollview 委托函数
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int currentPage = floor((self.scrollView.contentOffset.x - pagewidth/ (_numberOfImages+2)) / pagewidth) + 1;
    //    int currentPage_ = (int)self.scrollView.contentOffset.x/320; // 和上面两行效果一样
    //    NSLog(@"currentPage_==%d",currentPage_);
    if (currentPage==0)
    {
        [self.scrollView scrollRectToVisible:CGRectMake(WIDTH * _numberOfImages,0,WIDTH,HEIGHT) animated:YES]; // 序号0 最后1页
    }
    else if (currentPage==(_numberOfImages+1))
    {
        [self.scrollView scrollRectToVisible:CGRectMake(WIDTH,0,WIDTH,HEIGHT) animated:YES]; // 最后+1,循环第1页
    }
}
// pagecontrol 选择器的方法
- (void)turnPage
{
    int page = (int)_pageControl.currentPage; // 获取当前的page
    [self.scrollView scrollRectToVisible:CGRectMake(WIDTH*(page+1),0,WIDTH,HEIGHT) animated:YES]; // 触摸pagecontroller那个点点 往后翻一页 +1
}
// 定时器 绑定的方法
- (void)timerActins
{
    int page = (int)_pageControl.currentPage; // 获取当前的page
    page++;
    page = page > _numberOfImages-1 ? 0 : page ;
    _pageControl.currentPage = page;
    [self turnPage];
}
-(void)imagePressed:(UITapGestureRecognizer *)sender
{
    NSLog(@"pressed");
    if (_delegate && [_delegate respondsToSelector:@selector(myAdViewTappedAtIndex:)]) {
        [_delegate myAdViewTappedAtIndex:sender.view.tag];
    }
}
@end
