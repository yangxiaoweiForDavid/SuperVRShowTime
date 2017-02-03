//
//  This class was created by Nonnus,
//  who graciously decided to share it with the CocoaHTTPServer community.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HTTPConnection.h"

@interface MyHTTPConnection : HTTPConnection<UIAlertViewDelegate>
{
	UInt64 dataStartIndex;
	NSMutableArray* multipartData;
	BOOL postHeaderOK;
	NSString*	dpath;
	BOOL isNext;
	BOOL isRestore;
}
@property (nonatomic) BOOL isRestore;
@property (nonatomic) BOOL isNext;
-(void)createZipFile:(NSString*)path;
- (BOOL)isBrowseable:(NSString *)path;
- (NSString *)createBrowseableIndex:(NSString *)path;
- (BOOL)supportsPOST:(NSString *)path withSize:(UInt64)contentLength;
-(BOOL)hasZipFile:(NSString*)path;
-(void)writeSqliteFile;
-(void)deleteCutemFile;
-(BOOL)sureFileRight;
@end

