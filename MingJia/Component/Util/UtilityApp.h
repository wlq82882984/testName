//
//  UtilityApp.h
//  WaterMan
//
//  Created by baichun on 15-11-3.
//  Copyright (c) 2015年 baichun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UtilityApp : NSObject


+(CGFloat)getHeightWithWidth:(CGFloat)width text:(NSString *)text font:(UIFont *)font;
+(CGFloat)getWidthWithHeight:(CGFloat)height text:(NSString *)text font:(UIFont *)font;

//+(NSArray *)arrayWithASCOrdered:(NSMutableArray *)array
@end
