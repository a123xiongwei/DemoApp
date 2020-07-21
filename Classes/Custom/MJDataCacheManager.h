

#import <Foundation/Foundation.h>
#import "MJAppModel.h"

@interface MJDataCacheManager : NSObject

+(instancetype)sharedManager;

//@property (nonatomic ,strong) LevelDB *commDB;

/**
 * 获取成员信息json
 */
+(NSString *)findScaleUserJsonString;


-(BOOL)isLogin;


/**
* 是否初始化用户默认信息
*/
-(BOOL)isInitVTBlueInfo;

/**
 * 是否有绑定过蓝牙设备
 */
+(BOOL)isBindVTBlueDevice;

/**
* 是否绑定蓝牙体脂秤
*/
+(BOOL)isBindVTBlueDeviceByMac:(NSString *) mac;

/**
 * 保存麦咭安全秘钥
 */
+(void)saveMJSecurityToken:(NSString *) token;

/**
 * 获取麦咭安全秘钥
 */
+(NSString *)findMJSecurityToken;

/**
 * 保存系统token
 */
+(void)saveSystemToken:(NSString *)token;

/**
 * 获取系统Token
 */
+(NSString *)findSystemToken;

/**
 * 保存设备列表类型数据结果
 */
+(void)saveDeviceListJsonData:(id) objects;

/**
 * 获取本地数据列表类型结果
 */
+(id)findDeviceListData;


/**
 * 保存本地亲友列表
 */
+(void)saveRelationListJsonData:(id) objects;


/**
 * 保存自己成员信息方法
 */
+(void)saveRelationThisStatus:(NSString *)status;

/**
 * 获取自己成员信息的方法
 */
+(BOOL)findRelationThisStatus;


/**
 * 获取本地亲友列表
 */
+(id)findRelationListJsonData;


/**
 * 保存当前选择成员id
 */
+(void)saveCurrentRelationId:(NSString *)relationId;


/**
 * 获取当前默认的成员信息
 */
+(NSString *)findSelectRelationId;


/**
 * 获取当前选择的成员
 */
+(RelationUserItem *)findSelectRelationUserItem;


/**
 * 保存我的设备列表
 */
+(void)saveMyDeviceListJsonData:(id) objects;


/**
 * 获取本地设备列表数据
 */
+(id)findMyDeviceListJsonData;


/**
 * 保存理想值区间数据
 */
+(void)saveStandarListJsonData:(id) objects;


/**
 * 获取理想值区间数据
 */
+(id)findStandarListJsonData;


@end
