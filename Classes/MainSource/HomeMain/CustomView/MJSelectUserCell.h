//
//  MJSelectUserCell.h
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/7.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJAppModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MJSelectUserCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *avatarImg;
@property (nonatomic, strong) IBOutlet UILabel *nameLa;
@property (nonatomic, strong) IBOutlet UILabel *desLa;
@property (nonatomic, strong) IBOutlet UIImageView *selImg;

-(void)configCellData:(RelationUserItem *)userItem;

@end

NS_ASSUME_NONNULL_END
