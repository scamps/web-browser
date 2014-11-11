//
//  NSHistoryManager.m
//  web browser
//
//  Created by Alberto Scampini on 11/11/14.
//  Copyright (c) 2014 Alberto Scampini. All rights reserved.
//

#import "NSHistoryManager.h"
#import "NSPageHistory.h"

@implementation NSHistoryManager

- (void)addPageHistory:(NSPageHistory *) pageHistory{
    NSError *error = nil;
    //prepare to save
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"History" inManagedObjectContext:self.managedObjectContext];
    NSManagedObject *newPageHistory = [[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    //create element
    [newPageHistory setValue:pageHistory.pageTitle forKey:@"pageTitle"];
    [newPageHistory setValue:pageHistory.pageUrl forKey:@"pageUrl"];
    [newPageHistory setValue:pageHistory.pagePreviewPictureName forKey:@"pagePreviewPictureName"];
    //save
    if (![newPageHistory.managedObjectContext save:&error]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }else{
        //NSLog(@"saved");
    }
}

- (NSPageHistory *)loadPageHistoryFromIndex:(int) index{
    NSPageHistory * loadedPageHistory=[[NSPageHistory alloc]init];
    
    //load data from database
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"History" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"Unable to execute fetch request.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    } else if(result.count>index){
        NSManagedObject *tempPageHistoryObject = (NSManagedObject *)[result objectAtIndex:index];
        loadedPageHistory.pageTitle=[tempPageHistoryObject valueForKey:@"pageTitle"];
        loadedPageHistory.pageUrl=[tempPageHistoryObject valueForKey:@"pageUrl"];
        loadedPageHistory.pagePreviewPictureName=[tempPageHistoryObject valueForKey:@"pagePreviewPictureName"];
    }

    return loadedPageHistory;
}

- (int)contPagesHistory{
    int temp_cont=0;
    //load data from database
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"History" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
#ifdef log_enabled
        NSLog(@"Unable to execute fetch request.");
        NSLog(@"%@, %@", error, error.localizedDescription);
#endif
    } else{
        temp_cont=(int)result.count;
    }
    
    return temp_cont;
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "Alberto-Scampini.superfling" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"web_browser" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"History.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
#ifdef log_enabled
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
#endif
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
#ifdef log_enabled
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
#endif
            abort();
        }
    }
}

@end
