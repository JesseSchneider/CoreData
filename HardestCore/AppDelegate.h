//
//  AppDelegate.h
//  HardestCore
//
//  Created by JESSE SCHNEIDER on 10/21/14.
//  Copyright (c) 2014 JESSE SCHNEIDER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "DAO.h"
#import "qcdDemoViewController.h"

@class DAO;
@class qcdDemoViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) UINavigationController *navigationController;

@property (strong, nonatomic) DAO *dao;
@property (strong, nonatomic) qcdDemoViewController *parentVC;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

