//
//  MJBindSelectView.h
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/16.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJAppModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MJBindSelectView : UIView

@property (nonatomic, strong) IBOutlet UIView *conView;
@property (nonatomic, strong) IBOutlet UIButton *canBtn;
@property (nonatomic, strong) IBOutlet UIButton *subBtn;
@property (nonatomic, strong) DeviceSubItem *subItem;



-(void)initBindListData:(NSMutableArray *) bindList callBack:(void(^)(DeviceSubItem * subItem)) callBack;

@end

NS_ASSUME_NONNULL_END
