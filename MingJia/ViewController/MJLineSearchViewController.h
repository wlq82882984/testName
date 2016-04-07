//
//  MJLineSearchViewController.h
//  MingJia
//
//  Created by admin on 15/12/26.
//  Copyright © 2015年 BCKJ. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    SEARCHORDERTYPE, //  查询
    SETORDERTYPE     //  下单
} searchType;

@interface MJLineSearchViewController : BaseViewController

@property(nonatomic,assign)searchType searchType;  // 根据这个字段确认键跳往不同的页面

@end
