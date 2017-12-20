//
//  ItemsTableViewViewModel.h
//  Items List
//
//  Created by KONSTANTIN DAVYDENKO on 2017-12-20.
//  Copyright © 2017 KONSTANTIN DAVYDENKO. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ItemsTableViewDataManager;

@interface ItemsTableViewViewModel : NSObject

@property (nonatomic, strong) ItemsTableViewDataManager *dataManager;
@property (nonatomic, strong) NSMutableArray *items;

- (void)refreshItemsList;
- (void)deleteItemAtIndex:(NSInteger)index inSection:(NSInteger)section;

@end
