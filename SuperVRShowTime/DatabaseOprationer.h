//
//  DatabaseOprationer.h
//  XSpace
//
//  Created by XiaoweiYang on 15/7/26.
//  Copyright (c) 2015年 XiaoweiYang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DatabaseOprationer : NSObject
{
}

+(instancetype)sharedInstance;
-(void)saveDatabase;
-(NSFetchRequest *)fetchRequestForDatabaseTable:(NSString *)table;

@end


