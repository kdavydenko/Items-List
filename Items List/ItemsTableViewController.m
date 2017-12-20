//
//  ItemsTableViewController.m
//  Items List
//
//  Created by KONSTANTIN DAVYDENKO on 2017-12-20.
//  Copyright © 2017 KONSTANTIN DAVYDENKO. All rights reserved.
//

#import "ItemsTableViewController.h"
#import "ItemsTableViewViewModel.h"
#import "ItemTableViewCell.h"
#import "BaseItem+CoreDataClass.h"
#import "Disc+CustomProperties.h"
#import "Book+CoreDataClass.h"
#import "SoftwareDevelopmentBook+CoreDataClass.h"
#import "EsotericBook+CoreDataClass.h"
#import "CookingBook+CoreDataClass.h"
#import "ItemViewController.h"

@interface ItemsTableViewController ()

@end

@implementation ItemsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[ItemsTableViewViewModel alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.viewModel refreshItemsList];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.viewModel.items count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel.items[section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"BOOK";
    } else {
        return @"DISK";
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemCell" forIndexPath:indexPath];
    
    BaseItem *item = [[self.viewModel.items objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.cellImageView.image = [UIImage imageWithData:item.coverImage];
    cell.titleLabel.text = item.title;
    
    if ([item isKindOfClass:[SoftwareDevelopmentBook class]]) {
        cell.subTitleLabel.text = @"Software Development";
    } else if ([item isKindOfClass:[EsotericBook class]]) {
        cell.subTitleLabel.text = @"Esoteric";
    } else if ([item isKindOfClass:[CookingBook class]]) {
        cell.subTitleLabel.text = @"Cooking";
    } else {
        cell.subTitleLabel.text = [((Disc *)item) contentTypeToString];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0f;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showItem"]) {
        ItemViewController *destinationViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        destinationViewController.item = [[self.viewModel.items objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    }
}

@end
