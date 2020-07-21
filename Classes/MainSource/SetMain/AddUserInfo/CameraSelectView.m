//
//  ImageSelectView.m
//  CalligraphyApp
//
//  Created by 熊伟 on 2018/12/7.
//  Copyright © 2018年 熊伟. All rights reserved.
//

#import "CameraSelectView.h"
#import "AppConstants.h"

@implementation CameraSelectView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.conView.y = SCREEN_HEIGHT;
    self.width = SCREEN_WIDTH;
    self.height = SCREEN_HEIGHT;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.alpha = 0.5;
        self.conView.y = SCREEN_HEIGHT - 174;
    }];
    
    
    [[self.cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
