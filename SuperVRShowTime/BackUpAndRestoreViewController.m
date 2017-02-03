//
//  BackUpAndRestoreViewController.m
//  BabyWatch
//
//  Created by SL02 on 10/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BackUpAndRestoreViewController.h"

#import "AppDelegate.h"
#import "MyHTTPConnection.h"
#import "localhostAddresses.h"
#import "Config.h"



@implementation BackUpAndRestoreViewController


@synthesize displayUrlLabel;
@synthesize http;
@synthesize showActivity;
@synthesize m_view;

@synthesize backUp1Lbel;
@synthesize tip1Lbel;
@synthesize tip2Lbel;
@synthesize tip3Lbel;
@synthesize tip4Lbel;


#pragma mark system method
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"wifi 导入";

    [self.showActivity startAnimating];
    [self.showActivity setHidden:NO];
    
    self.backUp1Lbel.text = @"Web 服务器地址";
    self.tip1Lbel.text = @"1. 打开计算机的网页浏览器。";
    self.tip2Lbel.text = @"2. 输入上面的服务器地址。";
    self.tip3Lbel.text = @"3. 按照说明上传你的视频到手机。";
    self.tip4Lbel.text = @"当正在上传视频数据时，请勿退出此屏幕或程序。";
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillDisappear:(BOOL)animated
{
	[http stop];
    http = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    http = nil;
	http=[[Http alloc] initWithServer];
	http.delegate=self;
}

#pragma mark custom method
-(void)setServerPort:(UInt16)port
{
	
}

-(void)uploadFinished
{
	
}

-(void)displayInfo:(NSString*)info
{
    [self.showActivity stopAnimating];
    [self.showActivity setHidden:YES];
    
	[displayUrlLabel setText:info];
}

-(void)stop
{
    [self.showActivity startAnimating];
    [self.showActivity setHidden:NO];
    
	[displayUrlLabel setText:@""];
}


@end


