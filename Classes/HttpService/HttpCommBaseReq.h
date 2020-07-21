//
//  HttpCommBaseReq.h
//  rrtApp
//
//  Created by xiongwei on 15/3/30.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpCommBaseReq : NSObject

//接口请求参数定义
@property (nonatomic, strong) NSString *pageNo;
@property (nonatomic, strong) NSString *pageSize;
@property (nonatomic, strong) NSString *userPwd;
@property (nonatomic, strong) NSString *clientType;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *mageeToken;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *mac;
@property (nonatomic, strong) NSString *productKey;
@property (nonatomic, strong) NSString *bluetoothAddress;
@property (nonatomic, strong) NSString *serialNumber;
@property (nonatomic, strong) NSString *userDeviceId;
@property (nonatomic, strong) NSString *relativesId;
@property (nonatomic, strong) NSString *detailId;


/**
 *  创建共同参数方法
 *
 *  @return 参数字典
 */
-(NSMutableDictionary *)createCommParams;

/**
 *  拼接请求地址的方法
 *
 *  @param subUrl 子路径
 *
 *  @return 网络请求全路径
 */
-(NSString *)httpConnectUrl:(NSString *) subUrl;


/**
 *  拼接请求地址的方法
 *
 *  @param subUrl 子路径
 *
 *  @return 网络请求全路径
 */
-(NSString *)httpMJConnectUrl:(NSString *) subUrl;



@end
