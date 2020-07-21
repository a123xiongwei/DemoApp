//
//  AddBabyRecordController.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/7.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "AddBabyRecordController.h"
#import "TXHRrettyRuler.h"
#import "AppConstants.h"

@interface AddBabyRecordController ()<TXHRrettyRulerDelegate>

@property (nonatomic, strong) IBOutlet UIView *headView;
@property (nonatomic, strong) IBOutlet UIView *heightView;
@property (nonatomic, strong) IBOutlet UIView *chestView;

@property (nonatomic, strong) TXHRrettyRuler *headRuler;
@property (nonatomic, strong) TXHRrettyRuler *heightRuler;
@property (nonatomic, strong) TXHRrettyRuler *chestRuler;

@property (nonatomic, strong) IBOutlet UIButton *subBtn;

@end

@implementation AddBabyRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.subBtn.isRaidus = YES;
    
    self.headView.width = SCREEN_WIDTH - 40;
    self.heightView.width = SCREEN_WIDTH - 40;
    
    self.headRuler = [[TXHRrettyRuler alloc] initWithFrame:CGRectMake(22, 25, self.headView.width-44, 90)];
    self.headRuler.rulerDeletate = self;
    [self.headRuler showRulerScrollViewWithCount:210 average:[NSNumber numberWithFloat:1] currentValue:160.0f smallMode:YES];
    [self.headView addSubview:self.headRuler];
    
    self.heightRuler = [[TXHRrettyRuler alloc] initWithFrame:CGRectMake(22, 25, self.headView.width-44, 90)];
    self.heightRuler.rulerDeletate = self;
    [self.heightRuler showRulerScrollViewWithCount:210 average:[NSNumber numberWithFloat:1] currentValue:160.0f smallMode:YES];
    [self.heightView addSubview:self.heightRuler];
    
    self.chestRuler = [[TXHRrettyRuler alloc] initWithFrame:CGRectMake(22, 25, self.headView.width-44, 90)];
    self.chestRuler.rulerDeletate = self;
    [self.chestRuler showRulerScrollViewWithCount:210 average:[NSNumber numberWithFloat:1] currentValue:160.0f smallMode:YES];
    [self.chestView addSubview:self.chestRuler];

    
    
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
