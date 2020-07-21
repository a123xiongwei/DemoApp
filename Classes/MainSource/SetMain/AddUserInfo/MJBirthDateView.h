//
//  MJBirthDateView.h
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/15.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MJBirthDateView : UIView

@property (nonatomic, strong) IBOutlet UIView *bgView;
@property (nonatomic, strong) IBOutlet UIButton *cancelBtn;
@property (nonatomic, strong) IBOutlet UIButton *subBtn;
@property (nonatomic, strong) IBOutlet UIView *conView;
@property (nonatomic, strong) IBOutlet UIDatePicker *datePicker;

@end

NS_ASSUME_NONNULL_END
