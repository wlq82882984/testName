//
//  UtilIdentifyParams.h
//  WaterMan
//
//  Created by baichun on 15-11-21.
//  Copyright (c) 2015年 baichun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UtilIdentifyParams : NSObject

//返回性别图片，正常的
+(UIImage *)identifyGenderImg:(int)gender;
////返回性别图片 用在二维码，比较圆的
//+(UIImage *)identifyGender2PersonalImg:(int)gender;
+(UIImage *)userDefalutImg;
+(UIImage *)identifyUserBiaoShiImg:(NSInteger)enterpriseId;
+(UIImage *)identifyChatIsSenderImg:(BOOL)isSender;
@end
