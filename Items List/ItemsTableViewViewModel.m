//
//  ItemsTableViewViewModel.m
//  Items List
//
//  Created by KONSTANTIN DAVYDENKO on 2017-12-20.
//  Copyright © 2017 KONSTANTIN DAVYDENKO. All rights reserved.
//

#import "ItemsTableViewViewModel.h"
#import "ItemsTableViewDataManager.h"
#import "PersistentStack.h"
#import "BaseItem+CoreDataClass.h"

@implementation ItemsTableViewViewModel

- (id)init {
    self = [super init];
    if (self) {
        _dataManager = [[ItemsTableViewDataManager alloc] init];
    }
    return self;
}

- (void)refreshItemsList {
    self.items = self.dataManager.items.mutableCopy;
}

- (void)deleteItemAtIndex:(NSInteger)index inSection:(NSInteger)section {
    
    BaseItem *item = [[self.items objectAtIndex:section] objectAtIndex:index];
    
    [self.items[section] removeObject:item];
    
    [[[PersistentStack sharedInstance] managedObjectContext] deleteObject:item];
    [[PersistentStack sharedInstance] saveContext];
}

@end
