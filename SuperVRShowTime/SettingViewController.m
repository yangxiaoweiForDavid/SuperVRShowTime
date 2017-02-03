//
//  SettingViewController.m
//  SuperVRShowTime
//
//  Created by XiaoweiYang on 2016/11/6.
//  Copyright © 2016年 XiaoweiYang. All rights reserved.
//

#import "SettingViewController.h"
#import "InfoViewController.h"

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>{
}

@property (weak, nonatomic) IBOutlet UITableView *myTableview;
@property (strong, nonatomic) IBOutlet UITableViewCell *userCell;
@property (strong, nonatomic) IBOutlet UIView *footView;
@property (strong, nonatomic) IBOutlet UITableViewCell *wifiCell;
@property (weak, nonatomic) IBOutlet UISwitch *wifiSwich;
@property (strong, nonatomic) IBOutlet UITableViewCell *stlyCell;
@property (weak, nonatomic) IBOutlet UISwitch *stlySwich;
@property (strong, nonatomic) IBOutlet UITableViewCell *cacheCell;
@property (weak, nonatomic) IBOutlet UILabel *cacheLbel;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.title = @"设置";
    
    self.userCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.cacheCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)wifiSwich:(id)sender {
}

- (IBAction)stlySwich:(id)sender {
}

- (IBAction)logout:(id)sender {
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
    if (section == 0) {
        UIView *head = [[UIView alloc] init];
        [head setBackgroundColor:[UIColor clearColor]];
        return head;
    }else{
        return self.footView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }else{
        return self.footView.frame.size.height;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return self.userCell;
        }else if (indexPath.row == 1){
            return self.wifiCell;
        }else{
            return self.stlyCell;
        }
    }else{
        return self.cacheCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            InfoViewController *infoContor = [[InfoViewController alloc] initWithNibName:@"InfoViewController" bundle:nil];
            [self.navigationController pushViewController:infoContor animated:YES];
        }else if (indexPath.row == 1){
            
        }else{
            
        }
    }else{
        self.cacheLbel.text = @"0M";
    }
}


@end
