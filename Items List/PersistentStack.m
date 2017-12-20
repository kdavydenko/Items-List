//
//  PersistentStack.m
//  Items List
//
//  Created by KONSTANTIN DAVYDENKO on 2017-12-20.
//  Copyright © 2017 KONSTANTIN DAVYDENKO. All rights reserved.
//

#import "PersistentStack.h"

@interface PersistentStack ()

@property (strong, nonatomic, readwrite) NSManagedObjectContext* managedObjectContext;
@property (strong, nonatomic, readwrite) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic, readwrite) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation PersistentStack

+ (PersistentStack*)sharedInstance
{
    static PersistentStack *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[PersistentStack alloc] init];
    });
    return instance;
}

- (NSString*)storeType
{
    return NSSQLiteStoreType;
}

- (NSURL*)storeURL
{
    NSURL* documentsDirectory = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory
                                                                       inDomain:NSUserDomainMask
                                                              appropriateForURL:nil
                                                                         create:YES
                                                                          error:NULL];
    return [documentsDirectory URLByAppendingPathComponent:@"Model.sqlite"];
}

- (NSDictionary*)sourceMetadata:(NSError **)error
{
    return [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:[self storeType]
                                                                      URL:[self storeURL]
                                                                  options:nil
                                                                    error:error];
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (!_managedObjectModel) {
        
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
        
        if (!modelURL) {
            modelURL = [[NSBundle mainBundle] URLForResource:@"Model"
                                               withExtension:@"mom"];
        }
        
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        
    }
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (!_persistentStoreCoordinator) {
        
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
        
        NSError *error = nil;
        
        NSDictionary *options = @{
                                  NSMigratePersistentStoresAutomaticallyOption: @YES,
                                  NSInferMappingModelAutomaticallyOption: @YES,
                                  NSSQLitePragmasOption: @{@"journal_mode": @"WAL"}
                                  };
        
        
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                       configuration:nil
                                                                 URL:[self storeURL]
                                                             options:options
                                                               error:&error]) {
            // Report any error we got.
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
            dict[NSLocalizedFailureReasonErrorKey] = @"There was an error creating or loading the application's saved data.";
            dict[NSUnderlyingErrorKey] = error;
            error = [NSError errorWithDomain:@"com.kdavydenko.tst" code:9999 userInfo:dict];
            
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            
            if(DEBUG) {
                abort();
            }
        }
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (!_managedObjectContext) {
        
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
        
    }
    
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext
{
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            
            if(DEBUG) {
                abort();
            }
        }
    }
}

- (void)beginUndoGrouping
{
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    managedObjectContext.undoManager = [[NSUndoManager alloc] init];
    [managedObjectContext.undoManager beginUndoGrouping];
}

- (void)endUndoGrouping
{
    NSManagedObjectContext *moc = self.managedObjectContext;
    if(moc.undoManager) {
        [moc.undoManager endUndoGrouping];
    }
}

- (void)undo
{
    NSManagedObjectContext *moc = self.managedObjectContext;
    if(moc.undoManager) {
        [moc.undoManager undo];
        moc.undoManager = nil;
    }
}

@end
