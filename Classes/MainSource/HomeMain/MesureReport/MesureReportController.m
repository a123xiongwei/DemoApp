//
//  MesureReportController.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/12.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "MesureReportController.h"
#import "MJIndexProgressView.h"
#import "AppConstants.h"
#import "MJNavgationBarView.h"
#import "MesureReportCell.h"
#import "MesureReportModel.h"

@interface MesureReportController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UIView *headView;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIView *lineView;
@property (nonatomic, strong) IBOutlet UILabel *scoreLa;
@property (nonatomic, strong) IBOutlet UILabel *bodyAgeLa;
@property (nonatomic, strong) IBOutlet UILabel *timeLa;
@property (nonatomic, strong) IBOutlet UILabel *addweightLa;
@property (nonatomic, strong) IBOutlet UILabel *recommendLa;
@property (nonatomic, strong) MJIndexProgressView *proView;

@property (nonatomic, strong) MesureReportModel *reportModel;

@end

@implementation MesureReportController

/// <#Description#>
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mjTitle = @"身体报告(成人阶段)";
    self.lineView.cornerRadiusValue = self.lineView.width/2;
    self.reportModel = [[MesureReportModel alloc] init];
    
    self.proView = [[MJIndexProgressView alloc] init];
//    proView.backgroundColor = UIColor.yellowColor;
    self.proView.width = SCREEN_WIDTH - 90;
    self.proView.height = 90;
    self.proView.y = 50;
    self.proView.x = 30;
    self.proView.indexCounts = 5;
    [self.proView initSubViews];
    
    [self.headView addSubview:self.proView];
    
    [self initFindMesureReportDetailsData];
    
    [self fetchIndexStandarListData];
    
}

/**
 * 获取测量报告详情
 */
-(void)initFindMesureReportDetailsData{
    
    [[self.reportModel findMesureReportById:self.detalId] subscribeError:^(NSError *error) {
        
    } completed:^{
        [self configViewData];
        [self.tableView reloadData];
    }];
    
}

/**
 * 获取指标字典
 */
-(void)fetchIndexStandarListData{
    
    [[self.reportModel fetchIndexStandarList] subscribeError:^(NSError *error) {
        
    } completed:^{
        
    }];
    
}

/**
 * 配置报告信息
 */
-(void)configViewData{
    
    ReportDetailsItem *detailsItem = self.reportModel.detailsItem;
    if(detailsItem){
        self.bodyAgeLa.text = detailsItem.bodyAge;
        self.scoreLa.text = detailsItem.compositeScore;
        NSString *timeValue = detailsItem.matchTime;
        self.timeLa.text = timeValue;
        NSString *addWeight = detailsItem.addWeight;
        if([addWeight containsString:@"-"]){
            self.addweightLa.text = [NSString stringWithFormat:@"相比上一次瘦了%@kg",addWeight];
        }else{
            self.addweightLa.text = [NSString stringWithFormat:@"相比上一次重了%@kg",addWeight];
        }
//        self.recommendLa.text = detailsItem.suggest;
        self.proView.weightLa.text = detailsItem.relativesWeight;
        
        CGFloat maxValue = [BlueDataUtils findIndexLastValue:detailsItem.standardWeight];
        CGFloat moveValue = ((SCREEN_WIDTH - 90) * [detailsItem.relativesWeight floatValue])/maxValue;
        self.proView.tagImg.x = moveValue - self.proView.tagImg.width/2;
        
    }
    
}

-(void)mjPopViewController{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.reportModel.indexList ? self.reportModel.indexList.count : 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 73;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MesureReportCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MesureReportCell class])];
    IndexSubItem *subItem = self.reportModel.indexList[indexPath.row];
    [cell configCellData:subItem];
    
    return cell;
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//  [self.navigationController setNavigationBarHidden:NO animated:YES];
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
