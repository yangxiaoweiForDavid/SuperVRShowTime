//
//  SGFocusImageItem.h
//  ScrollViewLoop
//
//  Created by Vincent Tang on 13-7-18.
//  Copyright (c) 2013年 Vincent Tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGFocusImageItem : NSObject

@property (nonatomic, copy)  NSString     *title;
@property (nonatomic, copy)  NSString     *imageUrl;
@property (nonatomic, copy)  NSString     *imageLocalName;
@property (nonatomic, copy)  NSString     *pushUrl;

@property (nonatomic, assign) NSInteger   tag;



- (id)initWithTitle:(NSString *)title imageUrl:(NSString *)imageUrl imageLocalName:(NSString *)imageLocalName tag:(NSInteger)tag pushUrl:(NSString *)pushUrl;
- (id)initWithDict:(NSDictionary *)dict tag:(NSInteger)tag;

@end

