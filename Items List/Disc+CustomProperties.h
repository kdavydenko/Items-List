//
//  Disc+CustomProperties.h
//  Items List
//
//  Created by KONSTANTIN DAVYDENKO on 2017-12-20.
//  Copyright © 2017 KONSTANTIN DAVYDENKO. All rights reserved.
//

#import "Disc+CoreDataClass.h"

typedef NS_ENUM(int16_t, ContentType) {
    ContentTypeUndefined = 0,
    ContentTypeMusic,
    ContentTypeVideo,
    ContetnTypeSoftware
};

typedef NS_ENUM(int16_t, DiscType) {
    DiscTypeUndefined = 0,
    DiscTypeCD,
    DiscTypeDVD
};

@interface Disc (CustomProperties)

- (NSString *)contentTypeToString;
- (NSString *)discTypeToString;

@end
