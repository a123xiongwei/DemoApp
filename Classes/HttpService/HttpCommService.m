//
//  HttpCommService.m
//  rrtApp
//
//  Created by yuangang on 15/3/27.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "HttpCommService.h"
#import "HttpCommDefine.h"
#import "MJHttpProtocol.h"
#import "MJDataCacheManager.h"
#import "BlueDataUtils.h"

@implementation HttpCommService

/**
 *  添加一个HttpCommService的单例方法
 *
 *  @return HttpCommService
 */
+(HttpCommService *)instance{
    static HttpCommService *comInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        comInstance = [[HttpCommService alloc] init];
    });
    
    NSString *token = [MJDataCacheManager findSystemToken];
    if(![token isEqualToString:@""]){
        [comInstance.manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    }
    
    return comInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.manager = [AFHTTPSessionManager manager];
        
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        self. manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html", @"text/plain", @"application/json", @"image/jpeg", @"image/png",@"text/javascript", nil];
        self.manager.requestSerializer.timeoutInterval = 15;
    }
    return self;
}

/**
 *  添加一个GET请求的方法
 *
 *  @param urlString 网络请求子路径
 *  @param params    请求参数
 *  @param callBack  回调方法
 */
-(void)sendHttpGetMethod:(NSString *) urlString andParameters:(NSMutableDictionary *) params completion:(void(^)(id objects, BOOL isSuccess))callBack{
    NSLog(@"urlString == %@",urlString);
    
    NSString *mageeToken = [params objectForKey:@"mageeToken"];
    if(mageeToken){
        [self.manager.requestSerializer setValue:mageeToken forHTTPHeaderField:@"mageeToken"];
    }
    
    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [self.manager GET:urlString parameters:params progress:^(NSProgress * downloadProgress) {
        
    } success:^(NSURLSessionDataTask * task, id responseObject) {
        NSString *status = [NSString stringWithFormat:@"%@",responseObject[@"status"]];;
        if([status isEqualToString:@"0"]){
            
            callBack(responseObject,YES);
        }else{
            callBack(responseObject[@"msg"],NO);
        }
    } failure:^(NSURLSessionDataTask *task, NSError * error) {
        callBack(@"",NO);
    }];
}

/**
 *  添加一个POST请求的方法
 *
 *  @param urlString 网络请求子路径
 *  @param params    请求参数
 *  @param callBack  回调方法
 */
-(void)sendHttpPostMethod:(NSString *) urlString andParameters:(NSMutableDictionary *) params completion:(void(^)(id objects, BOOL isSuccess))callBack{
  
    if([urlString containsString:@"front/untieDevice"]){
        [self.manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    }else{
        [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    
    
    [self.manager POST:urlString parameters:params progress:^(NSProgress * uploadProgress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if([urlString hasPrefix:MJ_BASEURL]){
            NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"msgCd"]];
            
            if([code isEqualToString:@"00000"] || code){
                
                callBack(responseObject,YES);
            }else{
                callBack(responseObject[@"msgInfo"],NO);
            }
        }else{
            NSString *status = [NSString stringWithFormat:@"%@",responseObject[@"status"]];;
            if([status isEqualToString:@"0"]){
                callBack(responseObject,YES);
            }else{
                callBack(responseObject[@"message"],NO);
                NSLog(@"%@",responseObject[@"message"]);
            }
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError * error) {
        callBack(error,NO);
//        MLOG(@"%@", error);
    }];
}


-(void)sendHttpPostBodyMethod:(NSString *) urlString andParameters:(NSMutableDictionary *) params completion:(void(^)(id objects, BOOL isSuccess))callBack{
    
    [self.manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    
    [self.manager POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *status = [NSString stringWithFormat:@"%@",responseObject[@"status"]];;
        if([status isEqualToString:@"0"]){
            callBack(responseObject,YES);
        }else{
            callBack(responseObject[@"message"],NO);
            NSLog(@"%@",responseObject[@"message"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"");
    }];
    
}

    // 上传图片
- (void)uploadImagePath:(NSString*)path
     withParameters:(NSDictionary *)parameters
           andImage:(UIImage*)image
        andParaName:(NSString*)paraname
         completion:(void(^)(id objects, BOOL isSuccess))callBack{

    NSString *mageeToken = [parameters objectForKey:@"mageeToken"];
    if(mageeToken){
        [self.manager.requestSerializer setValue:mageeToken forHTTPHeaderField:@"token"];
    }
    
    [self.manager POST:path parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = UIImagePNGRepresentation(image);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
//        [formData appendPartWithFileData:data name:paraname fileName:fileName mimeType:@"image/png"];
        [formData appendPartWithFileData:data name:paraname fileName:fileName mimeType:@"image/png"];
     
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *message = responseObject[@"msgInfo"];
        NSLog(@"---%@---",message);
        
        callBack(responseObject,YES);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callBack(nil,NO);

    }];

}


@end
