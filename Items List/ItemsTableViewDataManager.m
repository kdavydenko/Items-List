//
//  ItemsTableViewDataManager.m
//  Items List
//
//  Created by KONSTANTIN DAVYDENKO on 2017-12-20.
//  Copyright © 2017 KONSTANTIN DAVYDENKO. All rights reserved.
//

#import "ItemsTableViewDataManager.h"
#import "PersistentStack.h"

@implementation ItemsTableViewDataManager

- (NSArray *)items {
    NSError *error;
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    NSManagedObjectContext *context = [[PersistentStack sharedInstance] managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"Book" inManagedObjectContext:context];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    
    
    NSArray *booksArray = [context executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"[%@, %@] error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), [error localizedDescription]);
        abort();
    }
    if (booksArray) {
        [items addObject:[booksArray mutableCopy]];
    }
    
    request.entity = [NSEntityDescription entityForName:@"Disc" inManagedObjectContext:context];
    [request setSortDescriptors:@[sortDescriptor]];
    
    NSArray *discsArray = [context executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"[%@, %@] error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), [error localizedDescription]);
        abort();
    }
    if (discsArray) {
        [items addObject:[discsArray mutableCopy]];
    }
    
    
    return items;
}

@end
