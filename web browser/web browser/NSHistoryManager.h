//
//  NSHistoryManager.h
//  web browser
//
//  Created by Alberto Scampini on 11/11/14.
//  Copyright (c) 2014 Alberto Scampini. All rights reserved.
//

@import Foundation;
@import CoreData;

@class NSPageHistory;

@interface NSHistoryManager : NSObject

- (void)addPageHistory:(NSPageHistory *) pageHistory;
- (NSPageHistory *)loadPageHistoryFromIndex:(int) index;
- (int)contPagesHistory;

#pragma Core Data
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
