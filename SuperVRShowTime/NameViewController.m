//
//  NameViewController.m
//  SuperVRShowTime
//
//  Created by XiaoweiYang on 2016/11/6.
//  Copyright © 2016年 XiaoweiYang. All rights reserved.
//

#import "NameViewController.h"

@interface NameViewController ()<UITableViewDataSource,UITableViewDelegate>{
}

@property (weak, nonatomic) IBOutlet UITableView *myTableview;
@property (strong, nonatomic) IBOutlet UITableViewCell *nameCell;
@property (weak, nonatomic) IBOutlet UITextField *nameField;

@end

@implementation NameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"修改昵称";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(save)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.nameField resignFirstResponder];
}

-(void)save{
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.nameCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
