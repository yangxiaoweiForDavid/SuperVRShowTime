//
//  WrongMsgViewController.m
//  ksudi
//
//  Created by MacroHong on 15/5/26.
//  Copyright (c) 2015年 com.oeffect. All rights reserved.
//

#import "WrongMsgViewController.h"

@interface WrongMsgViewController ()

@end

@implementation WrongMsgViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(void)showCodeMsg:(NSString *)codeStr {
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:
                         @"网络错误", NetError,
                         nil];
    
    NSString *msg;
    if (codeStr) {
        msg = [dic objectForKey:codeStr];
    }
    if (!msg) {
        msg = @"未知错误";
    }
    UIAlertView *show = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [show show];

}

+(void)showMsg:(NSString *)Str{
    if (!Str) {
        Str = @"未知错误";
    }
    UIAlertView *show = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:Str delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [show show];
}

+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

}



@end
