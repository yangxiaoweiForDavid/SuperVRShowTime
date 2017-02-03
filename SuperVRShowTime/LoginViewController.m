//
//  LoginViewController.m
//  SuperVRShowTime
//
//  Created by XiaoweiYang on 2016/11/6.
//  Copyright © 2016年 XiaoweiYang. All rights reserved.
//

#import "LoginViewController.h"
#import "ResetPasswordViewController.h"

@interface LoginViewController ()<UITableViewDataSource,UITableViewDelegate>{
}

@property (weak, nonatomic) IBOutlet UITableView *myTableview;
@property (strong, nonatomic) IBOutlet UITableViewCell *userCell;
@property (weak, nonatomic) IBOutlet UITextField *userField;
@property (strong, nonatomic) IBOutlet UITableViewCell *passCell;
@property (weak, nonatomic) IBOutlet UITextField *passField;
@property (strong, nonatomic) IBOutlet UIView *footView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.title = @"登录";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(regist)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.userField resignFirstResponder];
    [self.passField resignFirstResponder];
}

-(void)regist{
    ResetPasswordViewController *resetPassContor = [[ResetPasswordViewController alloc] initWithNibName:@"ResetPasswordViewController" bundle:nil];
    resetPassContor.stly = 1;
    [self.navigationController pushViewController:resetPassContor animated:YES];
}

- (IBAction)passwordShowStly:(id)sender {
    if ([self.passField.text isEqualToString:@""]) {
        return;
    }
    if (self.passField.secureTextEntry) {
        [self.passField setSecureTextEntry:NO];
    }else{
        [self.passField setSecureTextEntry:YES];
    }
}

- (IBAction)forgetPassword:(id)sender {
    ResetPasswordViewController *resetPassContor = [[ResetPasswordViewController alloc] initWithNibName:@"ResetPasswordViewController" bundle:nil];
    resetPassContor.stly = 0;
    [self.navigationController pushViewController:resetPassContor animated:YES];
}

- (IBAction)login:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-tableview代理方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *head = [[UIView alloc] init];
    [head setBackgroundColor:[UIColor clearColor]];
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return self.footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return self.footView.frame.size.height;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return self.userCell;
    }else{
        return self.passCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
