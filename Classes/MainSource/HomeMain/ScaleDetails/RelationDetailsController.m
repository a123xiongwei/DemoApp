//
//  ScaleDetailsController.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/6.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "RelationDetailsController.h"
#import "RelationDetailsCell.h"
#import "AppConstants.h"
#import "RelationDetailsModel.h"
#import "AddUserInfoController.h"
#import "UITableView+ShowView.h"
#import "MesureReportController.h"
#import <YYKit/UIImageView+YYWebImage.h>
#import "NSBundleUtils.h"

@interface RelationDetailsController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIView *indexView;
@property (nonatomic, strong) IBOutlet UIImageView *avatarImg;
@property (nonatomic, strong) IBOutlet UIButton *editBtn;
@property (nonatomic, strong) IBOutlet UILabel *nickNameLa;
@property (nonatomic, strong) IBOutlet UILabel *bmiLa;
@property (nonatomic, strong) IBOutlet UILabel *bmiVaLa;
@property (nonatomic, strong) IBOutlet UILabel *weightVaLa;
@property (nonatomic, strong) IBOutlet UILabel *heightVaLa;

@property (nonatomic, strong) RelationDetailsModel *detailsModel;

@end

@implementation RelationDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mjTitle = @"欢迎体验麦咭智能生活";
    self.detailsModel = [[RelationDetailsModel alloc] init];
    
    self.indexView.cornerRadiusValue = 11;
    self.avatarImg.isRaidus = YES;
    self.editBtn.isRaidus = YES;
    self.editBtn.layer.borderWidth = 1;
    self.editBtn.layer.borderColor = UIColor.whiteColor.CGColor;
    
    //编辑事件方法
    [[self.editBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        AddUserInfoController *addInfo = (AddUserInfoController *)[NSBundleUtils buildViewController:[AddUserInfoController class]];
        RelationUserItem *userItem = [MJHttpDataUtils convertRelationUserItem:self.detailsModel.detailsItem];
        addInfo.userItem = userItem;
        [self.navigationController pushViewController:addInfo animated:YES];
        
    }];
    
    
    [self initFindRelationDetailsByIdData];
}

/**
 * 获取亲友详情
 */
-(void)initFindRelationDetailsByIdData{
    
    [[self.detailsModel findRelationDetailsById:self.relationId] subscribeError:^(NSError *error) {
        
    } completed:^{
        
        [self configHeadViewData:self.detailsModel.detailsItem];
        
        if(self.detailsModel.recordList.count == 0){
            [self.tableView showNoData:@"暂无记录" withYValue:50];
        }else{
            [self.tableView dissShowNoData];
        }
        [self.tableView reloadData];
        
    }];
    
}

/**
 * 设置详情数据
 */
-(void)configHeadViewData:(RelationDetailsItem *) detailsItem{
    
    self.nickNameLa.text = detailsItem.relativesNickName;
    self.bmiVaLa.text = detailsItem.relativesBmi ? detailsItem.relativesBmi : @"-";
    self.weightVaLa.text = detailsItem.relativesWeight ? detailsItem.relativesWeight : @"-";
    self.heightVaLa.text = detailsItem.relativesHeight;
    
    UIImage *deImg = [NSBundleUtils buildImage:[self class] imageName:@"user_default"];
    [self.avatarImg setImageWithURL:[NSURL URLWithString:detailsItem.relativesPicUrl] placeholder:deImg];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.detailsModel.recordList ? self.detailsModel.recordList.count : 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 94;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RelationDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RelationDetailsCell class])];
    RelationRecordItem *recordItem = self.detailsModel.recordList[indexPath.row];
    [cell configCellData:recordItem];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RelationRecordItem *recordItem = self.detailsModel.recordList[indexPath.row];
    MesureReportController *reportCon = (MesureReportController *)[NSBundleUtils buildViewController:[MesureReportController class]];
    reportCon.detalId = recordItem.dataId;
    [self.navigationController pushViewController:reportCon animated:YES];
    
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
