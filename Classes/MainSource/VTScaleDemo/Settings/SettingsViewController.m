//
//  SettingsViewController.m
//  VTScaleDemo
//
//  Created by mac on 2019/4/4.
//  Copyright © 2019 mac. All rights reserved.
//

#import "SettingsViewController.h"
#import "Settings.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UITextField *heightTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderSegmentedControl;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"设置";
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.genderSegmentedControl.enabled = NO;
    self.ageTextField.enabled = NO;
    self.heightTextField.enabled = NO;
    
    Settings *settings = [Settings sharedSettings];
    
    self.genderSegmentedControl.selectedSegmentIndex = settings.gender;
    self.ageTextField.text = @(settings.age).stringValue;
    self.heightTextField.text = @(settings.height).stringValue;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:tap];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    if (!editing)
    {
        [self.view endEditing:YES];
        self.genderSegmentedControl.enabled = NO;
        self.ageTextField.enabled = NO;
        self.heightTextField.enabled = NO;
        
        Settings *settings = [Settings sharedSettings];
        settings.gender = self.genderSegmentedControl.selectedSegmentIndex;
        settings.age = self.ageTextField.text.integerValue;
        settings.height = self.heightTextField.text.integerValue;
    }
    else
    {
        self.genderSegmentedControl.enabled = YES;
        self.ageTextField.enabled = YES;
        self.heightTextField.enabled = YES;
    }
}

- (void)viewTapped:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
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
