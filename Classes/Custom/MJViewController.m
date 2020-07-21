//
//  MJViewController.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/13.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "MJViewController.h"
#import "MJNavgationBarView.h"
#import "AppConstants.h"

@interface MJViewController ()

@property (nonatomic, strong) MJNavgationBarView *topBarView;

@end

@implementation MJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topBarView = [[MJNavgationBarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kTopHeight)];
    self.topBarView.backgroundColor = UIColor.clearColor;
    [[self.topBarView.backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self mjPopViewController];
    }];
    
    [self.view addSubview:self.topBarView];
    
}

-(void)mjPopViewController{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)setMjTitle:(NSString *)mjTitle{
    
    [self.topBarView.backBtn setTitle:[NSString stringWithFormat:@"  %@",mjTitle] forState:UIControlStateNormal];
    
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
