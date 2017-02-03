//
//  MyUserDefaultConfig.m
//  XinBaDiary
//
//  Created by XiaoweiYang on 16/3/17.
//
//

#import "MyUserDefaultConfig.h"

@implementation MyUserDefaultConfig

+ (instancetype) sharedInstance {
    static MyUserDefaultConfig *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MyUserDefaultConfig alloc] init];
    });
    return sharedInstance;
}

-(NSString *)userName{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *user = [userDefault objectForKey:@"SuperVR_userName"];
    return user;
}

-(void)setUserName:(NSString *)userName{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:userName forKey:@"SuperVR_userName"];
    [userDefault synchronize];
}

-(NSString *)password{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *pass = [userDefault objectForKey:@"SuperVR_password"];
    return pass;
}

-(void)setPassword:(NSString *)password{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:password forKey:@"SuperVR_password"];
    [userDefault synchronize];
}

@end



