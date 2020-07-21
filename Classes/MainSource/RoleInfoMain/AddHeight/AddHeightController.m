//
//  AddHeightController.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/7.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "AddHeightController.h"
#import "UIView+Extension.h"
#import "TXHRrettyRuler.h"
#import "AppConstants.h"

@interface AddHeightController ()<TXHRrettyRulerDelegate>

@property (nonatomic, strong) IBOutlet UIView *headView;
@property (nonatomic, strong) IBOutlet UIImageView *avatarImg;
@property (nonatomic, strong) IBOutlet UILabel *nickNameLa;
@property (nonatomic, strong) IBOutlet UIButton *subBtn;


@end

@implementation AddHeightController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mjTitle = @"欢迎体验麦咭智能生活";
    
    self.headView.cornerRadiusValue = 11;
    self.avatarImg.isRaidus = YES;
    self.subBtn.isRaidus = YES;
    
    //添加身高事件方法
    [[self.subBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    TXHRrettyRuler *ruler = [[TXHRrettyRuler alloc] initWithFrame:CGRectMake(0, 25, SCREEN_WIDTH - 30, 90)];
    ruler.rulerDeletate = self;
    [ruler showRulerScrollViewWithCount:210 average:[NSNumber numberWithFloat:1] currentValue:160.0f smallMode:YES];
    
    [self.headView addSubview:ruler];
}

- (void)txhRrettyRuler:(TXHRulerScrollView *)rulerScrollView {
    
//    self.heLa.text = [NSString stringWithFormat:@"%.0f CM",rulerScrollView.rulerValue];
    
    NSLog(@"------%@------",[NSString stringWithFormat:@"%.0f CM",rulerScrollView.rulerValue]);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
