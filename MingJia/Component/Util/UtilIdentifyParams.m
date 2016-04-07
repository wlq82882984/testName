//
//  UtilIdentifyParams.m
//  WaterMan
//
//  Created by baichun on 15-11-21.
//  Copyright (c) 2015年 baichun. All rights reserved.
//

#import "UtilIdentifyParams.h"

@implementation UtilIdentifyParams

+(UIImage *)identifyGenderImg:(int)gender{
    if (gender==1) {
        return [UIImage imageNamed:@"男"];
    }else{
        return [UIImage imageNamed:@"女"];
    }
    
    return [[UIImage alloc]init];
    
}




//+(UIImage *)identifyGender2PersonalImg:(int)gender{
//    if (gender==1) {
//        return [UIImage imageNamed:@"男"];
//    }else{
//        return [UIImage imageNamed:@"女"];
//    }
//    
//    return [[UIImage alloc]init];
//    
//}
//


+(UIImage *)userDefalutImg{
    return [UIImage imageNamed:@"ic_default_portrait"];
}


//        [[EaseBaseMessageCell appearance] setSendBubbleBackgroundImage:[[UIImage imageNamed:@"chat_sender_bgv"] stretchableImageWithLeftCapWidth:5 topCapHeight:35]];
//        [[EaseBaseMessageCell appearance] setRecvBubbleBackgroundImage:[[UIImage imageNamed:@"chat_receiver_bgv"]
//

+(UIImage *)identifyChatIsSenderImg:(BOOL)isSender{
    if (isSender) {
        return [UIImage imageNamed:@"chat_sender_bgv"];
    }else{
        return [UIImage imageNamed:@"chat_receiver_bgv"];
    }
    
    return [[UIImage alloc]init];
    
}

+(UIImage *)identifyUserBiaoShiImg:(NSInteger)enterpriseId{
    if (enterpriseId) {
        return [UIImage imageNamed:@"头像_商家标识"];
    }else{
        return [UIImage imageNamed:@"头像_设计师标识"];
    }
    
    return [[UIImage alloc]init];
    
}
@end
