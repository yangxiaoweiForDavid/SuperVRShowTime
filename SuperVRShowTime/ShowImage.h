//
//  ShowImage.h
//  XinBaDiary
//
//  Created by XiaoweiYang on 16/3/29.
//
//

#import <Foundation/Foundation.h>

@interface ShowImage : NSObject

+ (ShowImage *)sharedInstance;

-(void)showImage:(UIImage *)showImage;

@end
