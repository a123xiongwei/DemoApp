//
//  HttpCommBaseReq.m
//  rrtApp
//
//  Created by xiongwei on 15/3/30.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "HttpCommBaseReq.h"
#import "HttpCommDefine.h"
#import "HttpCommService.h"

@implementation HttpCommBaseReq

/**
 *  创建共同参数方法
 *
 *  @return 参数字典
 */
-(NSMutableDictionary *)createCommParams{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:@"IOS" forKey:@"platform"];
    return params;
}

/**
 *  拼接请求地址的方法
 *
 *  @param subUrl 子路径
 *
 *  @return 网络请求全路径
 */
-(NSString *)httpConnectUrl:(NSString *) subUrl{
    NSString *pathUrl = [NSString stringWithFormat:@"%@%@",BASEURL,subUrl];
    return pathUrl;
}


/**
 *  拼接请求地址的方法
 *
 *  @param subUrl 子路径
 *
 *  @return 网络请求全路径
 */
-(NSString *)httpMJConnectUrl:(NSString *) subUrl{
    NSString *pathUrl = [NSString stringWithFormat:@"%@%@",MJ_BASEURL,subUrl];
    return pathUrl;
}


@end
