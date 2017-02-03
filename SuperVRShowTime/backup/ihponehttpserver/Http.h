//
//  Http.h
//  NetServersTest
//
//  Created by BHI_H02 on 6/21/10.
//  Copyright 2010 BHI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPServer.h"
#import "MyHTTPConnection.h"
#import "ZipArchive.h"
#import "localhostAddresses.h"




@protocol HttpDelegate;



@interface Http : NSObject
{
	id<HttpDelegate>	delegate;
	
	HTTPServer *httpServer;
	NSDictionary *addresses;
	
	NSData*		  mailZipData;
}

@property (nonatomic, retain)	id<HttpDelegate>	delegate;


-(id)initWithServer;
-(void)stop;
-(void)createZipFile;


@end




@protocol HttpDelegate <NSObject>

-(void)stop;
-(void)displayInfo:(NSString*)info;
-(void)setServerPort:(UInt16)port;
-(void)uploadFinished;

@end
