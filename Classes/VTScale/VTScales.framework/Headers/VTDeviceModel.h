/** @file VTDeviceModel.h
 * @brief VTDeviceModel is the ble device defined by vtble sdk. Client could access the general functionalities of ble device by this class.
 * @author Kim.Yuan
 * [@author <Kim.yuan email:Kim.yuan@vtrump.com>]
 * @date 2012.09.14
 * @version 0.91
 * @copyright Vtrump
 */

#import <CoreBluetooth/CoreBluetooth.h>
#import "VTTypes.h"
#import "VTDeviceTime.h"
#import "VTUnit.h"

typedef NS_ENUM(NSInteger, VTHeartRateScaleCode) {
    VTHeartRateScaleCodeWaveData = 0, // 波形数据
    VTHeartRateScaleCodeCommunicationError = 1, // 通讯出错
    VTHeartRateScaleCodeWaveDataComplete = 10, // 波形数据完成
    VTHeartRateScaleCodeConnectorOffError = 11, // 导联出错
    VTHeartRateScaleCodeTestError = 12 // 测试出错
};

@class VTDeviceModel;

@protocol VTDeviceDelegate <NSObject>
@optional

/**
 *    @brief    notification of RSSI value changed
 *
 *    @param     device     device of RSSI value changed
 *    @param     rssi     rssi value
 */
- (void)didUpdateRssi:(VTDeviceModel *)device;

- (void)deviceModel:(VTDeviceModel *)deviceModel didSwitchToUnit:(VTUnit)unit;

- (void)deviceModeDidCalibrate:(VTDeviceModel *)deviceModel;

- (void)deviceModel:(VTDeviceModel *)deviceModel didSyncUnit:(VTUnit)unit;

- (void)deviceModel:(VTDeviceModel *)deviceModel unit:(VTUnit)unit;

- (void)deviceModel:(VTDeviceModel *)deviceModel time:(VTDeviceTime *)time;

- (void)deviceModeDidSyncTime:(VTDeviceModel *)deviceModel;

- (void)deviceModel:(VTDeviceModel *)deviceModel didSyncHistoryDataJSONString:(NSString *)JSONString;

- (void)deviceModel:(VTDeviceModel *)deviceModel didCertificateWithCipher:(NSData *)cipher;

- (void)deviceModel:(VTDeviceModel *)deviceModel didReadMCUId:(NSData *)MCUId;

@end

/**
 *	@brief	data model of ble device. Client could access all the capabilities of the device.
 */
@interface VTDeviceModel  : NSObject


/**
 *	@brief	delegate of VTDeviceModel
 */
@property (nonatomic, retain) id<VTDeviceDelegate> delegate;


/**
 *	@brief	RSSI value of ble device. It could be used to caculate the range together with txPower.
 */
@property (nonatomic, assign) NSNumber* rssi;


/**
 *	@brief	tx power value of ble device. It could be used to caculate the range together with rssi.
 */
@property (nonatomic, retain) NSNumber* txPower;




/**
 *	@brief	indicate the device is connectable or non-connectable.
 */
@property (nonatomic) VTDeviceConnectionType_t connectionType;



/**
 *	@brief	model type of ble devices
 */
@property (nonatomic) VTDeviceModelType_t modelType;



/**
 *	@brief	name of the device.
 */
@property (nonatomic, retain) NSString* name;


/**
 *	@brief	paired key of the device. It could be used to identify the device like BT address.
 */
@property (nonatomic, retain) NSData* pairedKey;


/**
 *	@brief	UUID of IOS system.
 */
@property (nonatomic, retain) NSString* UUID;


/**
 *	@brief	serial number to identify the vtble device global.
 */
@property (nonatomic, retain) NSData* serialNumber;


/**
 *	@brief	image url of the device.
 */
@property (nonatomic, retain) NSString* imageUrl;


/**
 *	@brief	status of the device.
 */
@property (nonatomic) VTDeviceStatusType_t statusType;


/**
 *	@brief	owner type of the device.
 */
@property (nonatomic) VTDeviceOwnerType_t ownerType;


/**
 *	@brief	self defined scenarioType by Client. 
 */
@property (nonatomic, retain) NSString * scenarioType;


/**
 *	@brief	indicate if this is a legal device.
 */
@property (nonatomic) BOOL isLegal;


/**
 *	@brief	it's the coreBluetooth peripheral.
 */
@property (nonatomic, strong) CBPeripheral * rawDevice;


/**
 *	@brief	gps latitude of the device.
 */
@property (nonatomic) double lat;


/**
 *	@brief	gps longitude of the device.
 */
@property (nonatomic) double lon;



/**
 *	@brief	gps altitude of the device.
 */
@property (nonatomic) double alt;


/**
 *	@brief the version of firmware
 */
@property (nonatomic, strong) NSString * firmwareVersion;


/**
 *	@brief	advertisement data of the device during discovering.
 */
@property (nonatomic, retain) NSData * advertisementData;


/**
 *	@brief	reserved dictionary for the client to use. user Data is stored permanently.
 */
@property (nonatomic, strong) NSMutableDictionary * userData;


/**
 *	@brief	dictionary for the client to use. meta Data is only valid for current active device and will be loss after application is killed.
 */
@property (nonatomic, strong) NSMutableDictionary * metaData;



/**
 *	@brief	security mode of the device.
 */
@property (nonatomic) UInt8 securityMode;


/**
 *	@brief	battery level of the device.
 */
@property (nonatomic) UInt8 batteryLevel;


/**
 *	@brief	disconnected reason of device. It's only valid for the device in disconnected status.
 */
@property (nonatomic) VTDeviceDisconnnectedReason_t disconnectedReason;

@property (nonatomic, copy, readwrite) NSString *macAddress;

/**
 *	@brief	reserved
 */
@property (nonatomic) UInt32 reserved;


#pragma mark -
#pragma mark public method declaration


/**
 *	@brief	connect current device.
 */
- (void)connect;


/**
 *	@brief	disconnect current device.
 */
- (void)disconnect;


/**
 *	@brief	check if the device is out of range
 *
 *	@param 	value 	proximity level
 *
 *	@return	YES is out of range. NO is in rage
 */
- (Boolean) isOutOfRange:(VTProximityAlertThreshold_t)value;


/**
 *	@brief	get the manufacture id from advertisement data.
 *
 *	@return	manufacture id.
 */
- (UInt16)getAdvertisementManufactureId;


/**
 *	@brief	get the 1st byte of the manufacture id (2 bytes).
 *
 *	@return	manufacture id.
 */
- (Byte)getManufactureByte1;


/**
 *	@brief	get the 2nd byte of the manufacture id (2 bytes).
 *
 *	@return	manufacture id.
 */
- (Byte)getManufactureByte2;


/**
 *	@brief	get type of advertisement.
 *
 *	@return	advertisement type.
 */
- (UInt8)getAdvertisementType;


/**
 *	@brief	get data of advertisement.
 *
 *	@return	advertisement data.
 */
- (NSData *)getAdvertisementData;


/**
 *	@brief	get unknown advertisement data which isn't pre-defined by vtble.
 *
 *	@return	advertisement data.
 */
- (NSData *)getUnknownAdvertisementData;


/**
 *	@brief	write data to the 16 bit characteristic UUID of 16 bit service UUID.
 *
 *	@param 	serviceUUID 	service UUID of BLE
 *	@param 	characteristicUUID 	characteristic UUID of BLE
 *	@param 	data 	data to write
 *	@param 	mode 	mode to write
 */
-(void) writeValue:(int)serviceUUID characteristicUUID:(int)characteristicUUID data:(NSData *)data mode:(int)mode;


/**
 *	@brief	read data from the 16 bit characteristic UUID of 16 bit service UUID.
 *
 *	@param 	characteristicUUID 	characteristic UUID
 */
-(void) readValue: (int)serviceUUID characteristicUUID:(int)characteristicUUID;

/**
 *	@brief	enable or disable the nofication of the 16 bit characteristic UUID of the 16 bit service UUID.
 *
 *	@param 	serviceUUID 	service UUID
 *	@param 	characteristicUUID 	characteristic UUID
 *	@param 	on 	YES to enable, NO to disable
 */
-(void) notification:(int)serviceUUID characteristicUUID:(int)characteristicUUID  on:(BOOL)on;


/**
 *	@brief	write data to the 128 bit characteristic UUID of 128 bit service UUID.
 *
 *	@param 	serviceUUID 	service UUID of BLE
 *	@param 	characteristicUUID 	characteristic UUID of BLE
 *	@param 	data 	data to write
 *	@param 	mode 	mode to write
 */
-(void) writeValuebyString:(NSString *)serviceUUID characteristicUUID:(NSString *)characteristicUUID  data:(NSData *)data mode:(int)mode;

/**
 *	@brief	read data from the 128 bit characteristic UUID of 128 bit service UUID.
 *
 *	@param 	characteristicUUID 	characteristic UUID
 */
-(void) readValuebyString: (NSString *)serviceUUID characteristicUUID:(NSString *)characteristicUUID;

/**
 *	@brief	enable or disable the nofication of the 128 bit characteristic UUID of the 128 bit service UUID.
 *
 *	@param 	serviceUUID 	service UUID
 *	@param 	characteristicUUID 	characteristic UUID
 *	@param 	on 	YES to enable, NO to disable
 */
-(void) notificationbyString:(NSString *)serviceUUID characteristicUUID:(NSString *)characteristicUUID  on:(BOOL)on;

- (void)switchToUnit:(VTUnit)unit;

- (void)syncUnit:(VTUnit)unit;

- (void)syncTime:(NSDate *)date;

- (void)syncHistoryData;

- (void)calibrate;

- (void)certificateWithRandom:(NSData *)random;

- (void)notifyDeviceApp;

- (void)readMCUId;

- (void)configureECGMeasurementTime:(int)time;

- (void)enableHRDataWithTime:(int)time completionHandler:(void (^)(NSString *JSONString))completionHandler;

- (void)disableHRData;

@end
