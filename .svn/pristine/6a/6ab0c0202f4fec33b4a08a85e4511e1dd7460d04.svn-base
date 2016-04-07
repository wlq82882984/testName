//
//  PushUtil.h
//  RomanticAppiontment
//
//  Created by baichun on 15-3-26.
//  Copyright (c) 2015年 baichun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"
#import "MJExtension.h"
//推送消息相关
#define  URL_PUSH_SUBMIT_DEVICE               @"%@/message/setMessageDeviceInfo"
#define  URL_PUSH_DEL_DEVICE                  @"%@/message/removeMessageDeviceInfo"


#define  URL_PUSH_IS_ACCEPT                @"%@/message/getCanPush/%d"
//是否接受推送
#define  URL_PUSH_SET_IS_ACCEPT                @"%@/message/setCanPush"



#define  WARN_DEVICE_ID_NO                    @"无设备信息"

#define  DEVICE_ID                    @"device_id"
#define  CHANNEL_ID                   @"channel_id"
#define  TAG_PUSH                     @"tag_push"

#define  PUSH_IS_CAN                  @"isCanPush"  //是否接收推送消息 布尔值

#define  IS_PUSH_SET                  @"IS_PUSH_SET"  //是否注册推送  布尔值

/* 是否接受推送-是 */
#define CAN_PUSH_YES                    1
/* 是否接受推送-否 */
#define CAN_PUSH_NO                     0

@interface PushUtil : NSObject
+(void)sendDelPushDeviceUrl;
+(void)sendSetPushDeviceUrl;
+(void)sendIsAcceptPushSetUrl;
+(void)sendSetIsPushSetUrl:(BOOL)canPushNum;
@end
