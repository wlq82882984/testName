//
//  BaseView.m
//  RiTao
//
//  Created by admin on 15/12/16.
//  Copyright © 2015年 BCKJ. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=APP_BACKGROUND_COLOR;
    }
    return self;
}

@end
