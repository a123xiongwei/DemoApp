//
//  DeviceMeasureController.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/11.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "DeviceMeasureController.h"
#import "AppConstants.h"
#import "VTMesureServer.h"
#import "BlueDataUtils.h"
#import "MesureReportController.h"
#import "CommUtils.h"
#import "MJSelectUserView.h"
#import "AddUserInfoController.h"
#import "HomeMainModel.h"
#import <VTScales/VTScales.h>
#import <IotLinkKit/IotLinkKit.h>
#import "NSBundleUtils.h"

@interface DeviceMeasureController ()

@property (nonatomic, strong) IBOutlet UIView *bgView;
@property (nonatomic, strong) IBOutlet UIView *conView;
@property (nonatomic, strong) IBOutlet UIButton *finishBtn;
@property (nonatomic, strong) IBOutlet UILabel *statusLa;
@property (nonatomic, strong) IBOutlet UILabel *weIntegerLa;
@property (nonatomic, strong) IBOutlet UILabel *weDecimalSLa;

@property (nonatomic, strong) HomeMainModel *homeModel;
@property (nonatomic, strong) NSString *resultData;
@property (nonatomic, strong) NSString *dataId;

@end

@implementation DeviceMeasureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.homeModel = [[HomeMainModel alloc] init];
    
    [self initConfigViewPro];
    
    //选择成员事件方法
    [[self.finishBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        MJSelectUserView *userView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MJSelectUserView class]) owner:self options:nil].lastObject;
        
        [userView initRelationUserList:self.homeModel.relationList callEventClick:^(RelationUserItem * _Nonnull userItem) {
            
            //保存当前选择成员id
            NSString *relativesId = userItem.relativesId;
            [MJDataCacheManager saveCurrentRelationId:relativesId];
            NSString *dataId = [BlueDataUtils findBlueResultDataId:self.resultData];
            
            //数据二次认领
            [self vTScaleClaimReport:dataId];
        
            
            
        }];
        
        [[userView.addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                   
            AddUserInfoController *addCon = (AddUserInfoController *)[NSBundleUtils buildViewController:[AddUserInfoController class]];
            [self.navigationController pushViewController:addCon animated:YES];
                   
        }];
        [userView showSelectView:self.view];
        
        
    }];
    
    //蓝牙秤结果监听
    [[VTMesureServer sharedManager] addReceiveVTBlueData:^(id  _Nonnull objects, NSString * _Nonnull weightValue) {
        NSLog(@"----体重结果----%@",weightValue);
        self.resultData = objects;
        [self initConfigViewData:weightValue];
        [self configVTBlueMesureStatus:YES];
    }];
    
    [self configVTBlueMesureStatus:NO];
    
    [self initFetchRelationUserListData];
    
}

/**
 * 获取本地亲友列表
 */
-(void)initFetchRelationUserListData{
    
    [[self.homeModel fetchNativeRelationUserList] subscribeCompleted:^{
        
    }];
    
}

/**
 * 数据二次认领
 */
-(void)vTScaleClaimReport:(NSString *)dataId{
    
    [self showHUDView];
    RelationUserItem *userItem = [MJDataCacheManager findSelectRelationUserItem];
    
    VTScaleUser *scaleUser = [[VTScaleUser alloc] init];
    scaleUser.gender = [userItem.relativesSex intValue];
    scaleUser.height = [userItem.relativesHeight intValue];
    int age = [CommUtils findUserAgeValueByTime:userItem.relativesBirthday];
    scaleUser.age = age;
    
    [[VTDeviceManager sharedInstance] getReportWithDataId:dataId user:scaleUser completionHandler:^(NSString *JSONString) {
        
        NSLog(@"%s:%d %@", __func__, __LINE__, JSONString);
        
        self.resultData = [BlueDataUtils convertMesureResultData:JSONString];
        self.dataId = [BlueDataUtils findBlueResultDataId:JSONString];
        
        NSMutableDictionary *params = [BlueDataUtils converStringToDictionary:self.resultData];
        
        NSDictionary *details = params[@"details"];
        NSMutableDictionary *detailsParamsDic = [NSMutableDictionary dictionaryWithDictionary:details];
       
        
        //设置上传用户信息
        NSMutableDictionary *userParams = [NSMutableDictionary dictionary];
        
        NSString *relativesId = [MJDataCacheManager findSelectRelationId];
        
        [userParams setValue:relativesId forKey:@"relativesId"];
        [userParams setValue:@"2020-07-18 11:36:00" forKey:@"date"];
        [userParams setValue:@"1" forKey:@"deviceId"];
        
        [detailsParamsDic setObject:userParams forKey:@"data"];
        
        [params setObject:detailsParamsDic forKey:@"details"];
        
//        params = [self readLocalFileWithName:@"iotjson"];
        
        [self initIotLinkSendMessage:params];
        
    }];
    
}

// 读取本地JSON文件
-(NSString *)readLocalFileWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"txt"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


/**
 * 物联网发送上行消息
 */
-(void)initIotLinkSendMessage:(NSDictionary *) paramsData{
    
    NSString *topic = @"/sys/a1LUEsftwNq/h6k2jqihABJjlWXRoDci/thing/event/property/post";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSString *paramsDataStr = [BlueDataUtils convertDictionyToString:paramsData];
    
    [params setObject:paramsDataStr forKey:@"detectData"];
    
    NSMutableDictionary *conParams = [NSMutableDictionary dictionary];
    [conParams setObject:@"547834662" forKey:@"id"];
    [conParams setObject:@"thing.event.property.post" forKey:@"method"];
    [conParams setObject:@"1.0" forKey:@"version"];
    [conParams setObject:params forKey:@"params"];
    
    NSString *content = [BlueDataUtils convertDictionyToString:conParams];
    content = [BlueDataUtils convertMesureResultData:content];
    
    NSLog(@"---%@---",content);
    int iqos = 1;
    
    [[LinkKitEntry sharedKit] publish:topic data:[content dataUsingEncoding:NSUTF8StringEncoding] qos:iqos resultBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
        if(succeeded){
            NSLog(@"----上行消息发送成功----");
            
            [NSTimer scheduledTimerWithTimeInterval:1 repeats:NO block:^(NSTimer * _Nonnull timer) {
                [self HUDHidden];
                MesureReportController *reportCon = (MesureReportController *)[NSBundleUtils buildViewController:[MesureReportController class]];
                reportCon.detalId = self.dataId;
                [self.navigationController pushViewController:reportCon animated:YES];
            }];
            
            
        }else{
            [self HUDHidden];
            NSLog(@"----上行消息发送失败----");
            [self showMessage:@"上传失败请重新尝试！"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }

    }];
    
    
    
    
    //上行返回
    //数据 : {"code":200,"data":{"msg":"tsl parse: params not exist","details":"tsl parse: params not exist","code":"tsl parse: params not exist"},"id":"547834662","message":"success","method":"thing.event.property.post","version":"1.0"}
    
}

-(void)initConfigViewPro{
    
    self.finishBtn.isRaidus = YES;
    self.conView.isRaidus = YES;
    self.bgView.width = SCREEN_WIDTH;
    self.bgView.height = SCREEN_HEIGHT;
    
    CAGradientLayer *bgLayer = [CommUtils findCGGradientLayer:CGSizeMake(self.bgView.width, self.bgView.height) withStartColors:[UIColor colorWithRed:0/255.0 green:173/255.0 blue:239/255.0 alpha:1.0] endColor:[UIColor colorWithRed:107/255.0 green:207/255.0 blue:245/255.0 alpha:1.0]];
    [self.bgView.layer addSublayer:bgLayer];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)configVTBlueMesureStatus:(BOOL) isFinish{
    
    if(isFinish){
        self.statusLa.text = @"选择成员";
        [self.finishBtn setTitle:@"选择成员" forState:UIControlStateNormal];
    }else{
        self.statusLa.text = @"正在测量";
        [self.finishBtn setTitle:@"正在测量" forState:UIControlStateNormal];
    }
    
}

-(void)initConfigViewData:(NSString *) weightValue{
    
    NSString *weInteger = [BlueDataUtils convertWeightInteger:weightValue];
    NSString *weDecimal = [BlueDataUtils convertWeightDecimal:weightValue];
    self.weIntegerLa.text = weInteger;
    self.weDecimalSLa.text = weDecimal;
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
