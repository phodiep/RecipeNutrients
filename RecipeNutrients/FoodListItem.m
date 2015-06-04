//
//  FoodListItem.m
//  RecipeNutrients
//
//  Created by Pho Diep on 5/26/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "FoodListItem.h"

@interface FoodListItem ()

@property (strong, nonatomic) NSString *idno;
@property (strong, nonatomic) NSString *name;

@end

@implementation FoodListItem

-(instancetype)initWithJson:(NSDictionary*)json {
    self = [super init];
    if (self) {
        
        if (json == nil) {
            return nil;
        }
        
        if (json[@"id"] == nil) {
            return nil;
        }
        
        // must replace 'id' with 'idno' and remove 'offset' prior to setting properties
        NSDictionary *newJson = [self replaceIdKeyWithValidIdno:json];
        [self setValuesForKeysWithDictionary:newJson];

    }
    return self;
}

-(NSArray*)parseMultipleWithJson:(NSArray*)json {
    if (json == nil) {
        return nil;
    }

    NSMutableArray *parsedItems = [[NSMutableArray alloc] init];
    
    for (NSDictionary* entry in json) {
        FoodListItem *item = [[FoodListItem alloc] initWithJson:entry];
        
        if (item != nil) {
            [parsedItems addObject:item];
        }
    }
    
    if ([parsedItems count] == 0) {
        return nil;
    }
    
    return parsedItems;
}

-(NSDictionary*)replaceIdKeyWithValidIdno:(NSDictionary*)oldDictionary {
    NSMutableDictionary *newDictionary = [[NSMutableDictionary alloc] initWithDictionary:oldDictionary];
    
    newDictionary[@"idno"] = newDictionary[@"id"];
    [newDictionary removeObjectForKey:@"id"];
    [newDictionary removeObjectForKey:@"offset"];
    
    return newDictionary;
}

+(NSString*)listTypeToString:(ListType)listType {
    switch (listType) {
        case f:
            return @"f";
            break;
        case n:
            return @"n";
            break;
        case ns:
            return @"ns";
            break;
        case nr:
            return @"nr";
            break;
        case g:
            return @"g";
            break;
        default:
            break;
    }
    return nil;
}

-(NSString*)getId {
    return self.idno;
}

-(NSString*)getName {
    return self.name;
}

@end
