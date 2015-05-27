//
//  FoodListItem.m
//  RecipeNutrients
//
//  Created by Pho Diep on 5/26/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "FoodListItem.h"

@implementation FoodListItem

-(instancetype)initWithJson:(NSDictionary*)json {
    self = [super init];
    if (self) {
//        [self setValuesForKeysWithDictionary:json];
        self.idno = json[@"id"];
        self.name = json[@"name"];
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
        
        [parsedItems addObject:item];
    }
    
    
    return parsedItems;
}

@end
