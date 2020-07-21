//
//  VTScaleDemoController.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/3.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "VTScaleDemoController.h"
#import "SettingsViewController.h"
#import "Settings.h"
#import <VTScales/VTScales.h>

typedef NS_ENUM(NSInteger, VTScaleStatusCode) {
    VTScaleStatusCodeNormal = 0, // 正常测量
    VTScaleStatusCodeWeightNormal = 200, // 体重动态数据
    VTScaleStatusCodeInternal = 3001, // 内部错误
    VTScaleStatusCodeRecordFail = 3002, // 创建访问记录失败
    VTScaleStatusCodeVendorNotExist = 4001, // 厂商不存在
    VTScaleStatusCodeVendorBanned = 4002, // 厂商被禁用
    VTScaleStatusCodeSourceUnknown = 4003, // 数据来源不明确
    VTScaleStatusCodeUserMissing = 4004, // 用户信息缺失
    VTScaleStatusCodeProtocolUnknown = 4005, // 协议类型未识别
    VTScaleStatusCodeUserInfoInvalid = 4006, // 用户信息出错
    VTScaleStatusCodeBMIOutRange = 4007, // BMI不在合理区间
    VTScaleStatusCodeRValueInvalid = 4008, // RValue无效，即没测到阻值(比如穿着鞋上称)
    VTScaleStatusCodeRValueOutRange = 4009, // RValue不在合理区间，如：Rvalue<300或RValue>4000
    VTScaleStatusCodeUnauthorized = 4010, // 未登录
    VTScaleStatusCodeKeywordMissing = 4011 // 请传入keyword参数
};

@interface VTScaleDemoController () <VTDeviceManagerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *fatLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *startScanButton;

@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSArray *keyArray;
@property (assign, nonatomic) BOOL isResetOrNo;
@property (strong, nonatomic) NSDictionary *reportDict;

@property (nonatomic, strong) VTDeviceModel *deviceModel;

@property (nonatomic, strong) NSMutableString *waveDataString; // 心率数据

@property (nonatomic, strong) NSString *jsonString;

@end

@implementation VTScaleDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"VTScaleDemo";

    VTDeviceManager *deviceManager = [VTDeviceManager sharedInstance];
    deviceManager.delegate = self;
    deviceManager.key = @"EMV1VGRWSJIBFMKR";
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    Settings *settings = [Settings sharedSettings];
    userInfo[@"age"] = @(settings.age);
    userInfo[@"height"] = @(settings.height);
    userInfo[@"gender"] = @(settings.gender);
    NSString *string = [self createStringFromDict:userInfo];
    [deviceManager setUserJSONString:string];

    [self.startScanButton addTarget:self action:@selector(startScanButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 80;
    
    UIBarButtonItem *settingsBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(settingsBarButtonItemTapped:)];
    self.navigationItem.rightBarButtonItem = settingsBarButtonItem;
    
    [self variableInit];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)startScanButtonTapped:(UIButton *)sender
{
    if ([sender.currentTitle isEqualToString:@"开始扫描"])
    {
        VTDeviceManager *deviceManager = [VTDeviceManager sharedInstance];
        VTDeviceModelNumber *modelNumber1 = [[VTDeviceModelNumber alloc] initWithVersion:0x03 type:0x03 subType:0x10 vendor:0x0f];
        [deviceManager scanWithTimeout:50 forDevicesWithModelNumbers:@[modelNumber1]];

        self.navigationItem.title = @"扫描中...";
        [sender setTitle:@"停止扫描" forState:UIControlStateNormal];
        
        self.reportDict = nil;
        [self.tableView reloadData];
        [self updateWeight:nil];
        [self updateFat:nil];
        self.waveDataString = [NSMutableString string];
    }
    else
    {
        VTDeviceManager *deviceManager = [VTDeviceManager sharedInstance];
        [deviceManager stopScan];
        [sender setTitle:@"开始扫描" forState:UIControlStateNormal];
    }
}

- (void)settingsBarButtonItemTapped:(UIBarButtonItem *)sender
{
//    SettingsViewController *vc = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
//    [self.navigationController pushViewController:vc animated:YES];
    
    VTDeviceManager *deviceManager = [VTDeviceManager sharedInstance];
    VTScaleUser *scaleUser = [[VTScaleUser alloc] init];
    Settings *settings = [Settings sharedSettings];
    scaleUser.age = @(settings.age);
    scaleUser.height = @(settings.height);
    scaleUser.gender = @(settings.gender);
    scaleUser.userID = 12;
    
    [deviceManager getReportWithDataId:self.jsonString user:scaleUser completionHandler:^(NSString *JSONString) {
        NSDictionary *result = [self convert2DictionaryWithJSONString:JSONString];
        NSLog(@"-------%@------",JSONString);
    }];
    
//    [deviceManager getReportWithDataString:self.jsonString user:scaleUser completionHandler:^(NSString *JSONString) {
//        NSLog(@"-------%@------",JSONString);
//    }];
    
    
    
}

- (NSDictionary *)convert2DictionaryWithJSONString:(NSString *)jsonString{
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"%@",err);
        return nil;
    }
    return dic;
}

- (void)variableInit
{
    self.nameArray = [[NSArray alloc] initWithObjects:
                @"rValue",
                @"weight",
                @"weightRange",
                @"weightWHORange",
                @"bmi",
                @"bmiRange",
                @"bmiWHORange",
                @"idealWeight",
                @"obesityLevel",
                @"ratioOfFat",
                @"ratioOfFatRange",
                @"weightOfFat",
                @"weightOfFatRange",
                @"ratioOfMuscle",
                @"ratioOfMuscleRange",
                @"weightOfMuscle",
                @"weightOfMuscleRange",
                @"ratioOfWater",
                @"ratioOfWaterRange",
                @"weightOfWater",
                @"weightOfWaterRange",
                @"ratioOfProtein",
                @"ratioOfProteinRange",
                @"weightOfProtein",
                @"weightOfProteinRange",
                @"bmr",
                @"bmrRange",
                @"ageOfBody",
                @"ageOfBodyRange",
                @"levelOfVisceralFat",
                @"levelOfVisceralFatRange",
                @"ratioOfSubcutaneousFat",
                @"ratioOfSubcutaneousFatRange",
                @"desirableWeight",
                @"weightOfBone",
                @"weightOfBoneRange",
                @"fatFreeBodyWeight",
                @"weightOfSkeletalMuscle",
                @"weightOfSkeletalMuscleRange",
                @"ratioOfSkeletalMuscle",
                @"ratioOfSkeletalMuscleRange",
                @"weightToControl",
                @"fatToControl",
                @"muscleToControl",
                @"bodyShape",
                @"stateOfNutrition",
                @"rateOfBurnFat",
                @"score",
                @"twoLegsImpedance",
                @"allBodyImpedance",
                @"leftLegImp",
                @"leftLegRatioOfFat",
                @"leftLegRatioOfMuscle",
                @"rightLegImp",
                @"rightLegRatioOfFat",
                @"rightLegRatioOfMuscle",
                @"leftArmImp",
                @"leftArmRatioOfFat",
                @"leftArmRatioOfMuscle",
                @"rightArmImp",
                @"rightArmRatioOfFat",
                @"rightArmRatioOfMuscle",
                @"sn",
                nil];
    
    self.keyArray = [[NSArray alloc] initWithObjects:
               @"阻值",
               //               weight
               @"体重",
               //               weightRange
               @"体重区间",
               //               weightWHORange
               @"体重国际版区间",
               //               bmi
               @"BMI",
               //               bmiRange
               @"BMI区间",
               //               bmiWHORange
               @"BMI国际版区间",
               //               idealWeight
               @"理想体重",
               //               obesityLevel
               @"肥胖等级",
               //               ratioOfFat
               @"体脂率",
               //               ratioOfFatRange
               @"体脂率区间",
               //               weightOfFat
               @"脂肪量",
               //               weightOfFatRange
               @"脂肪量区间",
               //               ratioOfMuscle
               @"肌肉含量",
               //               ratioOfMuscleRange
               @"肌肉含量区间",
               //               weightOfMuscle
               @"肌肉重量",
               //               weightOfMuscleRange
               @"肌肉重量区间",
               //               ratioOfWater
               @"水份含量",
               //               ratioOfWaterRange
               @"水份含量区间",
               //               weightOfWater
               @"水份重量",
               //               weightOfWaterRange
               @"水份重量区间",
               //               ratioOfProtein
               @"蛋白质含量",
               //               ratioOfProteinRange
               @"蛋白质含量区间",
               //               weightOfProtein
               @"蛋白质重量",
               //               weightOfProteinRange
               @"蛋白质重量区间",
               //               bmr
               @"基础代谢",
               //               bmrRange
               @"基础代谢区间",
               //               ageOfBody
               @"体年龄",
               //               ageOfBodyRange
               @"体年龄区间",
               //               levelOfVisceralFat
               @"内脏脂肪等级",
               //               levelOfVisceralFatRange
               @"内脏脂肪等级区间",
               //               ratioOfSubcutaneousFat
               @"皮下脂肪",
               //               ratioOfSubcutaneousFatRange
               @"皮下脂肪区间",
               //               desirableWeight
               @"标准体重",
               //               weightOfBone
               @"骨质",
               //               weightOfBoneRange
               @"骨质区间",
               //               fatFreeBodyWeight
               @"去脂体重",
               //               weightOfSkeletalMuscle
               @"骨骼肌",
               //               weightOfSkeletalMuscleRange
               @"骨骼肌区间",
               //               ratioOfSkeletalMuscle
               @"骨骼肌率",
               //               ratioOfSkeletalMuscleRange
               @"骨骼肌率区间",
               //               weightToControl
               @"体重控制量",
               //               fatToControl
               @"脂肪控制量",
               //               muscleToControl
               @"肌肉控制量",
               //               bodyShape
               @"体型等级",
               //               stateOfNutrition
               @"营养等级",
               //               rateOfBurnFat
               @"燃脂心率",
               //               score
               @"综合评分",
               //               twoLegsImpedance;
               @"双腿阻值",
               //               allBodyImpedance;
               @"八电极阻值",
               //               leftLegImpedance
               @"左腿阻值",
               //               bodyfatPercentageLeftLeg
               @"左腿脂肪率",
               //               musclePercentageLeftLeg
               @"左腿肌肉率",
               //               rightLegImpedance
               @"右腿阻值",
               //               bodyfatPercentageRightLeg
               @"右腿脂肪率",
               //               musclePercentageRightLeg
               @"右腿肌肉率",
               //               leftArmImpedance
               @"左臂阻值",
               //               bodyfatPercentageLeftArm
               @"左臂脂肪率",
               //               musclePercentageLeftArm
               @"左臂肌肉率",
               //               rightArmImpedance
               @"右臂阻值",
               //               bodyfatPercentageRightArm
               @"右臂脂肪率",
               //               musclePercentageRightArm
               @"右臂肌肉率",
               //               sn
               @"sn",
               nil];
    
}

- (void)updateWeight:(NSNumber *)weight
{
    if (weight)
    {
        self.weightLabel.text = [NSString stringWithFormat:@"%g", weight.doubleValue];
    }
    else
    {
        self.weightLabel.text = nil;
    }
}

- (void)updateFat:(NSNumber *)fat
{
    if (fat)
    {
        self.fatLabel.text = [NSString stringWithFormat:@"%g", fat.doubleValue];
    }
    else
    {
        self.fatLabel.text = nil;
    }
}

- (NSString *)createStringFromDict:(NSDictionary *)dict
{
    NSData *data = [NSData dataWithData:[NSJSONSerialization dataWithJSONObject:dict options:0 error:nil]];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (void)didReceiveScaleDataDict:(NSDictionary *)dict
{
    [self updateFat:dict[@"ratioOfFat"]];
    self.jsonString = dict[@"deviceInfo"][@"dataId"];
    self.reportDict = dict;
    [self.tableView reloadData];
}

- (void)didReceiveScaleDataDict:(NSDictionary *)dict withStatusCode:(VTScaleStatusCode)statusCode
{
    [self updateFat:dict[@"ratioOfFat"]];
    self.jsonString = dict[@"deviceInfo"][@"dataId"];
    self.reportDict = dict;
    [self.tableView reloadData];
}

#pragma mark - VTDeviceManagerDelegate

- (void)deviceManager:(VTDeviceManager *)dm didReceiveDataJSONString:(NSString *)JSONString
{
    NSLog(@"%s:%d %@", __func__, __LINE__, JSONString);
    
    if (JSONString.length == 0)
    {
        return;
    }
    
    NSData *data = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if (!dict)
    {
        return;
    }
    
    NSInteger code = [dict[@"code"] integerValue];
    NSDictionary *detailsDict = dict[@"details"];
    [self updateWeight:detailsDict[@"weight"]];
    
    if (VTScaleStatusCodeWeightNormal == code)
    {
        /**
         * 收到动态体重，设置用户信息，json字符串，{"age":26,"height":0,"gender":170}
         * 【这个是必须的 否则不会返回体脂数据】
         * age    : 年龄/岁
         * height : 身高/cm
         * gender :性别/ 0-男, 1-女, 2-男运动员, 3-女运动员
         */
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        Settings *settings = [Settings sharedSettings];
        userInfo[@"age"] = @(settings.age);
        userInfo[@"height"] = @(settings.height);
        userInfo[@"gender"] = @(settings.gender);
        NSString *string = [self createStringFromDict:userInfo];
        [dm setUserJSONString:string];
        self.jsonString = JSONString;
    }
    else if (VTScaleStatusCodeNormal == code)
    {
        [self didReceiveScaleDataDict:detailsDict];
    }
    else
    {
        [self didReceiveScaleDataDict:detailsDict withStatusCode:code];
    }
}

- (void)deviceManagerDidStopScan:(VTDeviceManager *)deviceManager
{
    NSLog(@"%s:%d %@", __func__, __LINE__, self);
    self.navigationItem.title = @"已停止扫描";
    [self.startScanButton setTitle:@"开始扫描" forState:UIControlStateNormal];
}

- (void)didConnected:(VTDeviceManager *)dm device:(VTDeviceModel *)device
{
    NSLog(@"%s:%d %@", __func__, __LINE__, device);
    self.navigationItem.title = @"已连接";
    self.deviceModel = device;
}

- (void)didDisconnected:(VTDeviceManager *)dm device:(VTDeviceModel *)device
{
    self.navigationItem.title = @"已断开连接";
    NSLog(@"%s:%d %@", __func__, __LINE__, device);
}

- (void)didServiceReady:(VTDeviceManager *)dm device:(VTDeviceModel *)device
{
    NSLog(@"%s:%d %@", __func__, __LINE__, self);
    
    // 仅适用于心率秤
    self.waveDataString = [NSMutableString string];
    [device enableHRDataWithTime:30 completionHandler:^(NSString *JSONString) {
        NSLog(@"%s:%d\n%@", __func__, __LINE__, JSONString);
        [self updateHeartRateDataJSONString:JSONString];
    }];
}

- (void)updateHeartRateDataJSONString:(NSString *)JSONString
{
    NSLog(@"%s:%d\n%@", __func__, __LINE__, JSONString);
    NSData *data = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

    NSInteger code = [dict[@"code"] integerValue];
    
    if (code == VTHeartRateScaleCodeWaveData)
    {
        NSDictionary *heartRateDataDict = dict[@"HRData"];
        NSString *waveform = heartRateDataDict[@"waveform"];
        NSLog(@"%s:%d\n%@", __func__, __LINE__, waveform);
        [self.waveDataString appendString:waveform];
    }
    else if (code == VTHeartRateScaleCodeWaveDataComplete)
    {
        NSLog(@"%s:%d\n%@", __func__, __LINE__, self);
    }
    else if (VTHeartRateScaleCodeCommunicationError == code)
    {
        NSLog(@"%s:%d\n%@", __func__, __LINE__, self);
    }
    else
    {
        NSLog(@"%s:%d\n%@", __func__, __LINE__, self);
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.keyArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
    }

    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.textColor = [UIColor grayColor];
    cell.detailTextLabel.numberOfLines = 0;
    NSString *key = [self.keyArray objectAtIndex:indexPath.row];
    cell.textLabel.text = key;
    if (_isResetOrNo) {
        cell.detailTextLabel.text = @"--";
    } else {
        
        if ([[self.reportDict allKeys] containsObject:[self.nameArray objectAtIndex:indexPath.row]])
        {
            NSString *string = [NSString stringWithFormat:@"%@",[self.reportDict objectForKey:[self.nameArray objectAtIndex:indexPath.row]]];
            string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
            cell.detailTextLabel.text = string;
        } else {
            cell.detailTextLabel.text = @"--";
        }
    }
    
    
    
    return cell;
}

@end
