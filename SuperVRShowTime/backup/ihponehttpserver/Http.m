//
//  Http.m
//  NetServersTest
//
//  Created by BHI_H02 on 6/21/10.
//  Copyright 2010 BHI. All rights reserved.
//

#import "Http.h"
#import "AppDelegate.h"
#import "Config.h"

@interface Http(NSObject)

- (void)displayInfoUpdate:(NSNotification *) notification;
-(void)display:(NSString*)string;

@end


@implementation Http
@synthesize delegate;


-(id)initWithServer;
{
	NSString *root = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
	
    httpServer = [HTTPServer new];
	[httpServer setType:@"_http._tcp."];
	[httpServer setConnectionClass:[MyHTTPConnection class]];
	[httpServer setDocumentRoot:[NSURL fileURLWithPath:root]];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displayInfoUpdate:) name:@"LocalhostAdressesResolved" object:nil];
	[localhostAddresses performSelectorInBackground:@selector(list) withObject:nil];
	NSError *error;
	if(![httpServer start:&error])
	{
		NSLog(@"Error starting HTTP Server: %@", error);
	}
	
	[self displayInfoUpdate:nil];
	
	return self;
}
-(void)display:(NSString*)string
{
	[self.delegate displayInfo:string];
}
- (void)displayInfoUpdate:(NSNotification *) notification
{
	NSLog(@"displayInfoUpdate:");
	
	if(notification)
	{
		addresses = [[notification object] copy];
		NSLog(@"addresses: %@", addresses);
	}
	
	if(addresses == nil)
	{
		return;
	}
	
	NSString *info;
	//UInt16 port = [httpServer port];
	
	NSString *localIP = nil;
	
	localIP = [addresses objectForKey:@"en0"];
	
	if (!localIP)
	{
		localIP = [addresses objectForKey:@"en1"];
	}
	
	if (!localIP)
    {
        info = @"Wifi: 没有连接！";
    }
	else
    {
        info = [NSString stringWithFormat:@"http://%@:%d\n", localIP, BackUpPort];
    }
		
	[self display:info];
}
-(void)stop
{
    [self.delegate stop];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LocalhostAdressesResolved" object:nil];
	[httpServer stop];
}
-(void)createZipFile
{
    
}


@end
