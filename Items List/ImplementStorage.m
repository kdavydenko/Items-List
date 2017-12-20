//
//  ImplementStorage.m
//  Items List
//
//  Created by KONSTANTIN DAVYDENKO on 2017-12-20.
//  Copyright © 2017 KONSTANTIN DAVYDENKO. All rights reserved.
//

#import "ImplementStorage.h"
#import "SoftwareDevelopmentBook+CoreDataClass.h"
#import "EsotericBook+CoreDataClass.h"
#import "CookingBook+CoreDataClass.h"
#import "Disc+CustomProperties.h"
#import "PersistentStack.h"
#import <UIKit/UIKit.h>

@implementation ImplementStorage

- (void)addItems {
    [self addBooks];
    [self addDiscs];
}

- (void)addBooks {
   
    NSManagedObjectContext *context = [[PersistentStack sharedInstance] managedObjectContext];
    
    SoftwareDevelopmentBook *sDBook = [NSEntityDescription insertNewObjectForEntityForName:@"SoftwareDevelopmentBook" inManagedObjectContext:context];
    sDBook.title = @"Effective Objective-C 2.0";
    sDBook.price = 19.99;
    sDBook.barcode = @"878975154";
    sDBook.coverImage = UIImageJPEGRepresentation([UIImage imageNamed:@"eoc.jpg"], 1.0);
    sDBook.numberOfPages = 490;
    sDBook.programmingLanguage = @"Objective-C";

    EsotericBook *eBook = [NSEntityDescription insertNewObjectForEntityForName:@"EsotericBook" inManagedObjectContext:context];
    eBook.title = @"The Fourth Book of Occult Philosophy";
    eBook.price = 99.99;
    eBook.barcode = @"132152214";
    eBook.coverImage = UIImageJPEGRepresentation([UIImage imageNamed:@"esoteric.jpg"], 1.0);
    eBook.numberOfPages = 795;
    eBook.minimalAge = 18;
    
    CookingBook *cBook = [NSEntityDescription insertNewObjectForEntityForName:@"CookingBook" inManagedObjectContext:context];
    cBook.title = @"The Meat Cookbook";
    cBook.price = 9.99;
    cBook.barcode = @"672945772";
    cBook.coverImage = UIImageJPEGRepresentation([UIImage imageNamed:@"meat.jpg"], 1.0);
    cBook.numberOfPages = 154;
    cBook.mainIngridient = @"Meat";
    
    [[PersistentStack sharedInstance] saveContext];
}

- (void)addDiscs {
    NSArray *discCoversArray = @[@"zedd.jpg", @"hobbit.jpg", @"office.jpeg"];
    NSArray *discTitles = @[@"Zedd - Clarity", @"The Hobbit: The Desolation of Smaug", @"Microsoft Office 365"];
    NSArray *discBarcodes = @[@"878975154", @"672945772", @"132152214"];
    NSArray *discType = @[@(DiscTypeCD), @(DiscTypeDVD), @(DiscTypeDVD)];
    NSArray *contentType = @[@(ContentTypeMusic), @(ContentTypeVideo), @(ContetnTypeSoftware)];
    NSArray *price = @[@19.99, @29.99, @199.99];
    
    
    NSManagedObjectContext *context = [[PersistentStack sharedInstance] managedObjectContext];
    for(int i = 0; i < 3; i++) {
        Disc *newDisc = [NSEntityDescription insertNewObjectForEntityForName:@"Disc" inManagedObjectContext:context];
        
        NSData *data = UIImageJPEGRepresentation([UIImage imageNamed:discCoversArray[i]], 1.0);
        
        newDisc.title = discTitles[i];
        newDisc.price = [price[i] doubleValue];
        newDisc.barcode = discBarcodes[i];
        newDisc.coverImage = data;
        newDisc.type = [discType[i] intValue];
        newDisc.content = [contentType[i] intValue];
    }
    [[PersistentStack sharedInstance] saveContext];
}

@end
