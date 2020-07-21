//
//  AddUserInfoController.h
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/11.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJViewController.h"
#import "AppConstants.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddUserInfoController : MJViewController

@property (nonatomic, strong) RelationUserItem *userItem;
@property (nonatomic) BOOL isThis;

@end

NS_ASSUME_NONNULL_END
