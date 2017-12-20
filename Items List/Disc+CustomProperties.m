//
//  Disc+CustomProperties.m
//  Items List
//
//  Created by KONSTANTIN DAVYDENKO on 2017-12-20.
//  Copyright © 2017 KONSTANTIN DAVYDENKO. All rights reserved.
//

#import "Disc+CustomProperties.h"

@implementation Disc (CustomProperties)

- (NSString *)contentTypeToString {
    NSString *result = nil;
    
    switch(self.content) {
        case ContentTypeUndefined:
            result = @"Undefined";
            break;
        case ContentTypeMusic:
            result = @"Music";
            break;
        case ContentTypeVideo:
            result = @"Video";
            break;
        case ContetnTypeSoftware:
            result = @"Software";
            break;
        default:
            [NSException raise:NSGenericException format:@"Unexpected ContentType."];
    }
    
    return result;
}

- (NSString *)discTypeToString {
    NSString *result = nil;
    
    switch(self.type) {
        case DiscTypeUndefined:
            result = @"Undefined";
            break;
        case DiscTypeCD:
            result = @"CD";
            break;
        case DiscTypeDVD:
            result = @"DVD";
            break;
        default:
            [NSException raise:NSGenericException format:@"Unexpected DiscType."];
    }
    return result;
}

@end
