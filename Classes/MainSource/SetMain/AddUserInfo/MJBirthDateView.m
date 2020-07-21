//
//  MJBirthDateView.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/15.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "MJBirthDateView.h"
#import "AppConstants.h"

@implementation MJBirthDateView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.conView.y = SCREEN_HEIGHT;
    self.width = SCREEN_WIDTH;
    self.height = SCREEN_HEIGHT;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.alpha = 0.5;
        self.conView.y = SCREEN_HEIGHT - 250;
    }];
    
    self.datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    
    
    [[self.cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self dissAlertSelectView:^{
            
        }];
    }];
    
    [[self.subBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self dissAlertSelectView:^{
            
        }];
    }];
}

-(void)dissAlertSelectView:(void(^)(void)) callBack{
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.alpha = 0;
        self.conView.y = SCREEN_HEIGHT;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
        callBack();
    }];
}

@end
