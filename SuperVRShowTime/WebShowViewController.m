//
//  WebShowViewController.m
//  SuperVRShowTime
//
//  Created by XiaoweiYang on 2016/11/6.
//  Copyright © 2016年 XiaoweiYang. All rights reserved.
//

#import "WebShowViewController.h"

@interface WebShowViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *myWebView;

@end

@implementation WebShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = self.tittle;
    
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mart - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
}

-(void)fobidLongPressWebview:(UIWebView *)webView{
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
}


@end
