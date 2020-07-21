//
//  MJSelectUserView.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/5.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "MJSelectUserView.h"
#import "AppConstants.h"
#import "MJSelectUserCell.h"

@interface MJSelectUserView()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation MJSelectUserView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.conView.hidden = YES;
    self.height = SCREEN_HEIGHT;
    self.width = SCREEN_WIDTH;
    self.conView.cornerRadiusValue = 11;
    self.addBtn.isRaidus = YES;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.bgView.alpha = 0.5;
    }];
    
    [[self.canBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
         [self dissSelectView];
    }];
    
    [[self.addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self dissSelectView];
    }];
    
    [self initFetchManagerUserListData];
    
    
}

-(void)initFetchManagerUserListData{
    
    self.userList = [NSMutableArray array];
    [self.userList addObject:@"鱼小爱"];
    [self.userList addObject:@"鱼小胖"];
    [self.userList addObject:@"鱼得水"];
    [self.tableView reloadData];
    
}

-(void)showSelectView:(UIView *)supView{
    self.conView.hidden = NO;
    self.conView.y = supView.height;
    [UIKeyWindow addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        self.conView.y = supView.height - self.conView.height;
    }];
}

/**
 * 数据初始化 block回调方法
 */
-(void)initRelationUserList:(NSMutableArray *)userList callEventClick:(void(^)(RelationUserItem * userItem)) callBack{
    
    self.userList = userList;
    self.cellEventClick = callBack;
    [self.tableView reloadData];
}

-(void)dissSelectView{
    [UIView animateWithDuration:0.5 animations:^{
        self.bgView.alpha = 0;
        self.conView.y = SCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.userList ? self.userList.count : 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 78;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MJSelectUserCell *cell = (MJSelectUserCell *)[MJSelectUserCell findMainBundleByClassName:NSStringFromClass([MJSelectUserCell class]) owner:self];
    RelationUserItem *userItem = self.userList[indexPath.row];
    [cell configCellData:userItem];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self dissSelectView];
    RelationUserItem *userItem = self.userList[indexPath.row];
    self.cellEventClick(userItem);
}



@end
