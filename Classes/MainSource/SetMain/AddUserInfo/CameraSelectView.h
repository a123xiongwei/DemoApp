//
//  ImageSelectView.h
//  CalligraphyApp
//
//  Created by 熊伟 on 2018/12/7.
//  Copyright © 2018年 熊伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CameraSelectView : UIView

@property (nonatomic, strong) IBOutlet UIView *bgView;
@property (nonatomic, strong) IBOutlet UIButton *cancelBtn;
@property (nonatomic, strong) IBOutlet UIButton *itemfBtn;
@property (nonatomic, strong) IBOutlet UIButton *itemsBtn;
@property (nonatomic, strong) IBOutlet UIView *conView;

-(void)dissAlertSelectView:(void(^)(void)) callBack;

@end

NS_ASSUME_NONNULL_END
