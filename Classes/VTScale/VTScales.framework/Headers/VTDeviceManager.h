/** @file VTDeviceManager.h
 * @brief vtble devie management. VTDeviceManager is a singleton and the entry of vtble SDK. Client could 1) Scan the unknown devices. 2) Retrieve the connected devices. 3) Get/Set the active device list. 4) Get/set the history list. Active list includes all the devices that have connected after the app is launched. History list includes all the devices that have been connected after the app is installed.
 * @author Kim.Yuan
 * [@author <Kim.yuan email:Kim.yuan@vtrump.com>]
 * @date 2012.09.14
 * @version 0.91
 * @copyright Vtrump
 */

#import <CoreLocation/CoreLocation.h>
#import "VTDeviceModel.h"

@class VTDeviceModelNumber;
@class VTScaleUser;

@protocol VTDeviceManagerDelegate;

/** @brief enum type of VTDeviceManagerStatus */
typedef enum {
    VTDMNone,
    VTDMScanning,
} VTDeviceManagerStatus;


/**
 *	@brief	device manager for all VTDeviceModel. It's a singleton. Client could access all the active and history devices.
 */
@interface VTDeviceManager:NSObject<CLLocationManagerDelegate>

/**
 *	@brief	protocol delegate of VTDeviceManagerDelegate
 */
@property (nonatomic, weak) id<VTDeviceManagerDelegate> delegate;


/**
 *  @brief  vendor identity string
 */
@property (nonatomic, copy) NSString *key;

/**
 *  @brief  A Boolean value indicating whether cloud calculation is enabled.
 */
@property (nonatomic, assign) BOOL cloudEnabled;

/**
 *  @brief  user JSON string
 */
@property (nonatomic, copy) NSString *userJSONString;

@property (nonatomic, strong) NSNumber *lowestRSSI;

@property (nonatomic, strong) NSDictionary *weightInterval;

/**
 *	@brief	singleton entry of VTDeviceManager
 *
 *	@return	the singleton instance of VTDeviceManager
 */
+ (instancetype)sharedInstance;


/**
 *	@brief	scan the devices with the service UUIDs.
 */
- (void)scan: (NSArray*) serviceUUIDs;


/**
 *	@brief	scan the devices with specified device model type.
 */
- (void)scanWithType: (VTDeviceModelType_t) type lockFirstDiscoveredProtocol:(Boolean) lockFirstDiscoveredProtocol;

- (void)scanWithTimeout:(NSUInteger)timeout forDevicesWithModelNumbers:(NSArray<VTDeviceModelNumber *> *)deviceModelNumbers;

/**
 *  @brief  scan the devices with specified device model type, not connect immediately after discover connectalbe device
 */
- (void)scanOnlyWithTimeout:(NSUInteger)timeout forDevicesWithModelNumbers:(NSArray<VTDeviceModelNumber *> *)deviceModelNumbers;

/**
 *  @brief  connect device with its UUID string
 */
- (void)connectDeviceWithUUIDString:(NSString *)string;

/**
 *  @brief  Cancels an active or pending local connection with UUID string
 */
- (void)cancelConnectionWithUUIDString:(NSString *)string;

/**
 *	@brief	scan the devices allow duplicate with the service UUIDs .
 */
- (void)scanWithDuplicate: (NSArray*) serviceUUIDs;

/**
 *	@brief	stop scanning.
 */
- (void)stopScan;

/**
 *	@brief	read device rssi.
 */
-(void)readDeviceRSSI:(VTDeviceModel *)device;


/**
 *  @brief  parse data and calculate fat data
 *
 *  @param  data  raw data from bluetooth
 *  @param  user  user info
 *  @param  completionHandler JSONString contains fat data
 */
- (void)parseData:(NSData *)data user:(VTScaleUser *)user completionHandler:(void (^)(NSString *JSONString))completionHandler;

/**
 *  return fat data JSON string, according to user info and his(her) weight
 */
- (NSString *)fatDataJSONStringForUserWithJSONString:(NSString *)string withWeight:(double)weight;

- (void)calculateForHistoryDataWithUUIDString:(NSString *)UUIDString user:(VTScaleUser *)user completionHandler:(void (^)(NSString *JSONString))completionHandler;

- (void)getReportWithDataId:(NSString *)dataId user:(VTScaleUser *)user completionHandler:(void (^)(NSString *JSONString))completionHandler;

- (void)getReportWithDataString:(NSString *)dataString user:(VTScaleUser *)user completionHandler:(void (^)(NSString *JSONString))completionHandler;

/**
 *  @brief Calculate fat data with advertisement data string and unstable weight data string
 *
 *  @param  advertisementDataString  Advertisement data hex string, seperated by '-'
 *  @param  weightDataString  Weight data hex string, seperated by '-', from characteristic’s value
 *  @param  user  User info
 *  @param  completionHandler JSONString contains fat data
*/
- (void)getReportWithAdvertisementDataString:(NSString *)advertisementDataString unstableWeightDataString:(NSString *)weightDataString user:(VTScaleUser *)user completionHandler:(void (^)(NSString *JSONString))completionHandler;

/**
 *  @brief Calculate fat data with advertisement data string and weight data string
 *
 *  @param  advertisementDataString  Advertisement data hex string, seperated by '-'
 *  @param  weightDataString  Weight data hex string, seperated by '-', from characteristic’s value
 *  @param  user  User info
 *  @param  completionHandler JSONString contains fat data
*/
- (void)getReportWithAdvertisementDataString:(NSString *)advertisementDataString weightDataString:(NSString *)weightDataString user:(VTScaleUser *)user completionHandler:(void (^)(NSString *JSONString))completionHandler;

@end

/**
 * @brief	the class implemented VTDeviceManagerDelegate could monitor all the notification of VTBLE.
 */
@protocol VTDeviceManagerDelegate <NSObject>
@optional

/**
 *	@brief	this method notify the implementer that a Bluetooth4.0 device will scan Allow Duplicates Key.
 *
 *	@param 	dm 	device manager
 *	@param 	device 	discovered device
 *  @return
 */
- (Boolean) didScanOptionAllowRepeatsKey:(VTDeviceManager*)dm;

/**
 *	@brief	this method notify the implementer that a Bluetooth4.0 device is detected. the implementer could get the device information for paramter device.
 *
 *	@param 	dm 	device manager
 *	@param 	device 	discovered device
 */
- (void) didConnected:(VTDeviceManager*)dm device:(VTDeviceModel *)device;

/**
 * @brief
 */
- (void) didStatusUpdate:(CBCentralManagerState) status;

/**
 *	@brief	this method notify the implementer that a Bluetooth4.0 device is connected with VTBLE. the implementer could get the device information for paramter device.
 *
 *	@param 	dm 	device manager
 *	@param 	device 	disconnected device
 */
- (void) didDisconnected:(VTDeviceManager*)dm device:(VTDeviceModel *)device;


/**
 *	@brief	this method notify the implementer that a Bluetooth4.0 device is connected and service ready by VTBLE. the implementer could get the device information for paramter device.
 *
 *	@param 	dm 	device manager
 *	@param 	device 	device of service ready
 */
- (void) didServiceReady:(VTDeviceManager*)dm device:(VTDeviceModel *)device;


- (void)deviceManagerDidStopScan:(VTDeviceManager *)deviceManager;

/**
 * @brief  this method notify the implementer that the advertisement scale is discovered.
 *
 *  @param  dm  device manager
 *  @param  JSONString  advertise scale JSON string
 */
- (void)deviceManager:(VTDeviceManager *)dm didReceiveDataJSONString:(NSString *)JSONString;

- (void)deviceManager:(VTDeviceManager *)dm didDiscoverDevice:(VTDeviceModel *)device;

@end
