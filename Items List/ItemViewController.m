//
//  ItemViewController.m
//  Items List
//
//  Created by KONSTANTIN DAVYDENKO on 2017-12-20.
//  Copyright © 2017 KONSTANTIN DAVYDENKO. All rights reserved.
//

#import "ItemViewController.h"
#import "ItemPropertyTableViewCell.h"
#import "BaseItem+CoreDataClass.h"
#import "Disc+CustomProperties.h"
#import "Book+CoreDataClass.h"
#import "SoftwareDevelopmentBook+CoreDataClass.h"
#import "EsotericBook+CoreDataClass.h"
#import "CookingBook+CoreDataClass.h"

@interface ItemViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.itemImageView.image = [UIImage imageWithData:self.item.coverImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ItemPropertyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemPropertyCell" forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:
            cell.titleLabel.text = @"TITLE";
            cell.subtitleLabel.text = self.item.title;
            break;
        case 1:
            cell.titleLabel.text = @"PRICE";
            cell.subtitleLabel.text = [NSString stringWithFormat:@"%.02f", self.item.price];
            break;
        case 2:
            cell.titleLabel.text = @"BARCODE";
            cell.subtitleLabel.text = self.item.barcode;
            break;
        case 3:
            if ([self.item isKindOfClass:[Book class]]) {
                cell.titleLabel.text = @"NUMBER OF PAGES";
                cell.subtitleLabel.text = [NSString stringWithFormat:@"%i", ((Book *)self.item).numberOfPages];
            } else {
                cell.titleLabel.text = @"DISC TYPE";
                cell.subtitleLabel.text = [((Disc *)self.item) discTypeToString];
            }
            break;
        case 4:
            if ([self.item isKindOfClass:[Book class]]) {
                cell.titleLabel.text = @"BOOK CATEGORY";
                if ([self.item isKindOfClass:[SoftwareDevelopmentBook class]]) {
                    cell.subtitleLabel.text = @"Software Development";
                } else if ([self.item isKindOfClass:[EsotericBook class]]) {
                    cell.subtitleLabel.text = @"Esoteric";
                } else if ([self.item isKindOfClass:[CookingBook class]]) {
                    cell.subtitleLabel.text = @"Cooking";
                }
            } else {
                cell.titleLabel.text = @"CONTENT TYPE";
                cell.subtitleLabel.text = [((Disc *)self.item) contentTypeToString];
            }
            break;
        case 5:
            if ([self.item isKindOfClass:[SoftwareDevelopmentBook class]]) {
                cell.titleLabel.text = @"PROGRAMMING LANGUAGE";
                cell.subtitleLabel.text = ((SoftwareDevelopmentBook *)self.item).programmingLanguage;
            } else if ([self.item isKindOfClass:[EsotericBook class]]) {
                cell.titleLabel.text = @"MINIMAL AGE";
                cell.subtitleLabel.text = [NSString stringWithFormat:@"%i", ((EsotericBook *)self.item).minimalAge];
            } else if ([self.item isKindOfClass:[CookingBook class]]) {
                cell.titleLabel.text = @"MAIN INGRIDIENT";
                cell.subtitleLabel.text = ((CookingBook *)self.item).mainIngridient;
            }
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.item isKindOfClass:[Book class]]) {
        return 6;
    }
    return 5;
}


@end
