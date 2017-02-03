//
//  Config.h
//  SuperVRShowTime
//
//  Created by XiaoweiYang on 16/8/28.
//  Copyright © 2016年 XiaoweiYang. All rights reserved.
//

#ifndef Config_h
#define Config_h


#define BackUpPort  52038


//屏幕宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height


#define APPIRATER_APP_NAME				\
[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]

#define APPIRATER_APP_BUNDLESTORT				\
[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define APPIRATER_APP_BUNDLE				\
[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]


//设备是否是iPhone4
#define DEVICE_IS_IPHONE4              (([[UIScreen mainScreen] bounds].size.height - 480) ? NO : YES)
#define DEVICE_IS_IPHONE5              (([[UIScreen mainScreen] bounds].size.height - 568) ? NO : YES)
#define DEVICE_IS_IPHONE6              (([[UIScreen mainScreen] bounds].size.height - 667) ? NO : YES)
#define DEVICE_IS_IPHONE6_PLUS         (([[UIScreen mainScreen] bounds].size.height - 736) ? NO : YES)
#define SYSTEM_VERSION                 [[[UIDevice currentDevice] systemVersion] floatValue]
#define Device_Width                   [UIScreen mainScreen].bounds.size.width
#define Device_Hight                   [UIScreen mainScreen].bounds.size.height

#define COLOR(R,G,B,A)                 [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]



//设置 多线程 断点下载  同时有多少个进行（ NSIntegerMax :无限制  其他 :限制最多个数 ）
#define SuperVR_DownloadCountMax        NSIntegerMax

// 下载比较路径
#define SuperVR_DownloadUrlComparePath   @"SuperVRShowDownload"

// 下载路径
#define SuperVR_DownloadUrlPath   [SuperVR_DocumentPath stringByAppendingPathComponent:SuperVR_DownloadUrlComparePath]

// Document路径
#define SuperVR_DocumentPath   \
[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

// Tmp路径
#define SuperVR_TmpPath  NSTemporaryDirectory()

// mainBundle bundlePath 路径
#define SuperVR_mainBundlePath     [[NSBundle mainBundle] bundlePath]

//本地临时播放文件名
#define LocalTmpVideoFileName           @"LocalTmpVideoFileName.MOV"

//本地视频来源类型
#define LocalSystemVideo             @"LocalSystemVideo"
#define LocalAppVideo                @"LocalAppVideo"

//wifi 视频导入通知
#define WifiInputNotifaction         @"WifiInputNotifaction"


//数据库名
//#define     ZiyaFile_db_Name                   @"ZiyaFileTable"
//#define     ZiyaNotice_db_Name                 @"ZiyaNoticeTable"


#endif

