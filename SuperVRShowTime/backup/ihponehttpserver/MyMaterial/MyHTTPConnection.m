//
//  This class was created by Nonnus,
//  who graciously decided to share it with the CocoaHTTPServer community.
//

#import "MyHTTPConnection.h"
#import "HTTPServer.h"
#import "HTTPResponse.h"
#import "AsyncSocket.h"
#import "ZipArchive.h"
#import <sqlite3.h>

#import "AppDelegate.h"
#import "Config.h"


@implementation MyHTTPConnection
@synthesize isNext;
@synthesize isRestore;
/**
 * Returns whether or not the requested resource is browseable.
**/
- (BOOL)isBrowseable:(NSString *)path
{
	// Override me to provide custom configuration...
	// You can configure it for the entire server, or based on the current request
	
	return YES;
}


/**
 * This method creates a html browseable page.
 * Customize to fit your needs
**/
-(void)createZipFile:(NSString*)path
{
    return;
	//创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError * error=nil;
	NSArray *array = [fileManager contentsOfDirectoryAtPath:path error:&error];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];//去处需要的路径
	//更改到待操作的目录下
	[fileManager changeCurrentDirectoryPath:[documentsDirectory stringByExpandingTildeInPath]];
	
	//获取文件路径
	NSString *path2 = [documentsDirectory stringByAppendingPathComponent:@"/XSpaceBak.zip"];
	
	ZipArchive* zipFile = [[ZipArchive alloc] init];
	BOOL ret=[zipFile CreateZipFile2:path2];
	while(!ret)
	{
		[fileManager createFileAtPath:path2 contents:nil attributes:nil];
		ret=[zipFile CreateZipFile2:path2];
	}
	
    for (NSString *fname in array)
    {
		if(![fname isEqualToString:@"XSpaceBak.zip"])
		{
			NSString* a=[path stringByAppendingString:[NSString stringWithFormat:@"/%@", fname]];
			ret =[zipFile addFileToZip:a newname:fname];
		}
	}
    
	if(ret)
	{
		[zipFile CloseZipFile2];
	}

    
	//把图标写进去
	NSArray *documentPaths =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *dds = [documentPaths objectAtIndex:0];
    
    NSString *pathimageBackup = [dds stringByAppendingPathComponent:@"/btn_backup.png"];
	UIImage* imageBackup=[UIImage imageNamed:@"btn_backup.png"];
	NSData *dataBackup = UIImagePNGRepresentation(imageBackup);
	[dataBackup writeToFile:pathimageBackup atomically:YES];
    
	NSString *pathrestore = [dds stringByAppendingPathComponent:@"/btn_restore.png"];	
	UIImage* imagerestore=[UIImage imageNamed:@"btn_restore.png"];
	NSData *datarestore = UIImagePNGRepresentation(imagerestore);
	[datarestore writeToFile:pathrestore atomically:YES];
	
	NSString *pathIconBackupimage = [dds stringByAppendingPathComponent:@"/backup.png"];	
	UIImage* imageIconBackup=[UIImage imageNamed:@"backup.png"];
	NSData *dataIconBackup = UIImagePNGRepresentation(imageIconBackup);
	[dataIconBackup writeToFile:pathIconBackupimage atomically:YES];
	
	NSString *pathIconRestoreimage = [dds stringByAppendingPathComponent:@"/restore.png"];	
	UIImage* imageRestore=[UIImage imageNamed:@"restore.png"];
	NSData *dataRestore = UIImagePNGRepresentation(imageRestore);
	[dataRestore writeToFile:pathIconRestoreimage atomically:YES];
	
	NSString *pathbg = [dds stringByAppendingPathComponent:@"/bg.png"];	
	UIImage* imagebg=[UIImage imageNamed:@"bg.png"];
	NSData *databg = UIImagePNGRepresentation(imagebg);
	[databg writeToFile:pathbg atomically:YES];
    
}

-(BOOL)hasZipFile:(NSString*)path
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString* a=[[path stringByAppendingString:@"/"] stringByAppendingString:@"XSpaceBak.zip"];
	BOOL relust=[fileManager fileExistsAtPath:a];
	return relust;
}
- (NSString *)createBrowseableIndex:(NSString *)path
{
	NSError * error = nil;
    
	static BOOL isFrist=YES;
	if(!isRestore)
	{
		dpath=path;
		if([self hasZipFile:path])
		{
			NSFileManager *fileManager = [NSFileManager defaultManager];
			NSString* a=[[path stringByAppendingString:@"/"] stringByAppendingString:@"XSpaceBak.zip"];
			[fileManager removeItemAtPath:a error:&error];
		}
		[self createZipFile:path];
		isFrist=NO;
	}
    
	NSMutableString *outdata = [NSMutableString new];
	if ([self supportsPOST:path withSize:0])
    {
		NSString *path3 = [[NSBundle mainBundle] pathForResource:@"SuperVRShowTime" ofType:@"html"];
		NSString * str = [NSString stringWithContentsOfFile:path3 encoding: NSUTF8StringEncoding error: &error];
        [outdata appendString:str];
	}
	
    return outdata;
}

- (BOOL)supportsMethod:(NSString *)method atPath:(NSString *)relativePath
{
	if ([@"POST" isEqualToString:method])
	{
		return YES;
	}
	
	return [super supportsMethod:method atPath:relativePath];
}


/**
 * Returns whether or not the server will accept POSTs.
 * That is, whether the server will accept uploaded data for the given URI.
**/
- (BOOL)supportsPOST:(NSString *)path withSize:(UInt64)contentLength
{
	dataStartIndex = 0;
	multipartData = [[NSMutableArray alloc] init];
	postHeaderOK = FALSE;
	return YES;
}


/**
 * This method is called to get a response for a request.
 * You may return any object that adopts the HTTPResponse protocol.
 * The HTTPServer comes with two such classes: HTTPFileResponse and HTTPDataResponse.
 * HTTPFileResponse is a wrapper for an NSFileHandle object, and is the preferred way to send a file response.
 * HTTPDataResopnse is a wrapper for an NSData object, and may be used to send a custom response.
**/
- (NSObject<HTTPResponse> *)httpResponseForMethod:(NSString *)method URI:(NSString *)path
{
	if (requestContentLength > 0)  // Process POST data
	{
		if ([multipartData count] < 2) return nil;
		
		NSString* postInfo = [[NSString alloc] initWithBytes:[[multipartData objectAtIndex:1] bytes]
													  length:[[multipartData objectAtIndex:1] length]
													encoding:NSUTF8StringEncoding];
		
		NSArray* postInfoComponents = [postInfo componentsSeparatedByString:@"; filename="];
		postInfoComponents = [[postInfoComponents lastObject] componentsSeparatedByString:@"\""];
		postInfoComponents = [[postInfoComponents objectAtIndex:1] componentsSeparatedByString:@"\\"];
		NSString* filename = [postInfoComponents lastObject];
		
		if (![filename isEqualToString:@""]) //this makes sure we did not submitted upload form without selecting file
		{
			UInt16 separatorBytes = 0x0A0D;
			NSMutableData* separatorData = [NSMutableData dataWithBytes:&separatorBytes length:2];
			[separatorData appendData:[multipartData objectAtIndex:0]];
			int l = (int)[separatorData length];
			int count = 2;	//number of times the separator shows up at the end of file data
			
			NSFileHandle* dataToTrim = [multipartData lastObject];
			NSLog(@"data: %@", dataToTrim);
			
			for (unsigned long long i = [dataToTrim offsetInFile] - l; i > 0; i--)
			{
				[dataToTrim seekToFileOffset:i];
				if ([[dataToTrim readDataOfLength:l] isEqualToData:separatorData])
				{
					[dataToTrim truncateFileAtOffset:i];
					i -= l;
					if (--count == 0) break;
				}
			}
			
			NSLog(@"NewFileUploaded");
			[[NSNotificationCenter defaultCenter] postNotificationName:@"NewFileUploaded" object:nil];
		}
		
		for (int n = 1; n < [multipartData count] - 1; n++)
			NSLog(@"%@", [[NSString alloc] initWithBytes:[[multipartData objectAtIndex:n] bytes] length:[[multipartData objectAtIndex:n] length] encoding:NSUTF8StringEncoding]);
		
		requestContentLength = 0;
	}
	
	NSString *filePath = [self filePathForURI:path];
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
	{
		return [[HTTPFileResponse alloc] initWithFilePath:filePath];
	}
	else
	{
		NSString *folder = [[server documentRoot] path];//[path isEqualToString:@"/"] ? [[server documentRoot] path] : [NSString stringWithFormat: @"%@%@", [[server documentRoot] path], path];
		
		if ([self isBrowseable:folder])
		{
			NSData *browseData = [[self createBrowseableIndex:folder] dataUsingEncoding:NSUTF8StringEncoding];
			return [[HTTPDataResponse alloc] initWithData:browseData];
		}
	}
	
	return nil;
}


/**
 * This method is called to handle data read from a POST.
 * The given data is part of the POST body.
**/
- (void)processDataChunk:(NSData *)postDataChunk
{
	self.isRestore = TRUE;
	multipartData = [[NSMutableArray alloc] init];
	[multipartData removeAllObjects];
	if (!postHeaderOK)
	{
		UInt16 separatorBytes = 0x0A0D;
		NSData* separatorData = [NSData dataWithBytes:&separatorBytes length:2];
		
		int l = (int)[separatorData length];
		for (int i = 0; i < [postDataChunk length] - l; i++)
		{
			NSRange searchRange = {i, l};
			
			if ([[postDataChunk subdataWithRange:searchRange] isEqualToData:separatorData])
			{
                NSInteger startIndex = (NSInteger)dataStartIndex;
				NSRange newDataRange = {startIndex, i - startIndex};
				dataStartIndex = i + l;
				i += l - 1;
				NSData *newData = [postDataChunk subdataWithRange:newDataRange];
				
				if ([newData length])
				{
					[multipartData addObject:newData];
				}
				else
				{
					postHeaderOK = TRUE;
                    
//					NSError * errors;
//					NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//					NSString *documentsDirectory = [paths objectAtIndex:0];//去处需要的路径
//					NSString *path = [paths objectAtIndex:0];
//					NSError * error=nil;
//					NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error];
//					NSFileManager *fileManager = [NSFileManager defaultManager];
//					for (NSString *fname in array)
//					{
//						if([fname length]>4)
//						{
//							if([[fname substringFromIndex:[fname length]-4] isEqualToString:@".zip"])
//							{
//								[fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:fname] error:&errors];
//							}
//						}
//					}
                    
                    
					NSString* postInfo = [[NSString alloc] initWithBytes:[[multipartData objectAtIndex:1] bytes] length:[[multipartData objectAtIndex:1] length] encoding:NSUTF8StringEncoding];
					NSArray* postInfoComponents = [postInfo componentsSeparatedByString:@"; filename="];
					
					postInfoComponents = [[postInfoComponents lastObject] componentsSeparatedByString:@"\""];
					postInfoComponents = [[postInfoComponents objectAtIndex:1] componentsSeparatedByString:@"\\"];
					
					NSString* filename = [[[server documentRoot] path] stringByAppendingPathComponent:[postInfoComponents lastObject]];
                    
					//获取文件路径
//					[postInfo stringByReplacingOccurrencesOfString:filename withString:@"Update.zip"];
					
                    NSInteger startIndex = (NSInteger)dataStartIndex;
					NSRange fileDataRange = {startIndex, [postDataChunk length] - startIndex};
					[[NSFileManager defaultManager] createFileAtPath:filename contents:[postDataChunk subdataWithRange:fileDataRange] attributes:nil];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:WifiInputNotifaction object:nil];
                    [[ToolOprationer sharedInstance] showTip2:[NSString stringWithFormat:@"%@ 添加成功",[postInfoComponents lastObject]] timeConut:3];
                    
					NSFileHandle *file = [NSFileHandle fileHandleForUpdatingAtPath:filename];
					if (file)
					{
						[file seekToEndOfFile];
						[multipartData addObject:file];
					}
//					[self writeSqliteFile];
					[self sureFileRight];
                    
					break;
				}
			}
		}
	}
	else
	{
		[(NSFileHandle*)[multipartData lastObject] writeData:postDataChunk];
	}
	
}
-(void)writeSqliteFile
{
	UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"确定恢复"
													 message:@"你想要用上传的备份恢复 Secret Space 吗？需要注意的是，所有当前的数据将会被擦除和替换，并且此无法撤销。"
													delegate:self
										   cancelButtonTitle:@"取消"
										   otherButtonTitles:@"备份 & 恢复",nil];
	alert.tag = 0;
	[alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(alertView.tag == 0)
	{
		if(buttonIndex == 0)
        {
            return;
        }
		else
		{
            BOOL isPopError = NO;
            
            //获取文件路径
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];//去处需要的路径
            NSString *zipDic1 = @"XSpaceBak.zip";
            NSString *zipDic = [documentsDirectory stringByAppendingPathComponent:zipDic1];
            
            //删除原有文件
            NSArray *array = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:nil];
            for (NSString *fname in array)
            {
                if(![fname isEqualToString:zipDic1])
                {
                    [fileManager removeItemAtPath:fname error:nil];
                }
            }
            
            //解压文件
            ZipArchive* zipFile = [[ZipArchive alloc] init];
            [zipFile UnzipOpenFile:zipDic];
            BOOL ret=[zipFile UnzipFileTo:documentsDirectory overWrite:YES];
            [zipFile UnzipCloseFile];
            
            //删除压缩包
            [fileManager removeItemAtPath:zipDic error:nil];
            [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:@"btn_backup.png"] error:nil];
            [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:@"btn_restore.png"] error:nil];
            [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:@"backup.png"] error:nil];
            [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:@"restore.png"] error:nil];
            [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:@"bg.png"] error:nil];
            
            
            
            if(ret)
            {
                UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"恢复成功"
                                                                  message:@"请重启 Secret Space 以使改变生效。"
                                                                 delegate:self
                                                        cancelButtonTitle:@"好"
                                                        otherButtonTitles:nil];
                alertView.tag = 1;
                [alertView show];

                NSUserDefaults *defaults2 = [NSUserDefaults standardUserDefaults];
                [defaults2 setInteger:1 forKey:@"IsRestore"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            else
            {
                isPopError = YES;
            }
            
            if (isPopError == YES)
            {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"恢复已经取消"
                                                                 message:@"当前的数据库和备份包应该使用相同的文件名，为了确保安全，恢复过程已经被取消。"
                                                                delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil,nil];
                [alert show];
            }
		}
	}
	else if(alertView.tag == 1)
	{
		exit(1);
	}
}
-(BOOL)sureFileRight
{
	BOOL relust=NO;
    
//	return YES;
    
    
    
	NSString*	fileName;
	
	NSString*	filepath = [[NSBundle mainBundle] pathForResource:@"Version" ofType:@"plist"];
	NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:filepath];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *path = [paths objectAtIndex:0];
	NSError * errors = nil;
	NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&errors];
    for (NSString *fname in array)
    {
		fileName=fname;
		for(id version in dictionary)
		{
			NSString* v=(NSString*)version;
			NSString*	value=[dictionary valueForKey:v];
			if([fileName compare:value]==NSOrderedSame)
			{
				relust=YES;
			}
		}
	}
	return relust;
}
-(void)deleteCutemFile
{
	NSArray *paths= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	//创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString* path=[paths objectAtIndex:0];
	NSError * errors = nil;
	NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&errors];
	
	NSString *documentsDirectory = [paths objectAtIndex:0];//去处需要的路径
	//更改到待操作的目录下
	[fileManager changeCurrentDirectoryPath:[documentsDirectory stringByExpandingTildeInPath]];
	
	//获取文件路径
	
	for (NSString *fname in array)
    {
		if([fname compare:@"Update.zip"]==NSOrderedSame)
		{
			[fileManager removeItemAtPath:fname error:nil];
		}
	}
}

@end
