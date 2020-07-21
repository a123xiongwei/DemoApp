//
//  MJSelectUserView.h
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/5.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJAppModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MJSelectUserView : UIView

@property (nonatomic, strong) IBOutlet UIView *bgView;
@property (nonatomic, strong) IBOutlet UIView *conView;
@property (nonatomic, strong) IBOutlet UIButton *canBtn;
@property (nonatomic, strong) IBOutlet UIButton *addBtn;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *userList;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *conHeightValue;
@property (nonatomic, strong) void(^cellEventClick)(RelationUserItem *userItem);

-(void)dissSelectView;

-(void)showSelectView:(UIView *)supView;

/**
 * 数据初始化 block回调方法
 */
-(void)initRelationUserList:(NSMutableArray *)userList callEventClick:(void(^)(RelationUserItem * userItem)) callBack;

@end

NS_ASSUME_NONNULL_END
