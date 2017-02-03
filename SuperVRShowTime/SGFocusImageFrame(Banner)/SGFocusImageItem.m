//
//  SGFocusImageItem.m
//  ScrollViewLoop
//
//  Created by Vincent Tang on 13-7-18.
//  Copyright (c) 2013年 Vincent Tang. All rights reserved.
//

#import "SGFocusImageItem.h"

@implementation SGFocusImageItem
@synthesize title = _title;
@synthesize imageUrl = _imageUrl;
@synthesize imageLocalName = _imageLocalName;
@synthesize tag = _tag;
@synthesize pushUrl = _pushUrl;

- (id)initWithTitle:(NSString *)title imageUrl:(NSString *)imageUrl imageLocalName:(NSString *)imageLocalName tag:(NSInteger)tag pushUrl:(NSString *)pushUrl{
    self = [super init];
    if (self) {
        self.title = title;
        self.imageUrl = imageUrl;
        self.imageLocalName = imageLocalName;
        self.tag = tag;
        self.pushUrl = pushUrl;
    }
    
    return self;
}

- (id)initWithDict:(NSDictionary *)dict tag:(NSInteger)tag
{
   return [self initWithTitle:[dict objectForKey:@"title"] imageUrl:[dict objectForKey:@"imageUrl"] imageLocalName:[dict objectForKey:@"imageLocalName"] tag:tag pushUrl:[dict objectForKey:@"pushUrl"]];
}


@end


