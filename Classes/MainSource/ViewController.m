//
//  ViewController.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/3.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "VTScaleDemoController.h"
#import "SettingsViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self.scaleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        VTScaleDemoController *scaleDemo = [[VTScaleDemoController alloc] initWithNibName:NSStringFromClass([VTScaleDemoController class]) bundle:nil];
        [self.navigationController pushViewController:scaleDemo animated:YES];
    }];
    
    [[self.setBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        SettingsViewController *setCon = [[SettingsViewController alloc] init];
        [self.navigationController pushViewController:setCon animated:YES];
    }];
    
}


@end
