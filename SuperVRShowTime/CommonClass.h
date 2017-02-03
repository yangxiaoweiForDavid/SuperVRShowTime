//
//  CommonClass.h
//  XSpace
//
//  Created by XiaoweiYang on 15/4/5.
//  Copyright (c) 2015年 XiaoweiYang. All rights reserved.
//

#import <Foundation/Foundation.h>


//请求列表类型
typedef NS_ENUM(NSInteger, RequestVideoDataType) {
    RequestVideoRecommend = 0,
    RequestVideoRiman = 1,
    RequestVideoGuoman = 2,
    RequestVideoDuanpian = 3,
    RequestVideoYuanchuang = 4,
    RequestVideoQita = 5,
};

@interface DbleRowData : NSObject
@property(nonatomic,strong) NSString *imageUrl;
@property(nonatomic,strong) NSString *tittle;
@property(nonatomic,strong) NSString *videoUrl;
@property(nonatomic,strong) NSNumber *urlType;
+(DbleRowData *)initWithDic:(NSDictionary *)dic;
@end


@interface AcrossData : NSObject
@property(nonatomic,strong) NSString *imageUrl;
@property(nonatomic,strong) NSString *tittle;
@property(nonatomic,strong) NSNumber *type;
+(AcrossData *)initWithDic:(NSDictionary *)dic;
@end


@interface LocalVideoData : NSObject
@property(nonatomic,strong) NSString *url;
@property(nonatomic,strong) UIImage *image;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *time;
@property(nonatomic,strong) NSString *size;
@property(nonatomic,strong) NSString *type;
+(LocalVideoData *)initWithDic:(NSDictionary *)dic;
@end


@interface HelpData : NSObject
@property(nonatomic,strong) NSString *tittle;
@property(nonatomic,strong) NSString *body;
@property(nonatomic,assign) CGRect titleFrame;
@property(nonatomic,assign) CGRect imageFrame;
@property(nonatomic,assign) CGRect bodyFrame;
@property(nonatomic,assign) float high1;
@property(nonatomic,assign) float high2;
@property(nonatomic,assign) float stly;   //0:收  1:放
+(HelpData *)initWithTittle:(NSString *)tittle body:(NSString *)body;
-(float)getCellHigh;
-(void)doSetStly;
@end


