//
//  HttpCommService.h
//  rrtApp
//
//  Created by yuangang on 15/3/27.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPSessionManager.h>


@interface HttpCommService : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *manager;

/**
 *  添加一个HttpCommService的单例方法
 *
 *  @return HttpCommService
 */
+(HttpCommService *)instance;

/**
 *  添加一个GET请求的方法
 *
 *  @param urlString 网络请求子路径
 *  @param params    请求参数
 *  @param callBack  回调方法
 */
-(void)sendHttpGetMethod:(NSString *) urlString andParameters:(NSMutableDictionary *) params completion:(void(^)(id objects, BOOL isSuccess))callBack;

/**
 *  添加一个POST请求的方法
 *
 *  @param urlString 网络请求子路径
 *  @param params    请求参数
 *  @param callBack  回调方法
 */
-(void)sendHttpPostMethod:(NSString *) urlString andParameters:(NSMutableDictionary *) params completion:(void(^)(id objects, BOOL isSuccess))callBack;


-(void)sendHttpPostBodyMethod:(NSString *) urlString andParameters:(NSMutableDictionary *) params completion:(void(^)(id objects, BOOL isSuccess))callBack;

/**
 *  上传图片请求
 *
 *  @param path 请求路径
 *  @param callBack  回调方法
 *  @param image 要上传的图片
 */
- (void)uploadImagePath:(NSString*)path
         withParameters:(NSDictionary *)parameters
               andImage:(UIImage*)image
            andParaName:(NSString*)paraname
             completion:(void(^)(id objects, BOOL isSuccess))callBack;

@end
