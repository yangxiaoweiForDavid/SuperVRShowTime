//
//  UtoVRController.m
//  SuperVRShowTime
//
//  Created by XiaoweiYang on 16/9/20.
//  Copyright © 2016年 XiaoweiYang. All rights reserved.
//

#import "UtoVRController.h"
#import "AppDelegate.h"

#import <UtoVRPlayer/UtoVRPlayer.h>

@interface UtoVRController ()<UVPlayerDelegate>
@property (nonatomic,strong)UVPlayer *player;
@property (nonatomic,strong) NSMutableArray *itemsToPlay;
@end

@implementation UtoVRController

#pragma mark - Getters
-(UVPlayer *)player {
    if (!_player) {
        _player = [[UVPlayer alloc] initWithConfiguration:nil];
        _player.delegate = self;
    }
    return _player;
}

-(instancetype)init{
    if (self =[super init]) {
        _itemsToPlay = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.view.frame = window.frame;
    
    self.player.viewStyle = UVPlayerViewStyleDefault;
    self.player.playerView.frame = self.view.frame;
    [self.player appendItems:self.itemsToPlay];
    if (self.player.viewStyle == UVPlayerViewStyleDefault) {
        [self.player setPortraitBackButtonTarget:self selector:@selector(back:)];
    }
    [self.view addSubview:self.player.playerView];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
  /*
    NSLog(@"%d",(int)self.player.playerView.subviews.count);
    int i = 0;
    for (UIView *v in self.player.playerView.subviews) {
        if (i == 3) {
            [v setHidden:YES];
        }
        i++;
        
//        [v setHidden:NO];
        
        NSLog(@"-----%@------",v);


    }
   */
   
}

//-(void)statusBarOrientationChange:(NSNotification *)notification{
//    int isHorizontal = NO;
//    UIDeviceOrientation orient = [UIDevice currentDevice].orientation;
//    switch (orient){
//        case UIDeviceOrientationPortrait:
//            NSLog(@"---1------UIInterfaceOrientationPortrait-----------");
//            break;
//        case UIDeviceOrientationLandscapeLeft:
//            isHorizontal = YES;
//            NSLog(@"---1------UIInterfaceOrientationLandscapeLeft-----------");
//            break;
//        case UIDeviceOrientationPortraitUpsideDown:
//            NSLog(@"---1------UIInterfaceOrientationPortraitUpsideDown-----------");
//            break;
//        case UIDeviceOrientationLandscapeRight:
//            isHorizontal = YES;
//            NSLog(@"---1------UIInterfaceOrientationLandscapeRight-----------");
//            break;
//        default:
//            NSLog(@"---1------UIDeviceOrientationUnknown-----------");
//            break;
//    }
//    
//    self.player.playerView.frame = self.view.frame;
//    
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    NSLog(@"---0---%f------%f----",window.frame.size.width,window.frame.size.height);
//    NSLog(@"---1---%f------%f----",self.view.frame.size.width,self.view.frame.size.height);
//}

//-(void)viewWillLayoutSubviews{
//    [super viewWillLayoutSubviews];
//}

- (BOOL)shouldAutorotate{
    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    self.player.playerView.frame = CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width);
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    self.player.playerView.frame = self.view.frame;
    [self.player.playerView setNeedsLayout];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initWithDataShow:(NSArray *)itemArray{
    [self.itemsToPlay removeAllObjects];
    [self.itemsToPlay addObjectsFromArray:itemArray];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.view];
    self.view.alpha = 0;
    [UIView animateWithDuration:0.8 animations:^{
        [[AppDelegate getMainAppDelegate].window setRootViewController:self];
        [[AppDelegate getMainAppDelegate].window makeKeyAndVisible];
        
        self.view.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - Helper
-(void)back:(UIButton*)sender {
    [self.player pause];
    [self.player clearItems];
    [self.player prepareToRelease];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        [[AppDelegate getMainAppDelegate].window setRootViewController:[ToolOprationer sharedInstance].rdvTabBarController];
        [[AppDelegate getMainAppDelegate].window makeKeyAndVisible];
        
        self.player = nil;
        [self.view removeFromSuperview];
        [[NSNotificationCenter defaultCenter] postNotificationName:ReleaseVRSourceNotifaction object:nil];
    }];
}

#pragma mark - PanoPlayerDelegate
-(void)player:(UVPlayer *)player willBeginPlayItem:(UVPlayerItem *)item {
    if (player.viewStyle == UVPlayerViewStyleDefault) {
        [player setTitleText:item.path];
    }
}

-(void)playerFinished:(UVPlayer *)player{
    NSLog(@"---------finish---------");
}

-(void)playerSingleClicked:(UVPlayer*)player{
}

-(void)player:(UVPlayer*)player playingTimeDidChanged:(Float64)newTime{
    NSLog(@"-----change-----%f-----",newTime);
}

-(void)player:(UVPlayer*)player didGetDuration:(Float64)duration{
    NSLog(@"-----all-----%f-----",duration);
}


@end
