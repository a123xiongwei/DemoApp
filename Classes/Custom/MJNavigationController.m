//
//  HXNavigationController.m
//  01-微博
//
//  Created by Nowind on 15-6-22.
//  Copyright (c) 2015年 Nowind. All rights reserved.
//

#import "MJNavigationController.h"

@interface MJNavigationController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) id popDelegate;

@end

@implementation MJNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController != self.viewControllers[0]) {
        
        self.interactivePopGestureRecognizer.delegate = nil;
        
    }else{
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
        
    }
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    if (self.childViewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 自定义返回按钮
        UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(-20, 0 , 20, 20)];
        [leftBtn addTarget:self action:@selector(backPopViewController) forControlEvents:UIControlEventTouchUpInside];//设置按钮点击事件
        [leftBtn setImage:[UIImage imageNamed:@"back"]forState:UIControlStateNormal];
        [leftBtn setImage:[UIImage imageNamed:@"back"]forState:UIControlStateHighlighted];
        UIBarButtonItem *leftBarButon = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
        leftBarButon.imageInsets = UIEdgeInsetsMake(0, 100, 0, 0);
        
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceItem.width = -5;
        viewController.navigationItem.leftBarButtonItems = @[spaceItem,leftBarButon];
    }
    
    [super pushViewController:viewController animated:animated];
}

-(void)backPopViewController{
    // 返回上一个控制器
    [self popViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotate{
    return [[self.viewControllers lastObject] shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}

@end
