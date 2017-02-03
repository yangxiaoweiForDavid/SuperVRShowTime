//
//  AppDelegate.h
//  SuperVRShowTime
//
//  Created by XiaoweiYang on 16/8/16.
//  Copyright © 2016年 XiaoweiYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) IBOutlet UIWindow *window;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
+ (AppDelegate*)getMainAppDelegate;


@end

