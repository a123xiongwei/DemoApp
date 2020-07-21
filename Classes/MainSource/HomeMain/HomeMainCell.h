//
//  HomeMainCell.h
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/5.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJAppModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeMainCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIView *conView;
@property (nonatomic, strong) IBOutlet UIImageView *avatarImg;
@property (nonatomic, strong) IBOutlet UILabel *nameLa;
@property (nonatomic, strong) IBOutlet UILabel *relationLa;
@property (nonatomic, strong) IBOutlet UILabel *weightLa;
@property (nonatomic, strong) IBOutlet UILabel *typeLa;

-(void)configCellData:(RelationUserItem *) userItem;

@end

NS_ASSUME_NONNULL_END
