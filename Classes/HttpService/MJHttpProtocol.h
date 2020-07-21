//
//  RRTHttpProtocol.h
//  rrtApp
//
//  Created by yuangang on 15/3/27.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpCommBaseReq.h"
#import "MJAppModel.h"
#import <UIKit/UIKit.h>

@interface MJHttpProtocol : NSObject


@end


/**
 * 用户登录
 */
@interface MJLoginMainReq : HttpCommBaseReq

/**
 * 用户登录接口
 */
-(void)userLoginData:(void(^)(id objects,BOOL isSuccess)) callBack;

/**
 * 获取用户信息
 */
-(void)findAccountInfoData:(void(^)(id objects,BOOL isSuccess)) callBack;

@end


/**
 * 系统主页
 */
@interface MJHomeMainReq : HttpCommBaseReq

/**
 * 查询设备列表
 */
-(void)fetchDeviceTypeListData:(void(^)(id objects,BOOL isSuccess)) callBack;

/**
 * 查询用户亲友列表
 */
-(void)fetchAccountRelationListData:(void(^)(id objects,BOOL isSuccess)) callBack;


/**
 * 查询亲友体重记录
 */
-(void)fetchRelationWeightListData:(void(^)(id objects,BOOL isSuccess)) callzback;



@end


/**
 * 添加用户信息
 */
@interface MJAddUserInfoReq : HttpCommBaseReq

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) RelationUserItem *userItem;

/**
 * 添加亲友信息
 */
-(void)addRelationUserInfoData:(void(^)(id objects,BOOL isSuccess)) callBack;

/**
 * 更新亲友信息
 */
-(void)updateRelationUserInfoData:(void(^)(id objects,BOOL isSuccess)) callBack;

/**
 * 获取亲友关系列表
 */
-(void)fetchRelationListData:(void(^)(id objects,BOOL isSuccess)) callBack;

/**
 * 用户头像上传
 */
-(void)uploadRelationAvatarData:(void(^)(id objects,BOOL isSuccess)) callBack;

@end


/**
 * 我的设备
 */
@interface MJSetMainReq : HttpCommBaseReq

/**
 * 查询我的设备列表
 */
-(void)fetchMyDeviceListData:(void(^)(id objects,BOOL isSuccess)) callBack;


/**
 * 注册设备
 */
-(void)registerDeviceData:(void(^)(id objects,BOOL isSuccess)) callBack;


/**
 * 解绑设备
 */
-(void)unBindDeviceData:(void(^)(id objects,BOOL isSuccess)) callBack;


@end


/**
 * 亲友详情
 */
@interface MJRelationDetailsReq : HttpCommBaseReq

/**
 * 获取亲友详情
 */
-(void)findRelationDeailsByIdData:(void(^)(id objects,BOOL isSuccess)) callBack;

@end


/**
 * 获取健康报告
 */
@interface MJMesureReportReq : HttpCommBaseReq


/**
 * 获取健康报告
 */
-(void)findMesureReportData:(void(^)(id objects,BOOL isSuccess)) callBack;

/**
 * 获取指标标准字典集
 */
-(void)fetchIndexStandarData:(void(^)(id objects,BOOL isSuccess)) callBack;


@end


