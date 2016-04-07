//
//  Request.h
//  pywiphone
//
//  Created by jacob on 15-7-3.
//  Copyright (c) 2015年 jacob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetParams.h"
#import "MJExtension.h"
#import <SVProgressHUD/SVProgressHUD.h>


typedef void (^SucessBlock )(id);
typedef void (^FailureBlock)(NSError *);
typedef void (^SuccessBackFailureBlock) (id);
typedef void (^Progress)(float progress);

@interface FieldError : NSObject

@property(nonatomic,assign)int field;
@property(nonatomic,strong)NSString *message;

@end



@interface Request : NSObject

+ (NSString *)getUrlStringWithRequestStr:(NSString *)req;
+ (NSMutableDictionary *)getCommonParamsDictionary;
#pragma mark - AFNetWorking Request Method
/**
 *  AFNetWorking Request Method
 *
 *  @param url         地址
 *  @param params      参数
 *  @param sucessBlock 成功Block
 *  @param failBlock   失败Block
 *
 *  @return nil
 */
+(void)parsingRequestBack:(id)responseObject sucessBlock:(SucessBlock)sucessBlock failBlock:(SuccessBackFailureBlock)backFailBlock;
//get
+(id)getRequestWithUrl:(NSString *)url params:(NSMutableDictionary *)params showTips:(NSString *)showTips tipsType:(SVProgressHUDMaskType) type sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock successBackFailedBlock:(SuccessBackFailureBlock)backFailBlock;
//post
+(id)postRequestWithUrl:(NSString *)url params:(NSMutableDictionary *)params showTips:(NSString *)showTips tipsType:(SVProgressHUDMaskType) type sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock successBackFailedBlock:(SuccessBackFailureBlock)backFailBlock;
/**
 *  AFNetWorking Request Method With Images
 *
 *  @param url         地址
 *  @param params      参数
 *  @param dataArray   图片数组
 *  @param sucessBlock 成功block
 *  @param failBlock   失败block
 *
 *  @return nil
 */
//+(id)requestWithUrl:(NSString *)url params:(NSMutableDictionary *)params showTips:(NSString *)showTips tipsType:(SVProgressHUDMaskType) type dataArray:(NSArray *)dataArray sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock  successBackFailedBlock:(SuccessBackFailureBlock)backFailBlock;


/**上传录音
 */
+(id)requestVideoFileUrl:(NSString *)url params:(NSMutableDictionary *)params dataWithUrl:(NSURL *)dataUrl sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock successBackFailedBlock:(SuccessBackFailureBlock)backFailBlock;



/**
 *  上传图片
 *
 *  @param url         地址
 *  @param params      参数
 *  @param image       图片
 *  @param sucessBlock 成功block
 *  @param failBlock   失败block
 *
 *  @return nil
 */
+ (id)updataImageRequestWithUrl:(NSString *)url params:(NSMutableDictionary *)params showTips:(NSString *)showTips tipsType:(SVProgressHUDMaskType)type image:(UIImage *)image imageName:(NSString *)imageName sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock  successBackFailedBlock:(SuccessBackFailureBlock)backFailBlock;

/**
 *  获取城市信息
 */
+ (void)requestCity;

@end

