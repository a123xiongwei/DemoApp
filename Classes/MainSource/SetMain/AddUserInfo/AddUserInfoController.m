//
//  AddUserInfoController.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/11.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "AddUserInfoController.h"
#import "CameraSelectView.h"
#import "UIImage+Scale.h"
#import "AddUserInfoModel.h"
#import "CommUtils.h"
#import "MJBirthDateView.h"
#import <YYKit/UIImageView+YYWebImage.h>
#import "NSBundleUtils.h"

@interface AddUserInfoController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UIButton *subBtn;
@property (nonatomic, strong) IBOutlet UIImageView *avatarImg;
@property (nonatomic, strong) IBOutlet UIButton *avatarBtn;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIButton *sexmBtn;
@property (nonatomic, strong) IBOutlet UIButton *sexwBtn;
@property (nonatomic, strong) IBOutlet UIButton *birBtn;
@property (nonatomic, strong) IBOutlet UIButton *relBtn;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *relHeightValue;
@property (nonatomic, strong) IBOutlet UIView *relView;
@property (nonatomic, strong) IBOutlet UIView *headView;
@property (nonatomic, strong) IBOutlet UILabel *relLa;
@property (nonatomic, strong) IBOutlet UILabel *birLa;
@property (nonatomic, strong) IBOutlet UILabel *stageLa;
@property (nonatomic, strong) IBOutlet UITextField *nameTf;
@property (nonatomic, strong) IBOutlet UITextField *heightTf;
@property (nonatomic, strong) UIImage *uploadImg;

@property (nonatomic, strong) AddUserInfoModel *addModel;
@property (nonatomic, strong) RelationItem *relationItem;

@end

@implementation AddUserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mjTitle = @"编辑信息";
//    self.tableView.bounces = NO;
    
    self.addModel = [[AddUserInfoModel alloc] init];
    
    self.subBtn.isRaidus = YES;
    self.avatarImg.isRaidus = YES;
    
    //提交用户信息
    [[self.subBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        BOOL isSuccess = [self checkValidRelationUserParams];
        if(isSuccess){
            
            [self initUploadRelationAvatarData:self.uploadImg];
        }
        
    }];
    
    //男性按钮事件
    [[self.sexmBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [self.sexmBtn setImage:[UIImage imageNamed:@"a_sex_m"] forState:UIControlStateNormal];
        [self.sexwBtn setImage:[UIImage imageNamed:@"a_sex_n"] forState:UIControlStateNormal];
        self.userItem.relativesSex = @"1";
        
    }];
    
    //女性按钮事件
    [[self.sexwBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [self.sexmBtn setImage:[UIImage imageNamed:@"a_sex_n"] forState:UIControlStateNormal];
        [self.sexwBtn setImage:[UIImage imageNamed:@"a_sex_w"] forState:UIControlStateNormal];
        self.userItem.relativesSex = @"0";
        
    }];
    
    //生日选择
    [[self.birBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        MJBirthDateView *dateView = (MJBirthDateView *)[NSBundleUtils buildView:[MJBirthDateView class] owner:self];
        
        [[dateView.subBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            NSDate *selDate = dateView.datePicker.date;
            NSString *birTime = [CommUtils convertTimeYMD:selDate];
            self.birLa.text = birTime;
            
            NSString *stageDes = [BlueDataUtils findUserStageDes:selDate];
            self.stageLa.text = stageDes;
            self.userItem.relativesBirthday = [CommUtils convertTimeSpaceYMD:selDate];
            
        }];
        
        [UIKeyWindow addSubview:dateView];
        
    }];
    
    //关系选择
    [[self.relBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        self.relBtn.selected = !self.relBtn.selected;
        
        if(self.relBtn.isSelected){
            
            [self initAddRelationViewData];
            
        }else{
            
            [self clearAllRelationView];
        }
        
    }];
    
    
    //用户头像的选择
    [[self.avatarBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        CameraSelectView *alertView = (CameraSelectView *)[NSBundleUtils buildView:[CameraSelectView class] owner:self];
        
        [[alertView.itemfBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            [alertView dissAlertSelectView:^{
                UIImagePickerController *camera = [[UIImagePickerController alloc] init];
                camera.sourceType = UIImagePickerControllerSourceTypeCamera;
                camera.allowsEditing = YES;
                camera.delegate = self;
                [self presentViewController:camera animated:YES completion:^{}];
            }];
            
        }];
        [[alertView.itemsBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            [alertView dissAlertSelectView:^{
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                picker.allowsEditing = YES;
                picker.delegate = self;
                
                [self presentViewController:picker animated:YES completion:^{}];
            }];
            
        }];
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        [keyWindow addSubview:alertView];
        
    }];
    
    
    if(self.userItem){
        [self configViewData];
    }else{
        self.userItem = [[RelationUserItem alloc] init];
        self.userItem.relativesSex = @"1";
        
        if(self.isThis){
            
            self.relLa.text = @"本人";
            self.userItem.relativesWith = @"20";
            self.userItem.relativesWithName = @"自己";
            self.relBtn.userInteractionEnabled = NO;
            
        }
    }

    [self initFetchRelationListData];
    
}

/**
 * 添加亲友成员
 */
-(void)initAddRelationUserInfoData{
    
    [self showHUDView];
    [[self.addModel addRelationUserInfo:self.userItem] subscribeError:^(NSError *error) {
        [self HUDHidden];
    } completed:^{
        [self HUDHidden];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

/**
 * 获取关系列表
 */
-(void)initFetchRelationListData{
    
    [[self.addModel fetchRelationList] subscribeError:^(NSError *error) {
        
    } completed:^{
        
    }];
    
}

/**
  * 头像的上传
 */
-(void)initUploadRelationAvatarData:(UIImage *) image{
    
    if(image){
        [self showHUDView];
        [[self.addModel uploadRelationAvatar:image] subscribeError:^(NSError *error) {
            [self HUDHidden];
        } completed:^{
            [self HUDHidden];
            self.userItem.relativesPicUrl = self.addModel.avatarUrl;
            
            [self initAddRelationUserInfoData];
        }];
    }else{
        [self initAddRelationUserInfoData];
    }
    
}

/**
 * 初始化成员信息
 */
-(void)configViewData{
    
    self.nameTf.text = self.userItem.relativesNickName;
    NSString *sexValue = self.userItem.relativesSex;
    if([sexValue isEqualToString:@"1"]){
        
        UIImage *mImg = [NSBundleUtils buildImage:[self class] imageName:@"a_sex_m"];
        UIImage *nImg = [NSBundleUtils buildImage:[self class] imageName:@"a_sex_n"];
        [self.sexmBtn setImage:mImg forState:UIControlStateNormal];
        [self.sexwBtn setImage:nImg forState:UIControlStateNormal];
    }else{
        UIImage *mImg = [NSBundleUtils buildImage:[self class] imageName:@"a_sex_n"];
        UIImage *nImg = [NSBundleUtils buildImage:[self class] imageName:@"a_sex_m"];
        [self.sexmBtn setImage:mImg forState:UIControlStateNormal];
        [self.sexwBtn setImage:nImg forState:UIControlStateNormal];
    }
    
    NSDate *birDate = [CommUtils convertTimeDate:self.userItem.relativesBirthday];
    self.birLa.text = [CommUtils convertTimeYMD:birDate];
    
    self.heightTf.text = self.userItem.relativesHeight;
    self.relLa.text = self.userItem.relativesWithName;
    
    
    NSString *stageDes = [BlueDataUtils findUserStageDes:birDate];
    self.stageLa.text = stageDes;
    
    self.userItem.relativesBirthday = [CommUtils convertTimeSpaceYMD:birDate];
    
    [self.avatarImg setImageWithURL:[NSURL URLWithString:self.userItem.relativesPicUrl] placeholder:[UIImage imageNamed:@"user_default"]];
    
}

/**
 * 清楚所有关系视图
 */
-(void)clearAllRelationView{
    
    for (UIView *subView in self.relView.subviews) {
        [subView removeFromSuperview];
    }
    
    self.relHeightValue.constant = 65;
    self.headView.height = 767;
    self.tableView.tableHeaderView = self.headView;
    
}

/**
 * 添加关系列表视图
 */
-(void)initAddRelationViewData{
    
    [self clearAllRelationView];
    
    for (int i = 0; i < self.addModel.relationList.count; i++) {
        RelationItem *subItem = self.addModel.relationList[i];
        
        UIView *devView = [[UIView alloc] init];
        devView.width =  SCREEN_WIDTH - 24;
        devView.height = 40;
        devView.y = i * devView.height;
        
        UIButton *relBtn = [[UIButton alloc] init];
        relBtn.width = devView.width;
        relBtn.height = devView.height;
        [devView addSubview:relBtn];
        
        [[relBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            self.relBtn.selected = NO;
            if(self.relationItem){
                self.relationItem.isSelect = @"0";
            }
            self.relationItem = subItem;
            self.relationItem.isSelect = @"1";
            [self clearAllRelationView];
            self.relLa.text = subItem.label;
            self.userItem.relativesWith = subItem.value;
            self.userItem.relativesWithName = subItem.label;
        }];
        
        UILabel *nameLa = [[UILabel alloc] init];
        nameLa.width = 200;
        nameLa.height = devView.height;
        nameLa.text = subItem.label;
        nameLa.textColor = [CommUtils colorWithHexString:@"999999"];
        nameLa.font = [UIFont systemFontOfSize:14];
        [devView addSubview:nameLa];
        
        UIImageView *arrowImg = [[UIImageView alloc] init];
        arrowImg.contentMode = UIViewContentModeCenter;
        arrowImg.width = 20;
        arrowImg.height = 20;
        arrowImg.y = 10;
        arrowImg.x = devView.width - arrowImg.width - 10;
        if([subItem.isSelect isEqualToString:@"1"]){
            arrowImg.image = [UIImage imageNamed:@"h_select_y"];
        }else{
            arrowImg.image = [UIImage imageNamed:@"h_select_n"];
        }
        
        [devView addSubview:arrowImg];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.width = devView.width;
        lineView.height = 1;
        lineView.y = devView.height - 1;
        lineView.alpha = 0.1;
        lineView.backgroundColor = UIColor.grayColor;
        
        if(i != self.addModel.relationList.count-1){
            [devView addSubview:lineView];
        }
        
        [self.relView addSubview:devView];
        
    }
    
    self.relHeightValue.constant = 65 + self.addModel.relationList.count*40;
    self.headView.height = 767 + self.addModel.relationList.count*40;
    
    self.tableView.tableHeaderView = self.headView;
    
}

/**
 * 检查参数验证的方法
 */
-(BOOL)checkValidRelationUserParams{
    
    BOOL isSuccess = YES;
    
    NSString *message = @"";
    NSString *nickName = self.nameTf.text;
    NSString *height = self.heightTf.text;
    
    if([nickName isEqualToString:@""]){
        message = @"请输入用户昵称";
        isSuccess = NO;
    }else if(!self.userItem.relativesBirthday){
        message = @"请选择出生年月";
        isSuccess = NO;
    }else if([height isEqualToString:@""]){
        message = @"请输入身高";
        isSuccess = NO;
    }else if(!self.userItem.relativesWith){
        message = @"请选择与本人的关系";
        isSuccess = NO;
    }
    
    if(!isSuccess){
        [self showMessage:message];
    }else{
        self.userItem.relativesNickName = nickName;
        self.userItem.relativesHeight = height;
    }
    
    return isSuccess;
}

#pragma mark UIImagePickerControllerDelegate
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    image = [image scaledCopyOfSizeMin:CGSizeMake(500, 500)];
//    [self initUploadRelationAvatarData:image];
    self.uploadImg = image;
    self.avatarImg.image = image;
    [picker dismissViewControllerAnimated:YES completion:^{
       //上传头像
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
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
