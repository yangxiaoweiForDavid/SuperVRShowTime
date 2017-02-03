//
//  VideoInfoViewController.m
//  SuperVRShowTime
//
//  Created by XiaoweiYang on 2016/11/8.
//  Copyright © 2016年 XiaoweiYang. All rights reserved.
//

#import "VideoInfoViewController.h"
#import "ReviewCell.h"

@interface VideoInfoViewController ()<UITableViewDataSource,UITableViewDelegate>{
}

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *myTableview;
@property (strong, nonatomic) IBOutlet UITableViewCell *headCell;
@property (weak, nonatomic) IBOutlet UIButton *headBtn;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UILabel *tittleLbel;
@property (weak, nonatomic) IBOutlet UILabel *tittleLbel2;
@property (weak, nonatomic) IBOutlet UILabel *countLbel;
@property (strong, nonatomic) IBOutlet UITableViewCell *introductCell;
@property (weak, nonatomic) IBOutlet UILabel *introductLbel;
@property (strong, nonatomic) IBOutlet UITableViewCell *scoreCell;
@property (weak, nonatomic) IBOutlet UILabel *scoreLbel;
@property (weak, nonatomic) IBOutlet UIButton *scoreBtn1;
@property (weak, nonatomic) IBOutlet UIButton *scoreBtn2;
@property (weak, nonatomic) IBOutlet UIButton *scoreBtn3;
@property (weak, nonatomic) IBOutlet UIButton *scoreBtn4;
@property (weak, nonatomic) IBOutlet UIButton *scoreBtn5;
@property (strong, nonatomic) IBOutlet UILabel *revHeadView;
@property (weak, nonatomic) IBOutlet UITextField *reviewField;

@end

@implementation VideoInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController setNavigationBarHidden:YES];

    self.navigationItem.title = @"";
    
    _dataArray = [[NSMutableArray alloc] init];
    
    [[ToolOprationer sharedInstance].rdvTabBarController setTabBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)scoreBtn:(UIButton *)sender {
    if (sender.tag >= 0) {
        [self.scoreBtn1 setImage:[UIImage imageNamed:@"hpxig"] forState:UIControlStateNormal];
    }else{
        [self.scoreBtn1 setImage:[UIImage imageNamed:@"pxig"] forState:UIControlStateNormal];
    }
    if (sender.tag >= 1) {
        [self.scoreBtn2 setImage:[UIImage imageNamed:@"hpxig"] forState:UIControlStateNormal];
    }else{
        [self.scoreBtn2 setImage:[UIImage imageNamed:@"pxig"] forState:UIControlStateNormal];
    }
    if (sender.tag >= 2) {
        [self.scoreBtn3 setImage:[UIImage imageNamed:@"hpxig"] forState:UIControlStateNormal];
    }else{
        [self.scoreBtn3 setImage:[UIImage imageNamed:@"pxig"] forState:UIControlStateNormal];
    }
    if (sender.tag >= 3) {
        [self.scoreBtn4 setImage:[UIImage imageNamed:@"hpxig"] forState:UIControlStateNormal];
    }else{
        [self.scoreBtn4 setImage:[UIImage imageNamed:@"pxig"] forState:UIControlStateNormal];
    }
    if (sender.tag >= 4) {
        [self.scoreBtn5 setImage:[UIImage imageNamed:@"hpxig"] forState:UIControlStateNormal];
    }else{
        [self.scoreBtn5 setImage:[UIImage imageNamed:@"pxig"] forState:UIControlStateNormal];
    }
}

#pragma mark-tableview代理方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        return self.revHeadView;
    }else{
        UIView *head = [[UIView alloc] init];
        if (section == 0) {
            [head setBackgroundColor:[UIColor blackColor]];
        }else{
            [head setBackgroundColor:[UIColor clearColor]];
        }
        return head;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }else if (section == 3){
        return self.revHeadView.frame.size.height;
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
    if (section == 2) {
        return 10;
    }else{
        return 0.1;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 3) {
        return 5;
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return self.headCell;
    }else if (indexPath.section == 1){
        return self.introductCell;
    }else if (indexPath.section == 2){
        return self.scoreCell;
    }else{
        NSString* identifier = @"ReviewCell";
        ReviewCell *dataCell = (ReviewCell*)[[ToolOprationer sharedInstance] getTableViewCellForTableview:tableView className:identifier nibName:identifier identifier:identifier];
        return  dataCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return self.headCell.frame.size.height;
    }else if (indexPath.section == 1){
        return self.introductCell.frame.size.height;
    }else if (indexPath.section == 2){
        return self.scoreCell.frame.size.height;
    }else{
        return  98;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
