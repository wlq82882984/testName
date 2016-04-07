//
//  Request.m
//  pywiphone
//
//  Created by jacob on 15-7-3.
//  Copyright (c) 2015年 jacob. All rights reserved.
//

#import "Request.h"
#import "AFNetworking.h"
#import "UtilString.h"
#import "BaseSetting.h"

@implementation FieldError

@end
@implementation Request

+ (NSString *)getUrlStringWithRequestStr:(NSString *)req
{
    NSString *str = [NSString stringWithFormat:@"%@/%@",SERVER_URL,[UtilString getNoNilString:req]];
    
    return str;
}


+ (NSMutableDictionary *)getCommonParamsDictionary
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]] forKey:@"time"];
    [dic setObject:@"1.0" forKey:@"vesion"];
    [dic setObject:@"ios" forKey:@"platform"];
    
    return dic;
}

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

+(void)parsingRequestBack:(id)responseObject sucessBlock:(SucessBlock)sucessBlock failBlock:(SuccessBackFailureBlock)backFailBlock{  //这里经过改造，形成第三种方式，根据项目的需求，失败的请求一概是接收不到state,成功将成功信息抛出，成功中的error统一拎出来做另外的处理，有message带过来,直接显示即可，非常方便
    
    if (![responseObject objectForKey:@"Code"]) {
        NSLog(@"服务器返回数据错误");
        [SVProgressHUD showErrorWithStatus:@"服务器返回数据错误"];
        return;
    }
    
    int state=[[responseObject objectForKey:@"Code"] intValue];
    
    if(state==0){
//        NSLog(@"correct data:%@",[responseObject objectForKey:@"data"]);
        sucessBlock([responseObject objectForKey:@"Message"]);
        return;
    }
//    NSLog(@"fail data:%@",[responseObject objectForKey:@"fieldErrors"]);
    NSMutableArray *array=[FieldError mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"fieldErrors"]];
    if (array && [array count]>0) {
        FieldError *error1=array[0];
        if (error1.field==-6) {

        }else {
            [SVProgressHUD showErrorWithStatus:error1.message];
        }
//        backFailBlock([responseObject objectForKey:@"fieldErrors"]);
        backFailBlock(array);
    }
}

+(id)getRequestWithUrl:(NSString *)url params:(NSMutableDictionary *)params showTips:(NSString *)showTips tipsType:(SVProgressHUDMaskType) type sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock successBackFailedBlock:(SuccessBackFailureBlock)backFailBlock
{
    if (![[UtilString getNoNilString:showTips] isEqualToString:@""]) {
        [SVProgressHUD showWithStatus:showTips maskType:type];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager GET:url
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
//              [SVProgressHUD dismiss];
              NSLog(@"url:%@   para:%@  result:%@",url,params,responseObject);
//              [self parsingRequestBack:responseObject sucessBlock:sucessBlock failBlock:backFailBlock];
              sucessBlock(responseObject);
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//              [SVProgressHUD dismiss];
              [SVProgressHUD showErrorWithStatus:REQUEST_ERROR];

              NSLog(@"url:%@   para:%@  error:%@",url,params,error);
              failBlock(error);
          }];
    return nil;
    
    
}

+(id)postRequestWithUrl:(NSString *)url params:(NSMutableDictionary *)params showTips:(NSString *)showTips tipsType:(SVProgressHUDMaskType) type sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock successBackFailedBlock:(SuccessBackFailureBlock)backFailBlock
{
    if (![[UtilString getNoNilString:showTips] isEqualToString:@""]) {
        [SVProgressHUD showWithStatus:showTips maskType:type];
    }
    

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager POST:url
      parameters:params
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [SVProgressHUD dismiss];

             NSLog(@"url:%@   para:%@  result:%@",url,params,responseObject);
             sucessBlock(responseObject);
//             [self parsingRequestBack:responseObject sucessBlock:sucessBlock failBlock:backFailBlock];

         } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"url:%@   para:%@  error:%@",url,params,error);
//         [SVProgressHUD dismiss];
         [SVProgressHUD showErrorWithStatus:REQUEST_ERROR];

             failBlock(error);
         }];
    return nil;
}


/**
 *  AFNetWorking Request Method With Images
 *
 *  @param url         地址
 *  @param params      参数
 *  @param dataArray   图片数组
 *  @param sucessBlock 成功block
 *  @param failBlock   失败block
 *  @param fileType   传的文件类型  1： 图片   2 文件
 *  @return nil 
 */
//+(id)requestWithUrl:(NSString *)url params:(NSMutableDictionary *)params showTips:(NSString *)showTips tipsType:(SVProgressHUDMaskType) type dataArray:(NSArray *)dataArray imageName:(NSArray *)fileName fileType:(NSArray *)fileType sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock  successBackFailedBlock:(SuccessBackFailureBlock)backFailBlock
//{
//    if (![[UtilString getNoNilString:showTips] isEqualToString:@""]) {
//        [SVProgressHUD showWithStatus:showTips maskType:type];
//    }
//    
//
//    NSMutableURLRequest *request =
//    [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST"
//                                                               URLString:url
//                                                              parameters:params
//                                               constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {                                                   for (NSInteger i = 0; i<[dataArray count]; i++) {
//       
//        if ([fileType[i] intValue]==1) {
//            [formData appendPartWithFileData:dataArray[i]
//                                        name:fileName[i]
//                                    fileName:[NSString stringWithFormat:@"%@.jpg",fileName[i]]
//                                    mimeType:@"image/png"];
//        }
//                                                                                                        }
//                                               }
//                                                                   error:nil];
//    
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    NSProgress *progress = nil;
//    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request
//                                                                       progress:&progress
//                                                              completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//
//                                                                  if (error) {
//                                                                      [SVProgressHUD showErrorWithStatus:REQUEST_ERROR];
//
////                                                                      NSLog(@"Error: %@", error);
//                                                                      failBlock(error);
//                                                                  } else {
//                                                                      [SVProgressHUD dismiss];
//
////                                                                      NSLog(@"response:%@", responseObject);
////                                                                          sucessBlock(responseObject);
//                                                                      [self parsingRequestBack:responseObject sucessBlock:sucessBlock failBlock:backFailBlock];
//
//                                                                }
//                                                              }];
//    [uploadTask resume];
//    
//    return nil;
//}
//
//+(id)requestWithFileUrl:(NSString *)url params:(NSMutableDictionary *)params showTips:(NSString *)showTips tipsType:(SVProgressHUDMaskType) type dataArray:(NSArray *)dataArray imageName:(NSArray *)fileName fileType:(NSArray *)fileType sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock successBackFailedBlock:(SuccessBackFailureBlock)backFailBlock
//{
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager POST:url parameters:params constructingBodyWithBlock:^(id formData) {
//        //        [formData appendPartWithFileURL:filePath name:@"image" error:nil];
//        for (NSInteger i = 0; i<[dataArray count]; i++) {
//            
//            if ([fileType[i] intValue]==1) {
//                UIImage *img=dataArray[i];
//                [formData appendPartWithFileData:UIImageJPEGRepresentation(img, 0.5)
//                                            name:fileName[i]
//                                        fileName:[NSString stringWithFormat:@"%@.jpg",fileName[i]]
//                                        mimeType:@"image/png"];
//            }else if ([fileType[i] intValue]==2){
//                //[formData appendPartWithFileURL:dataUrl name:@"audio" fileName:@"intro.amr" mimeType:@"audio/AMR" error:nil];
//                NSString *str=[fileName[i] isEqualToString:@""]?@"audio":fileName[i];
//                [formData appendPartWithFileData:dataArray[i]
//                                            name:str
//                                        fileName:[NSString stringWithFormat:@"%@.amr",str]
//                                        mimeType:@"audio/AMR"];
//                
//            }
//        }
//        
//        
//        
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //        NSLog(@"Success: %@", responseObject);
//        [self parsingRequestBack:responseObject sucessBlock:sucessBlock failBlock:backFailBlock];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//        failBlock(error);
//    }];
//    
//    
//    return nil;
//}


+(id)requestVideoFileUrl:(NSString *)url params:(NSMutableDictionary *)params dataWithUrl:(NSURL *)dataUrl sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock successBackFailedBlock:(SuccessBackFailureBlock)backFailBlock
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:params constructingBodyWithBlock:^(id formData) {
        //        [formData appendPartWithFileURL:filePath name:@"image" error:nil];
        [formData appendPartWithFileURL:dataUrl name:@"audio" fileName:@"intro.amr" mimeType:@"audio/AMR" error:nil];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"Success: %@", responseObject);
        [self parsingRequestBack:responseObject sucessBlock:sucessBlock failBlock:backFailBlock];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        failBlock(error);
    }];
    
    
    return nil;
}



+ (id)updataImageRequestWithUrl:(NSString *)url params:(NSMutableDictionary *)params showTips:(NSString *)showTips tipsType:(SVProgressHUDMaskType)type image:(UIImage *)image imageName:(NSString *)imageName sucessBlock:(SucessBlock)sucessBlock failBlock:(FailureBlock)failBlock  successBackFailedBlock:(SuccessBackFailureBlock)backFailBlock
{
    
    if (![[UtilString getNoNilString:showTips] isEqualToString:@""]) {
        [SVProgressHUD showWithStatus:showTips maskType:type];
    }
    
    //需要按照旋转后的方向重置图片的方向
//    image = [UIImage imageWithCGImage:image.CGImage scale:1.0 orientation:UIImageOrientationRight];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    /**
     *  appendPartWithFileURL   //  指定上传的文件
     *  name                    //  指定在服务器中获取对应文件或文本时的key
     *  fileName                //  指定上传文件的原始文件名
     *  mimeType                //  指定商家文件的MIME类型
     */
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5)
                                    name:imageName
                                fileName:[NSString stringWithFormat:@"%@.jpg",imageName]
                                mimeType:@"image/png"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [SVProgressHUD showSuccessWithStatus:showTips];
         
         NSLog(@"url:%@   para:%@  result:%@",url,params,responseObject);
         //             sucessBlock(responseObject);
         [self parsingRequestBack:responseObject sucessBlock:sucessBlock failBlock:backFailBlock];

     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"url:%@   para:%@  error:%@",url,params,error);
         
         [SVProgressHUD showErrorWithStatus:@"图片上传失败"];
         
         failBlock(error);

     }];
    
    return nil;

}

+(void)requestCity{
    
}

@end
