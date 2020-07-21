//
//  JJDataCacheManager.m
//  JingJing
//
//  Created by 熊伟 on 16/3/18.
//  Copyright © 2017年 熊伟. All rights reserved.
//
#import "MJDataCacheManager.h"
#import "BlueDataUtils.h"
#import "MJHttpDataUtils.h"
#import "CommUtils.h"

@implementation MJDataCacheManager

+ (instancetype)sharedManager{
    static dispatch_once_t onceToken;
    static MJDataCacheManager *shared;
    dispatch_once(&onceToken, ^{
        shared = [[MJDataCacheManager alloc] init];
        
    });
    return shared;
}

-(instancetype)init{
    self = [super init];
    if(self){
//        self.commDB = [LevelDB databaseInLibraryWithName:@"AppCommon"];
    }
    return self;
}

-(BOOL)isLogin{
    BOOL isLogin = NO;
    
    return isLogin;
}


/**
 * 获取成员信息json
 */
+(NSString *)findScaleUserJsonString{
    NSString *userJson = @"";
    NSMutableDictionary *userParams = [NSMutableDictionary dictionary];
    RelationUserItem *userItem = [self findSelectRelationUserItem];
    if(userItem){
        int ageValue = [CommUtils findUserAgeValueByTime:userItem.relativesBirthday];
        userParams[@"age"] = @(ageValue);
        userParams[@"height"] = @([userItem.relativesHeight intValue]);
        userParams[@"gender"] = @([userItem.relativesSex intValue]);
        userJson = [BlueDataUtils convertDictionyToString:userParams];
    }else{
        userParams[@"age"] = @(22);
        userParams[@"height"] = @(175);
        userParams[@"gender"] = @(1);
        userJson = [BlueDataUtils convertDictionyToString:userParams];
    }
    
    return userJson;
}


/**
 * 是否初始化用户默认信息
 */
-(BOOL)isInitVTBlueInfo{
    
    return YES;
}

+(BOOL)isBindVTBlueDevice{
    
    id objects = [MJDataCacheManager findMyDeviceListJsonData];
    NSMutableArray *bindList = [MJHttpDataUtils convertMyDeviceListJson:objects];
    return bindList.count  > 0 ? YES : NO;
    
}

/**
* 是否绑定蓝牙体脂秤
*/
+(BOOL)isBindVTBlueDeviceByMac:(NSString *) mac{
    
    BOOL isBind = NO;
    id objects = [MJDataCacheManager findMyDeviceListJsonData];
    NSMutableArray *bindList = [MJHttpDataUtils convertMyDeviceListJson:objects];
    
    for (BlueDeviceItem *deviceItem in bindList) {
        if([deviceItem.bluetoothAddress isEqualToString:mac]){
            isBind = YES;
            break;
        }
    }
    
    return isBind ;
}

/**
 * 保存麦咭安全秘钥
 */
+(void)saveMJSecurityToken:(NSString *) token{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:token forKey:@"MJToken"];
    [defaults synchronize];
    
}

/**
 * 获取麦咭安全秘钥
 */
+(NSString *)findMJSecurityToken{
    
    NSString *mjToken = @"";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    mjToken = [defaults objectForKey:@"MJToken"];
    if(!mjToken)
        mjToken = @"";
       
    return mjToken;
    
}

/**
 * 保存系统token
 */
+(void)saveSystemToken:(NSString *)token{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:token forKey:@"systemToken"];
    [defaults synchronize];
    
}

/**
 * 获取系统Token
 */
+(NSString *)findSystemToken{
    
    NSString *systemToken = @"";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    systemToken = [defaults objectForKey:@"systemToken"];
    if(!systemToken)
        systemToken = @"";
    
    return systemToken;
}

/**
 * 保存设备列表类型数据结果
 */
+(void)saveDeviceListJsonData:(id) objects{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:objects forKey:@"deviceTypeData"];
    [defaults synchronize];
    
}

/**
 * 获取本地数据列表类型结果
 */
+(id)findDeviceListData{
    
    id objects;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    objects = [defaults objectForKey:@"deviceTypeData"];
    if(!objects)
        objects = @"";
    
    return objects;
}


/**
 * 保存本地亲友列表
 */
+(void)saveRelationListJsonData:(id) objects{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:objects forKey:@"relationData"];
    [defaults synchronize];
    
}


/**
 * 保存自己成员信息方法
 */
+(void)saveRelationThisStatus:(NSString *)status{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:status forKey:@"relationThisStatus"];
    [defaults synchronize];
    
}

/**
 * 获取自己成员信息的方法
 */
+(BOOL)findRelationThisStatus{
    
    NSString *status;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    status = [defaults objectForKey:@"relationThisStatus"];
    if(status && [@"1" isEqualToString:status]){
        return YES;
    }
    
    return NO;
    
}


/**
 * 获取本地亲友列表
 */
+(id)findRelationListJsonData{
    
    id objects;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    objects = [defaults objectForKey:@"relationData"];
    if(!objects)
        objects = @"";
    
    return objects;
}

/**
 * 保存当前选择成员id
 */
+(void)saveCurrentRelationId:(NSString *)relationId{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:relationId forKey:@"relationId"];
    [defaults synchronize];
    
}


/**
 * 获取当前默认的成员信息
 */
+(NSString *)findSelectRelationId{
    
    NSString *relationId;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    relationId = [defaults objectForKey:@"relationId"];
    if(!relationId)
        relationId = @"";
    
    return relationId;
}


/**
 * 获取当前选择的成员
 */
+(RelationUserItem *)findSelectRelationUserItem{
    
    RelationUserItem *selUserItem ;
    NSString *relationId = [self findSelectRelationId];
    
    id objects = [self findRelationListJsonData];
    NSArray *relationList = [MJHttpDataUtils convertRelationUserListJson:objects];
    
    for (RelationUserItem *userItem in relationList) {
        if([relationId isEqualToString:userItem.relativesId]){
            selUserItem = userItem;
            break;
        }
    }
    
    return selUserItem;
}

/**
 * 保存我的设备列表
 */
+(void)saveMyDeviceListJsonData:(id) objects{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:objects forKey:@"myDeviceData"];
    [defaults synchronize];
    
}


/**
 * 获取本地设备列表数据
 */
+(id)findMyDeviceListJsonData{
    id objects;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    objects = [defaults objectForKey:@"myDeviceData"];
    if(!objects)
        objects = @"";
    
    return objects;
}


/**
 * 保存理想值区间数据
 */
+(void)saveStandarListJsonData:(id) objects{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:objects forKey:@"standarData"];
    [defaults synchronize];
    
}


/**
 * 获取理想值区间数据
 */
+(id)findStandarListJsonData{
    
    id objects;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    objects = [defaults objectForKey:@"standarData"];
    if(!objects)
        objects = @"";
    
    return objects;
    
}


@end
