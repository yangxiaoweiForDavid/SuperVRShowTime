//
//  DatabaseOprationer.m
//  XSpace
//
//  Created by XiaoweiYang on 15/7/26.
//  Copyright (c) 2015年 XiaoweiYang. All rights reserved.
//

#import "DatabaseOprationer.h"
#import "AppDelegate.h"




@interface DatabaseOprationer ()
{
}
@property(nonatomic,strong)AppDelegate *m_appDelegate;

@end


@implementation DatabaseOprationer


#pragma mark -
#pragma mark   system

+ (instancetype) sharedInstance {
    static DatabaseOprationer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DatabaseOprationer alloc] init];
        sharedInstance.m_appDelegate = [AppDelegate getMainAppDelegate];
    });
    return sharedInstance;
}

-(void)saveDatabase
{
    NSManagedObjectContext *context = [self.m_appDelegate managedObjectContext];
    [context save:nil];
}

-(NSFetchRequest *)fetchRequestForDatabaseTable:(NSString *)table{
    NSManagedObjectContext *context = [self.m_appDelegate managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:table
                                                   inManagedObjectContext:context];
    [request setEntity:entityDesc];
    return request;
}


@end


