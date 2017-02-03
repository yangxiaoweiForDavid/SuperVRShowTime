//
//  RecommendViewController.m
//  SuperVRShowTime
//
//  Created by XiaoweiYang on 16/8/25.
//  Copyright © 2016年 XiaoweiYang. All rights reserved.
//

#import "RecommendViewController.h"
#import "SGFocusImageFrame(Banner)/SGFocusImageFrame.h"
#import "SGFocusImageFrame(Banner)/SGFocusImageItem.h"
#import "AcrossView.h"
#import "DbleRowContror.h"
#import "CommonClass.h"
#import "VideoInfoViewController.h"

@interface RecommendViewController ()<SGFocusImageFrameDelegate,DoAcrossViewDelegate>

@property (assign, nonatomic) int isFirst;
@property (weak, nonatomic) IBOutlet SGFocusImageFrame *bannerView;
@property (strong, nonatomic) NSMutableArray *bannerArray;
@property (weak, nonatomic) IBOutlet UIView *acrossView;
@property (strong, nonatomic) AcrossView *mycrossView;
@property (strong, nonatomic) NSMutableArray *crossDataArray;
@property (weak, nonatomic) IBOutlet UIView *dbleRowView;
@property (strong, nonatomic) DbleRowContror *myDbleRowContror;

@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"推荐";
    
    _isFirst = 0;
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [[ToolOprationer sharedInstance].rdvTabBarController setTabBarHidden:NO];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (_isFirst == 0) {
        _isFirst = 1;
        [self initUI];
    }
}

-(void)initData{
    _bannerArray = [[NSMutableArray alloc] init];
    _crossDataArray = [[NSMutableArray alloc] init];
    
    //TODO: 添加数据
    [_bannerArray removeAllObjects];
    [_bannerArray addObject:@{@"title":@"title1",@"imageUrl":@"",@"imageLocalName":@"b1.jpg",@"pushUrl":@"http://baidu.com"}];
    [_bannerArray addObject:@{@"title":@"title2",@"imageUrl":@"",@"imageLocalName":@"b2.jpg",@"pushUrl":@"http://baidu.com"}];
    [_bannerArray addObject:@{@"title":@"title3",@"imageUrl":@"",@"imageLocalName":@"b3.jpg",@"pushUrl":@"http://baidu.com"}];
    
    [_crossDataArray removeAllObjects];
    [_crossDataArray addObject:[AcrossData initWithDic:@{@"tittle":@"日漫",@"imageUrl":@"1_riman.png",@"type":[NSNumber numberWithInt:RequestVideoRiman]}]];
    [_crossDataArray addObject:[AcrossData initWithDic:@{@"tittle":@"国漫",@"imageUrl":@"2_guoman.png",@"type":[NSNumber numberWithInt:RequestVideoGuoman]}]];
    [_crossDataArray addObject:[AcrossData initWithDic:@{@"tittle":@"短片",@"imageUrl":@"3_duanpian.png",@"type":[NSNumber numberWithInt:RequestVideoDuanpian]}]];
    [_crossDataArray addObject:[AcrossData initWithDic:@{@"tittle":@"原创",@"imageUrl":@"4_yuanchuang.png",@"type":[NSNumber numberWithInt:RequestVideoYuanchuang]}]];
    [_crossDataArray addObject:[AcrossData initWithDic:@{@"tittle":@"其他",@"imageUrl":@"5_qita.png",@"type":[NSNumber numberWithInt:RequestVideoQita]}]];

}

-(void)initUI{
    //banner updata
    [self.bannerView initData_delegate:self placeHolderImage:[UIImage imageNamed:@"banner_default"]];
    [self.bannerView changeImageViewsContent:self.bannerArray];
    
    //acrossView updata
    if (!self.mycrossView) {
        CGRect rect = self.acrossView.frame;
        rect.origin.x = 0;
        rect.origin.y = 0;
        _mycrossView = [[AcrossView alloc] initWithFrame:rect];
        [_mycrossView reflashData:_crossDataArray delegate:self];
        [self.acrossView addSubview:self.mycrossView];
    }
    
    //dbleRowView updata
    if (!self.myDbleRowContror) {
        _myDbleRowContror = [[DbleRowContror alloc] initWithNibName:@"DbleRowContror" bundle:nil];
        [self.myDbleRowContror initConfig:RequestVideoRecommend];
        CGRect rect = self.dbleRowView.frame;
        rect.origin.x = 0;
        rect.origin.y = 0;
        self.myDbleRowContror.view.frame = rect;
        [self.dbleRowView addSubview:self.myDbleRowContror.view];
    }
}


#pragma mark - SGFocusImageFrameDelegate
- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame didSelectItem:(SGFocusImageItem *)item{
    VideoInfoViewController *infoContror = [[VideoInfoViewController alloc] initWithNibName:@"VideoInfoViewController" bundle:nil];
    [self.navigationController pushViewController:infoContror animated:YES];
}

- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame currentItem:(NSInteger)index{
}

#pragma mark - DoAcrossViewDelegate
-(void)doCliecAcrossBtn_tag:(int)tag{
    AcrossData *data = [_crossDataArray objectAtIndex:tag];
    DbleRowContror *dbleRowContror = [[DbleRowContror alloc] initWithNibName:@"DbleRowContror" bundle:nil];
    [dbleRowContror initConfig:data.type.intValue];
    [self.navigationController pushViewController:dbleRowContror animated:YES];
    //[[ToolOprationer sharedInstance].rdvTabBarController.navigationController pushViewController:dbleRowContror animated:YES];
}



@end


