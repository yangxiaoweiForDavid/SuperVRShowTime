//
//  ShowVRController.m
//  SuperVRShowTime
//
//  Created by yangxiaowei on 16/8/22.
//  Copyright © 2016年 XiaoweiYang. All rights reserved.
//

#import "ShowVRController.h"
#import "VideoPlayView.h"
#import "FullViewController.h"

@interface ShowVRController ()<VideoPlayViewDelegate>
@property (nonatomic,strong) VideoPlayView *playView;
@property (nonatomic,strong) FullViewController *fullVc;
@end

@implementation ShowVRController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    
    //传入视频地址
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"congo.mp4" ofType:nil];
    
    self.fullVc = [[FullViewController alloc] init];

    // 创建playView，设置其代理
    self.playView  = [VideoPlayView videoPlayView];
    self.playView.delegate = self;
    self.playView.path = self.path;
//    self.playView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width*9/16);
    self.playView.frame = self.view.frame;
    [self.view addSubview:self.playView];
}

#pragma mark - playView代理，实现全屏
-(void)videoplayViewSwitchOrientation:(BOOL)isFull
{
//    if (isFull) {
//        [self presentViewController:self.fullVc animated:YES completion:^{
//            self.playView.frame = self.fullVc.view.bounds;
//            [self.playView removeFromSuperview];
//            [self.fullVc.view addSubview:self.playView];
//        }];
//    } else {
//        [self.fullVc dismissViewControllerAnimated:YES completion:^{
//            [self.playView removeFromSuperview];
//            [self.view addSubview:self.playView];
//            self.playView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width*9/16);
//        }];
//    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight;
}



@end


