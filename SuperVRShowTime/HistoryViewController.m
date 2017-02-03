//
//  HistoryViewController.m
//  SuperVRShowTime
//
//  Created by XiaoweiYang on 2016/11/6.
//  Copyright © 2016年 XiaoweiYang. All rights reserved.
//

#import "HistoryViewController.h"
#import "LocalVideoCell.h"


@interface HistoryViewController ()<UITableViewDataSource,UITableViewDelegate>{
}

@property (weak, nonatomic) IBOutlet UITableView *myTableview;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.title = @"播放记录";
    
    _dataArray = [[NSMutableArray alloc] init];
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData{
    [self.dataArray removeAllObjects];
    for (int i= 0; i<4; i++) {
        LocalVideoData *data = [LocalVideoData initWithDic:@{@"url":@"",@"image":[UIImage imageNamed:[NSString stringWithFormat:@"d%d.jpg",i+1]],@"tittle":[NSString stringWithFormat:@"影片%d",i+1],@"time":@"08:23",@"size":@"22.3M",@"type":LocalSystemVideo}];
        [self.dataArray addObject:data];
    }
    [self.myTableview reloadData];
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
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* identifier = @"LocalVideoCell";
    LocalVideoCell *dataCell = (LocalVideoCell*)[[ToolOprationer sharedInstance] getTableViewCellForTableview:tableView className:identifier nibName:identifier identifier:identifier];
    LocalVideoData *data = self.dataArray[indexPath.row];
    [dataCell initDataWith:data];
    return  dataCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
