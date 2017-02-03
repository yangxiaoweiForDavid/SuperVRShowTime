

#import "FileManagerUtils.h"
#import "NSString+Categories.h"
#import "Config.h"
#import <CommonCrypto/CommonDigest.h>


@implementation FileManagerUtils


+ (FileManagerUtils *)shared {
    static FileManagerUtils *singleton = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        singleton = [[FileManagerUtils alloc] init];
    });
    return singleton;
}


+ (NSString *)DocumentPath_path:(NSString *)pathFile{
    return [SuperVR_DocumentPath stringByAppendingPathComponent:pathFile];
}

+ (BOOL)fileIsExit:(NSString *)fileName{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:fileName]){
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)creatFilePath:(NSString *)filePath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
}

+ (BOOL)deleteFolderAndSubFile:(NSString *)directoryName {
    return [[NSFileManager defaultManager] removeItemAtPath:directoryName error:nil];
}


+ (BOOL)moveFolderSubFile:(NSString *)directoryName toFolderPath:(NSString *)toPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:toPath withIntermediateDirectories:YES attributes:nil error:nil];
    if ([fileManager fileExistsAtPath:toPath]){
        [fileManager removeItemAtPath:toPath error:nil];
    }
    NSError *error = nil;
    BOOL flag = [fileManager moveItemAtPath:directoryName toPath:toPath error:&error];
    if(error){
        NSLog(@"%@",error.userInfo);
    }
    return flag;
}


+ (BOOL)copyFolderSubFile:(NSString *)directoryName toFolderPath:(NSString *)toPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:toPath]){
        [fileManager removeItemAtPath:toPath error:nil];
    }
    NSError *error = nil;
    BOOL flag = [fileManager copyItemAtPath:directoryName toPath:toPath error:&error];
    if(error){
        NSLog(@"%@",error.userInfo);
    }
    return flag;
}


+ (NSString *)getFilePathFromDocument:(NSString *)fileNname directoryName:(NSString *)directoryName {
    return [[SuperVR_DocumentPath stringByAppendingPathComponent:directoryName] stringByAppendingPathComponent:fileNname];
}


+ (void)renameFileByDirectoryName:(NSString *)directoryName oldFileName:(NSString *)oldFileName newFileName:(NSString *)newFileName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *oldFilePath = [self getFilePathFromDocument:oldFileName directoryName:directoryName];
    NSString *newFilePath = [self getFilePathFromDocument:newFileName directoryName:directoryName];
    if ([newFileName isEqualToString:oldFileName]) {
        return;
    }
    NSError *error = [[NSError alloc] init];
    if (![fileManager moveItemAtPath:oldFilePath toPath:newFilePath error:&error]) {
        NSLog(@"Unable to move file: %@", [error localizedDescription]);
    }
}


+ (BOOL)deleteFile:(NSString *)fileName directoryName:(NSString *)directoryName {
    NSString *filePath = [directoryName stringByAppendingPathComponent:fileName];
    return [self deleteFolderAndSubFile:filePath];
}


+ (NSString *)renameFileByMD5WithDirectoryName:(NSString *)directoryName filePath:(NSString *)filePath {
    NSString *fileMd5String = [self file_md5:filePath];
    NSString *fileName = [[filePath componentsSeparatedByString:@"/"] lastObject];
    [FileManagerUtils renameFileByDirectoryName:directoryName oldFileName:fileName newFileName:fileMd5String];
    return fileMd5String;
}

#define CHUNK_SIZE 1024

+ (NSString *)file_md5:(NSString *)path {
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
    if (handle == nil) {
        return nil;
    }
    
    CC_MD5_CTX md5_ctx;
    CC_MD5_Init(&md5_ctx);
    NSData *filedata;
    
    do {
        filedata = [handle readDataOfLength:CHUNK_SIZE];
        CC_MD5_Update(&md5_ctx, [filedata bytes], (CC_LONG)[filedata length]);
    } while ([filedata length]);
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(result, &md5_ctx);
    [handle closeFile];
    
    NSMutableString *hash = [NSMutableString string];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    
    return [hash lowercaseString];
}


+ (BOOL)checkFileMd5WithFilePath:(NSString *)filePath {
    NSString *fileName = [[filePath componentsSeparatedByString:@"/"] lastObject];
    NSString *fileMd5String = [self file_md5:filePath];
    if (![NSString checkStringEmpty:filePath] && ![NSString checkStringEmpty:fileMd5String]) {
        if ([fileName isEqualToString:fileMd5String]) {
            return YES;
        }
    }
    return NO;
}


+ (NSString *)getFilePathFromBundle:(NSString *)fileName {
    NSArray *array = [fileName componentsSeparatedByString:@"."];
    NSString *name = array[0];
    NSString *sufix = array[1];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:sufix];
    return filePath;
}


+ (void)cleanCaches:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]){
        NSArray *childrenFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childrenFiles){
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
}

//计算单个文件大小
+ (float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}

//计算目录大小
+ (float)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize +=[self fileSizeAtPath:absolutePath];
        }
        return folderSize;
    }
    return 0;
}

@end


