//
//  AboutUsViewController.m
//  SuperVRShowTime
//
//  Created by XiaoweiYang on 2016/11/6.
//  Copyright © 2016年 XiaoweiYang. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.title = @"关于我们";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
