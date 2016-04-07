//
//  UtilityApp.m
//  WaterMan
//
//  Created by baichun on 15-11-3.
//  Copyright (c) 2015年 baichun. All rights reserved.
//

#import "UtilityApp.h"
#import "UIAlertView+Blocks.h"
//#import "LoginVCtr.h"

@implementation UtilityApp


#pragma mark - text getWidthWithHeight

+(CGFloat)getHeightWithWidth:(CGFloat)width text:(NSString *)text font:(UIFont *)font
{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:font}
                                     context:nil];
    return rect.size.height;
}
+(CGFloat)getWidthWithHeight:(CGFloat)height text:(NSString *)text font:(UIFont *)font
{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:font}
                                     context:nil];
    return rect.size.width;
}

@end
