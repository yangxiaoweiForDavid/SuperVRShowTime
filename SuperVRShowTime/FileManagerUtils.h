

#import <Foundation/Foundation.h>

@interface FileManagerUtils : NSObject



+ (FileManagerUtils *)shared;

+ (NSString *)DocumentPath_path:(NSString *)pathFile;
+ (BOOL)fileIsExit:(NSString *)fileName;
+ (BOOL)creatFilePath:(NSString *)filePath;
+ (BOOL)deleteFolderAndSubFile:(NSString *)directoryName;
+ (BOOL)moveFolderSubFile:(NSString *)directoryName toFolderPath:(NSString *)toPath;
+ (BOOL)copyFolderSubFile:(NSString *)directoryName toFolderPath:(NSString *)toPath;
+ (NSString *)getFilePathFromDocument:(NSString *)fileNname directoryName:(NSString *)directoryName;
+ (void)renameFileByDirectoryName:(NSString *)directoryName oldFileName:(NSString *)oldFileName newFileName:(NSString *)newFileName;
+ (BOOL)deleteFile:(NSString *)fileName directoryName:(NSString *)directoryName;
+ (NSString *)renameFileByMD5WithDirectoryName:(NSString *)directoryName filePath:(NSString *)filePath;
+ (NSString *)file_md5:(NSString *)path;
+ (BOOL)checkFileMd5WithFilePath:(NSString *)filePath;
+ (NSString *)getFilePathFromBundle:(NSString *)fileName;
+ (void)cleanCaches:(NSString *)path;
+ (float)fileSizeAtPath:(NSString *)path;
+ (float)folderSizeAtPath:(NSString *)path;

@end

