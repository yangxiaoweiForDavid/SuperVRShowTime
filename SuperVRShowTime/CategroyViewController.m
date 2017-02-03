//
//  CategroyViewController.m
//  SuperVRShowTime
//
//  Created by XiaoweiYang on 16/8/25.
//  Copyright © 2016年 XiaoweiYang. All rights reserved.
//

#import "CategroyViewController.h"
#import "SCNavTabBarController.h"
#import "DbleRowContror.h"

@interface CategroyViewController ()
@property (strong, nonatomic) SCNavTabBarController *tabBar;

@end

@implementation CategroyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"动漫分类";
    
    DbleRowContror *rimanDbleRowContror = [[DbleRowContror alloc] initWithNibName:@"DbleRowContror" bundle:nil];
    [rimanDbleRowContror initConfig:RequestVideoRiman];
    DbleRowContror *guomanDbleRowContror = [[DbleRowContror alloc] initWithNibName:@"DbleRowContror" bundle:nil];
    [guomanDbleRowContror initConfig:RequestVideoGuoman];
    DbleRowContror *duanpianDbleRowContror = [[DbleRowContror alloc] initWithNibName:@"DbleRowContror" bundle:nil];
    [duanpianDbleRowContror initConfig:RequestVideoDuanpian];
    DbleRowContror *yuanchuangDbleRowContror = [[DbleRowContror alloc] initWithNibName:@"DbleRowContror" bundle:nil];
    [yuanchuangDbleRowContror initConfig:RequestVideoYuanchuang];
    DbleRowContror *qitaDbleRowContror = [[DbleRowContror alloc] initWithNibName:@"DbleRowContror" bundle:nil];
    [qitaDbleRowContror initConfig:RequestVideoQita];
    
    _tabBar = [[SCNavTabBarController alloc] initWithSubViewControllers:@[rimanDbleRowContror,guomanDbleRowContror,duanpianDbleRowContror,yuanchuangDbleRowContror,qitaDbleRowContror] andParentViewController:self showArrowButton:NO];
    [_tabBar setScrollAnimation:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
