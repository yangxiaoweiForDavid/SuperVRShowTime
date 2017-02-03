//
//  CommonClass.m
//  XSpace
//
//  Created by XiaoweiYang on 15/4/5.
//  Copyright (c) 2015年 XiaoweiYang. All rights reserved.
//

#import "CommonClass.h"


@implementation DbleRowData
@synthesize imageUrl;
@synthesize tittle;
@synthesize videoUrl;
@synthesize urlType;
-(id)init{
    self = [super init];
    if (self){
    }
    return self;
}
+(DbleRowData *)initWithDic:(NSDictionary *)dic{
    DbleRowData *data = [[DbleRowData alloc] init];
    data.imageUrl = dic[@"imageUrl"];
    data.tittle = dic[@"tittle"];
    data.videoUrl = dic[@"videoUrl"];
    data.urlType = dic[@"urlType"];
    return data;
}
@end


@implementation AcrossData
@synthesize imageUrl;
@synthesize tittle;
@synthesize type;
-(id)init{
    self = [super init];
    if (self){
    }
    return self;
}
+(AcrossData *)initWithDic:(NSDictionary *)dic{
    AcrossData *data = [[AcrossData alloc] init];
    data.imageUrl = dic[@"imageUrl"];
    data.tittle = dic[@"tittle"];
    data.type = dic[@"type"];
    return data;
}
@end



@implementation LocalVideoData
@synthesize url;
@synthesize image;
@synthesize name;
@synthesize time;
@synthesize size;
@synthesize type;
-(id)init{
    self = [super init];
    if (self){
    }
    return self;
}
+(LocalVideoData *)initWithDic:(NSDictionary *)dic{
    LocalVideoData *data = [[LocalVideoData alloc] init];
    data.url = dic[@"url"];
    data.image = dic[@"image"];
    data.name = dic[@"tittle"];
    data.time = dic[@"time"];
    data.size = dic[@"size"];
    data.type = dic[@"type"];
    return data;
}
@end


@implementation HelpData
@synthesize tittle;
@synthesize body;
@synthesize titleFrame;
@synthesize imageFrame;
@synthesize bodyFrame;
@synthesize high1;
@synthesize high2;
@synthesize stly;
-(id)init{
    self = [super init];
    if (self){
        titleFrame = CGRectZero;
        imageFrame = CGRectZero;
        bodyFrame = CGRectZero;
        high1 = 0;
        high2 = 0;
        stly = 0;
    }
    return self;
}
+(HelpData *)initWithTittle:(NSString *)tittle body:(NSString *)body{
    HelpData *data = [[HelpData alloc] init];
    data.tittle = tittle;
    data.body = body;
    
    float start_Y1 = 13;
    float min_H = 24;
    float start_X1 = 15;
    float start_X2 = 43;
    float end_X1 = 7;
    float unit_X1 = 4;
    float end_X2 = 15;
    float addHigh = 5;
    float addHigh2 = 15;
    float imageWidt = 24;
    float width1 = ScreenWidth-start_X1-imageWidt-end_X1-unit_X1;
    float high1 = [[ToolOprationer sharedInstance] m_getHigh_str:tittle m_font:[UIFont systemFontOfSize:14] widt:width1];
    high1 = high1>min_H?high1+addHigh:min_H;
    CGRect titleFrame1;
    titleFrame1.origin.x = start_X1;
    titleFrame1.origin.y = start_Y1;
    titleFrame1.size.width = width1;
    titleFrame1.size.height = high1;
    data.titleFrame = titleFrame1;
    CGRect imageFrame1;
    imageFrame1.origin.y = start_Y1;
    imageFrame1.origin.x = ScreenWidth-end_X1-imageWidt;
    imageFrame1.size.width = imageWidt;
    imageFrame1.size.height = imageWidt;
    data.imageFrame = imageFrame1;
    float width2 = ScreenWidth - start_X2 - end_X2;
    float high2 = [[ToolOprationer sharedInstance] m_getHigh_str:body m_font:[UIFont systemFontOfSize:12] widt:width2];
    high2 = high2>min_H?high2+addHigh2:min_H;
    CGRect bodyFrame1;
    bodyFrame1.origin.x = start_X2;
    bodyFrame1.origin.y = 2*start_Y1 + high1 - 5;
    bodyFrame1.size.height = high2;
    bodyFrame1.size.width = width2;
    data.bodyFrame = bodyFrame1;
    data.high1 = 2*start_Y1+high1;
    data.high2 = bodyFrame1.origin.y + bodyFrame1.size.height;

    return data;
}
-(float)getCellHigh{
    if (!self.stly) {
        return high1;
    }else{
        return high2;
    }
}
-(void)doSetStly{
    self.stly = self.stly?0:1;
}
@end



