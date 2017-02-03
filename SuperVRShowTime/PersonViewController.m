//
//  PersonViewController.m
//  SuperVRShowTime
//
//  Created by XiaoweiYang on 16/8/25.
//  Copyright © 2016年 XiaoweiYang. All rights reserved.
//

#import "PersonViewController.h"
#import "FXBlurView.h"
#import "InfoViewController.h"
#import "LoginViewController.h"
#import "HistoryViewController.h"
#import "FeedBackViewController.h"
#import "AboutUsViewController.h"
#import "SettingViewController.h"
#import "HelpViewController.h"

@interface PersonViewController ()<UITableViewDataSource,UITableViewDelegate>{
    BOOL haveLogin;
}

@property (weak, nonatomic) IBOutlet FXBlurView *backBlurView;
@property (weak, nonatomic) IBOutlet UIImageView *bigBackImge;
@property (weak, nonatomic) IBOutlet UIImageView *smallBackImge;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginPersonBtn;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UITableViewCell *myHistoryCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *helpCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *feedbackCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *aboutCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *settingCell;

@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"个人";
    
    haveLogin = NO;
    self.backBlurView.blurRadius = 10;
    [self.backBlurView setDynamic:NO];
    self.myHistoryCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.helpCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.feedbackCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.aboutCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.settingCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData{
    if (haveLogin) {
        
    }else{
        
    }
}

- (IBAction)editPersonBtn:(id)sender {
    InfoViewController *infoContor = [[InfoViewController alloc] initWithNibName:@"InfoViewController" bundle:nil];
    [self.navigationController pushViewController:infoContor animated:YES];
}

- (IBAction)loginPersonBtn:(id)sender {
//    [self.backBlurView setDynamic:YES];
//    if (!haveLogin) {
//        haveLogin = YES;
//        [self.backBlurView setHidden:NO];
//        self.bigBackImge.image = [UIImage imageNamed:@"touxiang_default"];
//        self.smallBackImge.image = [UIImage imageNamed:@"touxiang_default"];
//    }else{
//        haveLogin = NO;
//        [self.backBlurView setHidden:YES];
//        self.bigBackImge.image = [UIImage imageNamed:@"touxiang_test.jpg"];
//        self.smallBackImge.image = [UIImage imageNamed:@"touxiang_test.jpg"];
//    }
//    [self.backBlurView setDynamic:NO];
    
    LoginViewController *loginContor = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:loginContor animated:YES];
}

#pragma mark-tableview代理方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *head = [[UIView alloc] init];
    [head setBackgroundColor:[UIColor clearColor]];
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }else{
        return 10;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *head = [[UIView alloc] init];
    [head setBackgroundColor:[UIColor clearColor]];
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return self.myHistoryCell;
        }else if (indexPath.row == 1){
            return self.helpCell;
        }else if (indexPath.row == 2){
            return self.feedbackCell;
        }else{
            return self.aboutCell;
        }
    }else{
        return  self.settingCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            HistoryViewController *historyContor = [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil];
            [self.navigationController pushViewController:historyContor animated:YES];
        }else if (indexPath.row == 1){
            HelpViewController *helpContor = [[HelpViewController alloc] initWithNibName:@"HelpViewController" bundle:nil];
            [self.navigationController pushViewController:helpContor animated:YES];
        }else if (indexPath.row == 2){
            FeedBackViewController *feedContor = [[FeedBackViewController alloc] initWithNibName:@"FeedBackViewController" bundle:nil];
            [self.navigationController pushViewController:feedContor animated:YES];
        }else{
            AboutUsViewController *aboutContor = [[AboutUsViewController alloc] initWithNibName:@"AboutUsViewController" bundle:nil];
            [self.navigationController pushViewController:aboutContor animated:YES];
        }
    }else{
        SettingViewController *settinContor = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
        [self.navigationController pushViewController:settinContor animated:YES];
    }
}


@end

