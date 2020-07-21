//
//  MJDeleteView.h
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/6.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MJDeleteView : UIView

@property (nonatomic, strong) IBOutlet UIButton *subBtn;
@property (nonatomic, strong) IBOutlet UIButton *canBtn;
@property (nonatomic, strong) FDAlertView *alertView;

@end

NS_ASSUME_NONNULL_END
