//
//  HelpViewController.m
//  SuperVRShowTime
//
//  Created by XiaoweiYang on 2016/11/6.
//  Copyright © 2016年 XiaoweiYang. All rights reserved.
//

#import "HelpViewController.h"
#import "HelpCell.h"

@interface HelpViewController ()<UITableViewDataSource,UITableViewDelegate>{
}

@property (weak, nonatomic) IBOutlet UITableView *myTableview;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.title = @"帮助";
    
    _dataArray = [[NSMutableArray alloc] init];
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData{
    [self.dataArray removeAllObjects];
    HelpData *data1 = [HelpData initWithTittle:@"网速为什么这么慢" body:@"与独享宽带不同，4G网速是共享使用的，用的人多的时候，网速自然会变慢。这也解释了为何拥挤的上班路上，通常网速较慢，而到了夜深人静时，网络环境立刻变得不错。"];
    [self.dataArray addObject:data1];
    HelpData *data2 = [HelpData initWithTittle:@"为什么手机这么热" body:@"一般情况下，手机发热有这三方面的原因，一是因为太阳直射，二是手机电路板或者是电池出现毛病，三则是手机使用时间太长或者运行的软件太多。要知道，电脑用的时间长了都会发热，并且还有专门的散热风扇，而我们的智能大屏手机需要运行那么多软件，CPU还集中在那么小的一个地方，会发热也就不足为奇了。"];
    [self.dataArray addObject:data2];
    HelpData *data3 = [HelpData initWithTittle:@"为什么画面有颗粒感" body:@"为获得更大的视角，呈现更强烈的沉浸感，三代硬件为实现了手机屏幕的高倍放大。"];
    [self.dataArray addObject:data3];
    HelpData *data4 = [HelpData initWithTittle:@"手机看视频为什么有眩晕感，我们要如果做才可以减轻那种眩晕感，这个东西一般看多久休息一会，会比较好，长时间看会感觉眼睛很干燥，不舒服，而且有种恶心想吐，是不是要休息一会才行" body:@"在虚拟世界中，你看到了一只猴子。但是猴子身上的毛却显示得极为模糊，猴子的脸上，甚至还有马赛克！当猴子从你的视野中快速地、拖着残影爬到身旁的一颗树上时，你抬头看向树上的猴子，过了大概20ms，画面才跟着你的头转了过去……"];
    [self.dataArray addObject:data4];
    HelpData *data5 = [HelpData initWithTittle:@"VR虚拟现实，成为未来几年的当朝宠儿。VR虚拟现实技术的发展也在不断进步，不过VR智能眼镜的发展还是有很多因素需要解决。例如眩晕感，很多体验过VR的人都会有一种感觉，就是在体验过程中都会有一些眩晕感，这会让用户出现恶心、头晕等不适症状" body:@"这样的情况同样适用于VR游戏。"];
    [self.dataArray addObject:data5];
    HelpData *data6 = [HelpData initWithTittle:@"我们的内耳能检测多种速度的变化和加速度" body:@"虚拟过山车并不是最好的演示内容。"];
    [self.dataArray addObject:data6];
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
    NSString* identifier = @"HelpCell";
    HelpCell *dataCell = (HelpCell*)[[ToolOprationer sharedInstance] getTableViewCellForTableview:tableView className:identifier nibName:identifier identifier:identifier];
    HelpData *data = self.dataArray[indexPath.row];
    [dataCell initDataWith:data];
    return  dataCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HelpData *data = self.dataArray[indexPath.row];
    return [data getCellHigh];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HelpData *data = self.dataArray[indexPath.row];
    [data doSetStly];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

@end
