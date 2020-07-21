//
//  RRTHttpProtocol.m
//  rrtApp
//
//  Created by yuangang on 15/3/27.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "MJHttpProtocol.h"
#import "HttpCommDefine.h"
#import "HttpCommService.h"


@implementation MJHttpProtocol

@end


/**
* 用户登录
*/
@implementation MJLoginMainReq

/**
* 用户登录接口
*/
-(void)userLoginData:(void (^)(id objects, BOOL isSuccess))callBack{
    NSMutableDictionary *params = [self createCommParams];
    [params setObject:self.userName forKey:@"userName"];
    [params setObject:@"1" forKey:@"clientType"];
    [params setObject:self.userPwd forKey:@"userPwd"];
    NSString *pathUrl = [self httpMJConnectUrl:@"urm/login"];
    [[HttpCommService instance] sendHttpPostMethod:pathUrl andParameters:params completion:callBack];
}

/**
 * 获取用户信息
 */
-(void)findAccountInfoData:(void(^)(id objects,BOOL isSuccess)) callBack{
    
    NSMutableDictionary *params = [self createCommParams];
    [params setObject:self.mageeToken forKey:@"mageeToken"];
    NSString *pathUrl = [self httpConnectUrl:@"api/user/auth/front/getUserByMgToken"];
    [[HttpCommService instance] sendHttpGetMethod:pathUrl andParameters:params completion:callBack];
    
}

@end


/**
 * 系统主页
 */
@implementation MJHomeMainReq


/**
 * 查询设备列表
 */
-(void)fetchDeviceTypeListData:(void(^)(id objects,BOOL isSuccess)) callBack{
    
    NSMutableDictionary *params = [self createCommParams];
    NSString *pathUrl = [self httpConnectUrl:@"api/iot/goods/front/list"];
    [[HttpCommService instance] sendHttpGetMethod:pathUrl andParameters:params completion:callBack];
    
}

/**
 * 查询用户亲友列表
 */
-(void)fetchAccountRelationListData:(void(^)(id objects,BOOL isSuccess)) callBack{
    
    NSMutableDictionary *params = [self createCommParams];
    NSString *pathUrl = [self httpConnectUrl:@"api/magee/userRelatives/front/findUserRelatives"];
    [[HttpCommService instance] sendHttpGetMethod:pathUrl andParameters:params completion:callBack];
    
}


/**
 * 查询亲友体重记录
 */
-(void)fetchRelationWeightListData:(void(^)(id objects,BOOL isSuccess)) callBack{
    
    NSMutableDictionary *params = [self createCommParams];
    [params setObject:self.relativesId forKey:@"relativesId"];
    NSString *pathUrl = [self httpConnectUrl:@"api/magee/bodyFatDetail/front/findBodyFatRecord"];
    [[HttpCommService instance] sendHttpGetMethod:pathUrl andParameters:params completion:callBack];
    
}

@end


/**
 * 添加用户信息
 */
@implementation MJAddUserInfoReq

/**
 * 添加亲友信息
 */
-(void)addRelationUserInfoData:(void(^)(id objects,BOOL isSuccess)) callBack{
    
    NSMutableDictionary *params = [self createCommParams];
    
    if(self.userItem.relativesId){
        [params setObject:self.userItem.relativesId forKey:@"relativesId"];
    }
    if(self.userItem.relativesPicUrl){
        [params setObject:self.userItem.relativesPicUrl forKey:@"relativesPicUrl"];
    }
    
    [params setObject:self.userItem.relativesNickName forKey:@"relativesNickName"];
    [params setObject:self.userItem.relativesSex forKey:@"relativesSex"];
    [params setObject:self.userItem.relativesBirthday forKey:@"relativesBirthday"];
    [params setObject:self.userItem.relativesWith forKey:@"relativesWith"];
    [params setObject:self.userItem.relativesWithName forKey:@"relativesWithName"];
    [params setObject:self.userItem.relativesHeight forKey:@"relativesHeight"];
    
    NSString *pathUrl = [self httpConnectUrl:@"api/magee/userRelatives/front/addOrUpdateUserRelatives"];
    [[HttpCommService instance] sendHttpPostMethod:pathUrl andParameters:params completion:callBack];
}


/**
 * 更新亲友信息
 */
-(void)updateRelationUserInfoData:(void(^)(id objects,BOOL isSuccess)) callBack{
    
    
    
}


/**
* 获取用户关系列表
*/
-(void)fetchRelationListData:(void(^)(id objects,BOOL isSuccess)) callBack{
    
    NSMutableDictionary *params = [self createCommParams];
    [params setObject:self.name forKey:@"name"];
    NSString *pathUrl = [self httpConnectUrl:@"api/tool/paramDict/front/getDict"];
    [[HttpCommService instance] sendHttpGetMethod:pathUrl andParameters:params completion:callBack];
}

/**
 * 用户头像上传
 */
-(void)uploadRelationAvatarData:(void(^)(id objects,BOOL isSuccess)) callBack{
    
    NSMutableDictionary *params = [self createCommParams];
    [params setObject:@"file" forKey:@"file"];
    [params setObject:self.mageeToken forKey:@"mageeToken"];
    NSString *pathUrl = [self httpMJConnectUrl:@"aly/uploadImg"];
    [[HttpCommService instance] uploadImagePath:pathUrl withParameters:params andImage:self.image andParaName:@"file" completion:callBack];
    
}

@end


/**
 * 我的设备
 */
@implementation MJSetMainReq

/**
 * 查询我的设备列表
 */
-(void)fetchMyDeviceListData:(void(^)(id objects,BOOL isSuccess)) callBack{
    
    NSMutableDictionary *params = [self createCommParams];
    NSString *pathUrl = [self httpConnectUrl:@"api/magee/userDevice/front/findUserDevice"];
    [[HttpCommService instance] sendHttpGetMethod:pathUrl andParameters:params completion:callBack];
    
}


/**
 * 注册设备
 */
-(void)registerDeviceData:(void(^)(id objects,BOOL isSuccess)) callBack{
    
    NSMutableDictionary *params = [self createCommParams];
    [params setObject:self.mac forKey:@"mac"];
    [params setObject:self.productKey forKey:@"productKey"];
    [params setObject:self.bluetoothAddress forKey:@"bluetoothAddress"];
    [params setObject:self.serialNumber forKey:@"serialNumber"];
    NSString *pathUrl = [self httpConnectUrl:@"api/iot/device/front/registerDevice"];
    [[HttpCommService instance] sendHttpPostMethod:pathUrl andParameters:params completion:callBack];
    
}


/**
 * 解绑设备
 */
-(void)unBindDeviceData:(void(^)(id objects,BOOL isSuccess)) callBack{
    
    NSMutableDictionary *params = [self createCommParams];
    [params setObject:self.userDeviceId forKey:@"userDeviceId"];
    NSString *pathUrl = [self httpConnectUrl:@"api/magee/userDevice/front/untieDevice"];
    pathUrl = [NSString stringWithFormat:@"%@?userDeviceId=%@",pathUrl,self.userDeviceId];
//    [[HttpCommService instance] sendHttpPostMethod:pathUrl andParameters:params completion:callBack];
    [[HttpCommService instance] sendHttpPostBodyMethod:pathUrl andParameters:params completion:callBack];
    
}


@end


/**
 * 亲友详情
 */
@implementation MJRelationDetailsReq

/**
 * 获取亲友详情
 */
-(void)findRelationDeailsByIdData:(void(^)(id objects,BOOL isSuccess)) callBack{
    
    NSMutableDictionary *params = [self createCommParams];
    [params setObject:self.relativesId forKey:@"relativesId"];
    NSString *pathUrl = [self httpConnectUrl:@"api/magee/userRelatives/front/get"];
    [[HttpCommService instance] sendHttpGetMethod:pathUrl andParameters:params completion:callBack];
    
}

@end


/**
 * 获取健康报告
 */
@implementation MJMesureReportReq

/**
 * 获取健康报告
 */
-(void)findMesureReportData:(void(^)(id objects,BOOL isSuccess)) callBack{
    
    NSMutableDictionary *params = [self createCommParams];
    [params setObject:self.detailId forKey:@"dataId"];
    NSString *pathUrl = [self httpConnectUrl:@"api/magee/bodyFatDetail/front/getBodyFatRecordDetails"];
    [[HttpCommService instance] sendHttpGetMethod:pathUrl andParameters:params completion:callBack];
}

/**
 * 获取指标标准字典集
 */
-(void)fetchIndexStandarData:(void(^)(id objects,BOOL isSuccess)) callBack{
    
    NSMutableDictionary *params = [self createCommParams];
    [params setObject:self.name forKey:@"name"];
    NSString *pathUrl = [self httpConnectUrl:@"api/tool/paramDict/front/getDict"];
    [[HttpCommService instance] sendHttpGetMethod:pathUrl andParameters:params completion:callBack];
    
}

@end

