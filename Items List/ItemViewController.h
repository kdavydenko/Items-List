//
//  ItemViewController.h
//  Items List
//
//  Created by KONSTANTIN DAVYDENKO on 2017-12-20.
//  Copyright © 2017 KONSTANTIN DAVYDENKO. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseItem;

@interface ItemViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;

@property (strong, nonatomic) BaseItem *item;

@end
