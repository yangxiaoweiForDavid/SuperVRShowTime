//
//  DbleRowContror.m
//  SuperVRShowTime
//
//  Created by XiaoweiYang on 16/9/13.
//  Copyright © 2016年 XiaoweiYang. All rights reserved.
//

#import "DbleRowContror.h"
#import "DbleRowCell.h"

@interface DbleRowContror ()<UITableViewDataSource,UITableViewDelegate>

@property (assign, nonatomic) RequestVideoDataType requestType;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation DbleRowContror


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reflashData{
    [self.myTableView reloadData];
}

-(void)initConfig:(RequestVideoDataType)requestType{
    self.requestType = requestType;
    [self initData];
}

-(void)initData{
    [self.dataArray removeAllObjects];
    //TODO: 添加数据
    if (self.requestType == RequestVideoRecommend) {
        self.title = @"推荐";
    }else if (self.requestType == RequestVideoRiman) {
        self.title = @"日漫";
    }else if (self.requestType == RequestVideoGuoman) {
        self.title = @"国漫";
    }else if (self.requestType == RequestVideoDuanpian) {
        self.title = @"短片";
    }else if (self.requestType == RequestVideoYuanchuang) {
        self.title = @"原创";
    }else if (self.requestType == RequestVideoQita) {
        self.title = @"其他";
    }else {
        
    }
    [_dataArray removeAllObjects];
    
    NSString *videoLocalUrl = [[NSBundle mainBundle] pathForResource:@"IMG_3854" ofType:@"MOV"];
    NSString *videoLocalUrl2 = [[NSBundle mainBundle] pathForResource:@"congo.mp4" ofType:nil];
    NSString *videoOnlineUrl3 = @"http://cache.utovr.com/201508270528174780.m3u8";
    NSString *videoOnlineUrl4 = @"http://cache.utovr.com/201508270529022474.mp4";

    for (int i=0; i<4; i++) {
        [_dataArray addObject:[DbleRowData initWithDic:@{@"tittle":@"日漫-本地1",@"imageUrl":@"d1.jpg",@"videoUrl":videoLocalUrl,@"urlType":[NSNumber numberWithInteger:UVPlayerItemTypeLocalVideo]}]];
        [_dataArray addObject:[DbleRowData initWithDic:@{@"tittle":@"国漫-本地2",@"imageUrl":@"d2.jpg",@"videoUrl":videoLocalUrl2,@"urlType":[NSNumber numberWithInteger:UVPlayerItemTypeLocalVideo]}]];
        [_dataArray addObject:[DbleRowData initWithDic:@{@"tittle":@"短片-在线1",@"imageUrl":@"d3.jpg",@"videoUrl":videoOnlineUrl3,@"urlType":[NSNumber numberWithInteger:UVPlayerItemTypeOnline]}]];
        [_dataArray addObject:[DbleRowData initWithDic:@{@"tittle":@"原创-在线2",@"imageUrl":@"d4.jpg",@"videoUrl":videoOnlineUrl4,@"urlType":[NSNumber numberWithInteger:UVPlayerItemTypeOnline]}]];
        [_dataArray addObject:[DbleRowData initWithDic:@{@"tittle":@"其他-在线1",@"imageUrl":@"d5.jpg",@"videoUrl":videoOnlineUrl3,@"urlType":[NSNumber numberWithInteger:UVPlayerItemTypeOnline]}]];
        [_dataArray addObject:[DbleRowData initWithDic:@{@"tittle":@"日漫-在线2",@"imageUrl":@"d6.jpg",@"videoUrl":videoOnlineUrl4,@"urlType":[NSNumber numberWithInteger:UVPlayerItemTypeOnline]}]];
    }
}

#pragma mark-tableview代理方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *head = [[UIView alloc] init];
    [head setBackgroundColor:[UIColor whiteColor]];
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *head = [[UIView alloc] init];
    [head setBackgroundColor:[UIColor whiteColor]];
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 4;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return (self.dataArray.count+1)/2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* identifier = @"DbleRowCell";
    DbleRowCell *showItemCell = (DbleRowCell*)[[ToolOprationer sharedInstance] getTableViewCellForTableview:tableView className:identifier nibName:identifier identifier:identifier];
    NSInteger index = indexPath.row*2;
    DbleRowData *leftData = self.dataArray[index];
    DbleRowData *rightData = nil;
    if (self.dataArray.count > index+1) {
        rightData = self.dataArray[index+1];
    }
    [showItemCell initWithData_Left:leftData right:rightData];
    return  showItemCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

@end
