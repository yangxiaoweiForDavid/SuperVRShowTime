//
//  MyUserDefaultConfig.h
//  XinBaDiary
//
//  Created by XiaoweiYang on 16/3/17.
//
//

#import <Foundation/Foundation.h>


@interface MyUserDefaultConfig : NSObject

//用户名密码
@property (nonatomic, strong)NSString *userName;
@property (nonatomic, strong)NSString *password;

+ (instancetype) sharedInstance;

@end
