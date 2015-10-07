//
//  AppDelegate.h
//  unyq
//
//  Created by Agustín Embuena Majúa on 17/9/15.
//  Copyright (c) 2015 UNYQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (copy) void (^sessionCompletionHandler)();

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

