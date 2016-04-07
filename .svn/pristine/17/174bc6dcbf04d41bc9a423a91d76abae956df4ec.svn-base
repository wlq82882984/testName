//
//  PushUtil.m
//  RomanticAppiontment
//
//  Created by baichun on 15-3-26.
//  Copyright (c) 2015年 baichun. All rights reserved.
//

#import "PushUtil.h"



@implementation PushUtil

+(void)sendDelPushDeviceUrl{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    BOOL isSendPush=[[defaults objectForKey:IS_PUSH_SET] boolValue];
  
    if (!isSendPush) {
        NSLog(@"已经没有push请求");
        return;
    }
    
    ModelMember *member=[LoginMethod userObjectLogined];

    if (!member) {
//        [SVProgressHUD showErrorWithStatus:HAS_NO_USER];
        return;
    }
 
    NSString *deviceIDStr=[defaults objectForKey:DEVICE_ID];
    if (!deviceIDStr) {
        [SVProgressHUD showErrorWithStatus:WARN_DEVICE_ID_NO];
        return;
    }
    
    [params setObject:[NSNumber numberWithInt:member.memberId] forKey:@"memberId"];
    [params setObject:[NSNumber numberWithInt:2] forKey:@"deviceType"];
    [params setObject:deviceIDStr forKey:@"deviceId"];
    
    [Request postRequestWithUrl:[Request getUrlStringWithRequestStr:URL_PUSH_DEL_DEVICE] params:params showTips:@"" tipsType:SVProgressHUDMaskTypeNone sucessBlock:^(id responseObject) {
        [defaults setObject:[NSNumber numberWithBool:PARA_NO] forKey:IS_PUSH_SET];

    } failBlock:^(NSError *error) {
        [defaults setObject:[NSNumber numberWithBool:PARA_YES] forKey:IS_PUSH_SET];

    } successBackFailedBlock:^(id responseObject) {
        [SVProgressHUD dismiss];
        [defaults setObject:[NSNumber numberWithBool:PARA_YES] forKey:IS_PUSH_SET];

    }];
    
    
    
}


+(void)sendSetPushDeviceUrl{
    NSLog(@"发送push");
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL isSendPush=[[defaults objectForKey:IS_PUSH_SET] boolValue];
    if (isSendPush) {
        return;

    }
    
    ModelMember *member=[LoginMethod userObjectLogined];
    
    if (!member) {
//        [SVProgressHUD showErrorWithStatus:HAS_NO_USER];
        return;
    }
   
    NSString *deviceIDStr=[defaults objectForKey:DEVICE_ID];
    if (!deviceIDStr) {
        //        [SVProgressHUD showErrorWithStatus:WARN_DEVICE_ID_NO];
        return;
    }
    
    [params setObject:[NSNumber numberWithInt:member.memberId] forKey:@"memberId"];
    [params setObject:[NSNumber numberWithInt:2] forKey:@"deviceType"];
    [params setObject:deviceIDStr forKey:@"deviceId"];
    
//    [params setObject:[NSNumber numberWithInt:0] forKey:@"channelId"];
//    [params setObject:@"" forKey:@"tag"];
//    
    
    [Request postRequestWithUrl:[Request getUrlStringWithRequestStr:URL_PUSH_SUBMIT_DEVICE] params:params showTips:@"" tipsType:SVProgressHUDMaskTypeNone sucessBlock:^(id responseObject) {
        [defaults setObject:[NSNumber numberWithBool:PARA_YES] forKey:IS_PUSH_SET];
        
    } failBlock:^(NSError *error) {
        [defaults setObject:[NSNumber numberWithBool:PARA_NO] forKey:IS_PUSH_SET];
        
    } successBackFailedBlock:^(id responseObject) {
        [SVProgressHUD dismiss];
        [defaults setObject:[NSNumber numberWithBool:PARA_NO] forKey:IS_PUSH_SET];
        
    }];

    
}


+(void)sendIsAcceptPushSetUrl{
    
    ModelMember *member=[LoginMethod userObjectLogined];
    if (!member) {
        return;
    }
    
    
    [Request getRequestWithUrl:[Request getUrlStringWithRequestStr:URL_PUSH_IS_ACCEPT] params:nil showTips:@"" tipsType:SVProgressHUDMaskTypeNone sucessBlock:^(id responseObject) {
        //canPush：0—不接收 1---接收
        NSNumber *resutlIsPush=[responseObject objectForKey:@"canPush"];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:resutlIsPush forKey:PUSH_IS_CAN];
    } failBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:REQUEST_ERROR];

        
    } successBackFailedBlock:^(id responseObject) {
//        [SVProgressHUD dismiss];
        
    }];
    
}


+(void)sendSetIsPushSetUrl:(BOOL)canPushNum{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    ModelMember *member=[LoginMethod userObjectLogined];
    if (!member) {
        return;
    }
    [params setObject:[NSNumber numberWithInt:member.memberId] forKey:@"memberId"];
    [params setObject:[NSNumber numberWithBool:canPushNum] forKey:@"canPush"];
    
    
    [Request postRequestWithUrl:[Request getUrlStringWithRequestStr:URL_PUSH_SET_IS_ACCEPT] params:params showTips:@"" tipsType:SVProgressHUDMaskTypeNone sucessBlock:^(id responseObject) {
        [defaults setObject:[NSNumber numberWithBool:canPushNum] forKey:PUSH_IS_CAN];
        NSString *tip=(canPushNum==CAN_PUSH_YES?@"设置接受推送消息成功":@"设置不接受推送消息成功");
        [SVProgressHUD showSuccessWithStatus:tip];

    } failBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:REQUEST_ERROR];
        
    } successBackFailedBlock:^(id responseObject) {
        
    }];

}

@end
