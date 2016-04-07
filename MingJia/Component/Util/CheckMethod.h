//
//  CheckMethod.h
//  RomanticAppiontment
//
//  Created by baichun on 15-2-10.
//  Copyright (c) 2015年 baichun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckMethod : NSObject
/*验证手机*/
+ (BOOL) validateMobile:(NSString *)mobile;
/*验证条码号*/
+ (BOOL) validateOrderId:(NSString *)orderId;
/*验证邮箱*/
+ (BOOL)validateEmail:(NSString *)email;
/*验证密码长度*/
+(BOOL)validatePassword:(NSString *)passwordStr;
/*验证是否是数字*/
+(BOOL)validateNumber:(NSString*)number ;
/*验证身份证*/
+(BOOL)validateIdentityCard:(NSString *)identityCard;
//中文转拼音
+(NSString *)chineseToPinYin:(NSString *)chinaStr;

@end
