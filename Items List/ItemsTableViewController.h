//
//  ItemsTableViewController.h
//  Items List
//
//  Created by KONSTANTIN DAVYDENKO on 2017-12-20.
//  Copyright © 2017 KONSTANTIN DAVYDENKO. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemsTableViewViewModel;

@interface ItemsTableViewController : UITableViewController

@property (nonatomic, strong) ItemsTableViewViewModel *viewModel;

@end
