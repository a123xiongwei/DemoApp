//
//  HomeMainController.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/5.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "HomeMainController.h"
#import "HomeMainCell.h"
#import "AppConstants.h"
#import "MJSelectUserView.h"
#import "MJMenuView.h"
#import "RelationDetailsController.h"
#import "MJWeekTrendView.h"
#import "AddHeightController.h"
#import "AddBabyRecordController.h"
#import "BindDeviceController.h"
#import "UIView+BlocksKit.h"
#import "VTScaleDemoController.h"
#import "ScaleTrendController.h"
#import "MJDataCacheManager.h"
#import <VTScales/VTScales.h>
#import "DeviceMeasureController.h"
#import "AddUserInfoController.h"
#import "VTMesureServer.h"
#import "HomeMainModel.h"
#import "HomeNoDataCell.h"
#import "MJBindSelectView.h"
#import <YYKit/UIImageView+YYWebImage.h>
#import "NSBundleUtils.h"
#import "CommUtils.h"

@interface HomeMainController ()<UITableViewDelegate,UITableViewDataSource,VTDeviceManagerDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIView *headView;
@property (nonatomic, strong) IBOutlet UIView *bottomView;
@property (nonatomic, strong) IBOutlet UIView *tabBottomView;
@property (nonatomic, strong) IBOutlet UIView *weView;
@property (nonatomic, strong) IBOutlet UIButton *addBtn;
@property (nonatomic, strong) IBOutlet UIButton *trendBtn;
@property (nonatomic, strong) IBOutlet UIButton *bindBtn;
@property (nonatomic, strong) IBOutlet UIView *noDataView;
@property (nonatomic, strong) IBOutlet UIButton *mesureBtn;
@property (nonatomic, strong) IBOutlet UILabel *bindLa;
@property (nonatomic, strong) IBOutlet UILabel *bmiLa;
@property (nonatomic, strong) IBOutlet UILabel *weightLa;
@property (nonatomic, strong) IBOutlet UILabel *fatRateLa;
@property (nonatomic, strong) IBOutlet UIImageView *avatarImg;
@property (nonatomic, strong) IBOutlet UILabel *nickNameLa;
@property (nonatomic, strong) IBOutlet UIButton *linkBtn;
@property (nonatomic, strong) IBOutlet UILabel *otherDesLa;
@property (nonatomic, strong) IBOutlet UIView *otherView;

@property (nonatomic) BOOL isReturnToMesure;
@property (nonatomic, strong) NSMutableArray *menuList;
@property (nonatomic, strong) MJMenuView *menuView;
@property (nonatomic, strong) HomeMainModel *homeModel;
@property (nonatomic) BOOL isWeightDevice;

@end

@implementation HomeMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.mjTitle = @"欢迎体验麦咭智能生活";
    self.tableView.bounces = NO;
    self.avatarImg.isRaidus = YES;
    self.weView.cornerRadiusValue = 11;
    self.linkBtn.isRaidus = YES;
    self.linkBtn.layer.borderColor = [CommUtils colorWithHexString:@"#00ADEF"].CGColor;
    self.linkBtn.layer.borderWidth = 1;
    self.isWeightDevice = YES;
    
    self.homeModel = [[HomeMainModel alloc] init];
    
    self.navigationItem.leftBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        NSLog(@"--------");
        
        [self.navigationController.navigationController popViewControllerAnimated:YES];
        
        return [RACSignal empty];
    }];
    
    //添加关联用户事件
    [[self.addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        AddUserInfoController *addCon = (AddUserInfoController *)[NSBundleUtils buildViewController:[AddUserInfoController class]];
        [self.navigationController pushViewController:addCon animated:YES];
        
        
    }];
    
    //体重趋势事件
    [[self.trendBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        ScaleTrendController *trendCon = (ScaleTrendController *)[NSBundleUtils buildViewController:[ScaleTrendController class]];
        [self.navigationController pushViewController:trendCon animated:YES];
        
    }];
    
    //设备绑定方法
    [[self.bindBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
//        return;
        BOOL isBind = [MJDataCacheManager isBindVTBlueDevice];
        if(isBind)return;
        
        MJBindSelectView *bindView = (MJBindSelectView *)[NSBundleUtils buildView:[MJBindSelectView class] owner:self];
        
        [bindView initBindListData:self.homeModel.subList callBack:^(DeviceSubItem * _Nonnull subItem) {
           
        }];
        
        [[bindView.subBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            BindDeviceController *bindDevice = (BindDeviceController *)[NSBundleUtils buildViewController:[BindDeviceController class]];
            bindDevice.productKey = bindView.subItem.productKey;
            [self.navigationController pushViewController:bindDevice animated:YES];
        }];
        
    }];
    
    //无数据测量体重事件
    [[self.mesureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        DeviceMeasureController *measureCon = (DeviceMeasureController *)[NSBundleUtils buildViewController:[DeviceMeasureController class]];
        [self.navigationController pushViewController:measureCon animated:YES];
        
    }];
    
    //无数据其他类型链接
    [[self.linkBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        BindDeviceController *bindDevice = (BindDeviceController *)[NSBundleUtils buildViewController:[BindDeviceController class]];
        bindDevice.productKey = @"";
        [self.navigationController pushViewController:bindDevice animated:YES];
        
    }];
    
    self.headView.width = SCREEN_WIDTH;
    
    [self initVTBlue];
    
    [self initFetchDeviceTypeListData];
    
    [self initFetchAccountRelationListData];
    
}

-(void)mjPopViewController{
    [self.navigationController.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isReturnToMesure = NO;
    [self initRefrshBindStatus];
    [self initFetchAccountRelationListData];
}

/**
 * 修改头部类型状态
 */
-(void)updateHeadTypeStatus:(int) menuType{
    
    if(menuType == 0){
        self.isWeightDevice = YES;
        self.tableView.tableFooterView = self.tabBottomView;
        self.otherView.hidden = YES;
        [self.tableView reloadData];
    }else{
        self.isWeightDevice = NO;
        self.tableView.tableFooterView = [[UIView alloc] init];
        self.otherView.hidden = NO;
        [self.tableView reloadData];
        if(menuType == 1){
            self.otherDesLa.text = @"您还没有连接麦咭学习机器人设备";
        }else if(menuType == 2){
            self.otherDesLa.text = @"您还没有连接麦咭智能手表设备";
        }else if(menuType == 3){
            self.otherDesLa.text = @"您还没有连接智能手环设备";
        }
    }
    
    
}

/**
 * 刷新绑定状态
 */
-(void)initRefrshBindStatus{
    
    BOOL isBind = [MJDataCacheManager isBindVTBlueDevice];
    if(isBind){
        self.bindLa.text = @"您没有连接麦咭智能秤，站秤上可以秤重哦~";
    }else{
        self.bindLa.text = @"您还没有连接麦咭智能秤，快去绑定设备吧。";
    }
    
}

/**
 * 头部视图设备类型初始化方法
 */
-(void)initHeadMenuViewData{
    
    for (int i = 0; i < self.menuList.count; i++) {
        
        int rowValue = i/2;
        int coloumValue = i % 2;
        MJMenuView *menuView = (MJMenuView *)[NSBundleUtils buildView:[MJMenuView class] owner:self];
        menuView.width = (self.headView.width - 45)/2;
        menuView.x = 10 + coloumValue *(25 + menuView.width);
        menuView.y = rowValue*(10 + menuView.height) + 250;
        [self.headView addSubview:menuView];
        
        if(i == 0){
            self.menuView = menuView;
        }
        
        DeviceTypeItem *typeItem = self.menuList[i];
        
        [menuView configViewData:typeItem];

        [[menuView.subBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            self.menuView.openImg.hidden = !self.menuView.hidden;
            self.menuView = menuView;
            self.menuView.openImg.hidden = NO;
            
            [self updateHeadTypeStatus:i];
            
        }];
    }
     
}

/**
 * 添加周视图初始化方法
 */
-(void)initAddWeekTrendViewData:(NSMutableArray *) weightList{
    
    for (int i = 0; i < 7; i++) {
        
        RelationWeightItem *weightItem;
        
        if(i < weightList.count){
            weightItem = weightList[i];
        }
        
        MJWeekTrendView *trendView = (MJWeekTrendView *)[NSBundleUtils buildView:[MJWeekTrendView class] owner:self];
        trendView.maxValue = 85;
        trendView.weightItem = weightItem;
        trendView.width = (SCREEN_WIDTH - 20)/7;
        trendView.x = i * trendView.width;
        [self.bottomView addSubview:trendView];
        
    }
    
    if(weightList.count ==0){
        self.noDataView.hidden = NO;
    }else{
        self.noDataView.hidden = YES;
    }
    
    [self.bottomView bringSubviewToFront:self.noDataView];
    
}

/**
 * 获取设备类型列表
 */
-(void)initFetchDeviceTypeListData{
    
    //本地缓存数据加载
    [[self.homeModel fetchNativeDeviceTypeList] subscribeCompleted:^{
       
        self.menuList = self.homeModel.deviceList;
        [self initHeadMenuViewData];
        
    }];
    
    [[self.homeModel fetchDeviceTypeList] subscribeError:^(NSError *error) {
        
    } completed:^{
        
        self.menuList = self.homeModel.deviceList;
        [self initHeadMenuViewData];
        
    }];
    
}

/**
 * 获取用户关系亲友列表
 */
-(void)initFetchAccountRelationListData{
    
    [[self.homeModel fetchAccountRelationList] subscribeError:^(NSError *error) {
        
    } completed:^{
        [self initFetchWegithListData];
        [self configWeightViewData];
        [self.tableView reloadData];
        
        BOOL isFinish = [MJDataCacheManager findRelationThisStatus];
        if(!isFinish && !self.isReturnToMesure){
            self.isReturnToMesure = YES;
            AddUserInfoController *addCon = (AddUserInfoController *)[NSBundleUtils buildViewController:[AddUserInfoController class]];
            addCon.isThis = YES;
            [self.navigationController pushViewController:addCon animated:YES];
        }
        
    }];
    
}

/**
 * 获取体重列表
 */
-(void)initFetchWegithListData{
    
    RelationUserItem *userItem = self.homeModel.myRelationItem;
    NSString *relationId = userItem.relativesId;
    
    [[self.homeModel fetchRelationWeightList:relationId] subscribeError:^(NSError *error) {
        
    } completed:^{
        [self initAddWeekTrendViewData:self.homeModel.weightList];
    }];
    
}

/**
 * 设置主页用户称重信息
 */
-(void)configWeightViewData{
    
    RelationUserItem *userItem = self.homeModel.myRelationItem;
    
    self.bmiLa.text = userItem.relativesBmi;
    self.weightLa.text = userItem.relativesWeight;
    self.fatRateLa.text = userItem.bodyFatRate ;
    
    UIImage *defImg = [NSBundleUtils buildImage:[self class] imageName:@"user_default"];
    [self.avatarImg setImageWithURL:[NSURL URLWithString:userItem.relativesPicUrl] placeholder:defImg];
    self.nickNameLa.text = [NSString stringWithFormat:@"%@(%@)",userItem.relativesNickName,@"成年人"];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger counts = self.homeModel.relationList.count;
    if(self.isWeightDevice){
        if(counts == 1){
            counts ++;
        }
    }else{
        return 0;
    }
    return counts;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat totalHeight = 86;
    NSInteger counts = self.homeModel.relationList.count;
    if(counts ==1){
        
        if(indexPath.row == 1){
            totalHeight = 150;
        }
    }
    return totalHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger counts = self.homeModel.relationList.count;
    if(counts == 1){
        
        if(indexPath.row == 1){
            
            HomeNoDataCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeNoDataCell class])];
            
            return cell;
            
        }else{
            HomeMainCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeMainCell class])];
            RelationUserItem *userItem = self.homeModel.relationList[indexPath.row];
            [cell configCellData:userItem];
            return cell;
        }
        
    }else{
        
        HomeMainCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeMainCell class])];
        RelationUserItem *userItem = self.homeModel.relationList[indexPath.row];
        [cell configCellData:userItem];
        return cell;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger counts = self.homeModel.relationList.count;
    
    if(counts != indexPath.row){
        RelationUserItem *relationItem = self.homeModel.relationList[indexPath.row];
        RelationDetailsController *detailsCon = (RelationDetailsController *)[NSBundleUtils buildViewController:[RelationDetailsController class]];
        detailsCon.relationId = relationItem.relativesId;
        [self.navigationController pushViewController:detailsCon animated:YES];
    }
    
}


/**
 * 蓝牙体脂秤的链接
 */
-(void)initVTBlue{
    
    VTDeviceManager *vtManager = [VTDeviceManager sharedInstance];
    vtManager.delegate = self;
    vtManager.key = @"EMV1VGRWSJIBFMKR";
    
    [self initStartBlueScan];
    
    BOOL isBindDevice = [MJDataCacheManager isBindVTBlueDevice];
    if(isBindDevice){
        
    }else{
        //跳转绑定设备页面
        
    }
    
}

/**
 * 设置开始扫描
 */
-(void)initStartBlueScan{
    
    VTDeviceManager *vtManager = [VTDeviceManager sharedInstance];
    //设置蓝牙开始扫描
    VTDeviceModelNumber *modelNumber1 = [[VTDeviceModelNumber alloc] initWithVersion:0x03 type:0x03 subType:0x10 vendor:0x0f];
    [vtManager scanWithTimeout:50 forDevicesWithModelNumbers:@[modelNumber1]];
}

#pragma mark -VTDeviceManagerDelete

-(void)deviceManager:(VTDeviceManager *)dm didReceiveDataJSONString:(NSString *)resultJson{
    
    NSLog(@"----didReceiveData-----%@",resultJson);
    if(resultJson.length == 0){
        return;
    }
    
    NSDictionary *resultData = [BlueDataUtils converStringToDictionary:resultJson];
    if(!resultData){
        return;
    }
    
    NSInteger code = [BlueDataUtils findBlueResultCode:resultJson];
    
    //获取体重
    NSString *weight = [BlueDataUtils findBlueResultWeight:resultJson];
    NSLog(@"----当前体重----%@",weight);
    
    [[VTMesureServer sharedManager] sendVTBlueMesureData:resultJson];
    
    //体重动态数据结果（设置用户信息）
    if(VTScaleStatusCodeWeightNormal == code){
       
        NSString *macValue = [BlueDataUtils findBlueDeviceMac:resultJson];
        NSString *userJson = [MJDataCacheManager findScaleUserJsonString];
        [dm setUserJSONString:userJson];
        
        BOOL isBindDevice = [MJDataCacheManager isBindVTBlueDeviceByMac:macValue];
        
        //跳转测量页面
        if(!self.isReturnToMesure && isBindDevice){
            
            self.isReturnToMesure = YES;
            DeviceMeasureController *measureCon = (DeviceMeasureController *)[NSBundleUtils buildViewController:[DeviceMeasureController class]];
            [self.navigationController pushViewController:measureCon animated:YES];
            
        }else{
            
            if(!self.isReturnToMesure){
                //选择绑定类型
                MJBindSelectView *bindView = (MJBindSelectView *)[NSBundleUtils buildView:[MJBindSelectView class] owner:self];
                
                [bindView initBindListData:self.homeModel.subList callBack:^(DeviceSubItem * _Nonnull subItem) {
                   
                }];
                
                [[bindView.subBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                    self.isReturnToMesure = YES;
                    BindDeviceController *bindDevice = (BindDeviceController *)[NSBundleUtils buildViewController:[BindDeviceController class]];
                    bindDevice.productKey = bindView.subItem.productKey;
                    [self.navigationController pushViewController:bindDevice animated:YES];
                }];
            }
            
        }
        
    //正常测量结果
    }else if(VTScaleStatusCodeNormal == code){
        
        NSLog(@"---获取正常称重结果---%@",resultData);
        
    }
    
}

-(void)deviceManagerDidStopScan:(VTDeviceManager *)deviceManager{
    
    NSLog(@"---deviceManagerDidStopScan---已停止扫描---");
    
    [NSTimer scheduledTimerWithTimeInterval:5 repeats:NO block:^(NSTimer * _Nonnull timer) {
        [self initStartBlueScan];
    }];
    
}

-(void)didConnected:(VTDeviceManager *)dm device:(VTDeviceModel *)device{
    
    NSLog(@"---didConnected---已链接---");
    
}

-(void)didDisconnected:(VTDeviceManager *)dm device:(VTDeviceModel *)device{
    
    NSLog(@"---didDisconnected---已断开连接---");
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
