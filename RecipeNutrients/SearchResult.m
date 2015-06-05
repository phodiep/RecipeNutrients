//
//  SearchResult.m
//  RecipeNutrients
//
//  Created by Pho Diep on 5/27/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "SearchResult.h"

@interface SearchResult ()

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *ndbno;
@property (strong, nonatomic) NSString *foodGroup;

@end

@implementation SearchResult

-(instancetype)initWithJson:(NSDictionary*)json {
    self = [super init];
    
    if (self) {
        if (json == nil) {
            return nil;
        }
        
        if (json[@"ndbno"] == nil) {
            return nil;
        }
        
        // must replace 'group' with 'foodGroup' and remove 'offset' prior to setting properties
        NSDictionary *newJson = [self replaceGroupKeyWithValidFoodGroup:json];
        [self setValuesForKeysWithDictionary:newJson];
    }
    return self;
}

-(NSArray*)parseMultipleWithJson:(NSArray*)json {
    if (json == nil) {
        return nil;
    }
    
    NSMutableArray *parsedItems = [[NSMutableArray alloc] init];
    
    for (NSDictionary *entry in json) {
        SearchResult *searchResult = [[SearchResult alloc] initWithJson:entry];
        
        if (searchResult != nil) {
            [parsedItems addObject:searchResult];
        }
    }
    
    if ([parsedItems count] == 0) {
        return nil;
    }
    
    return parsedItems;

}

-(NSDictionary*)replaceGroupKeyWithValidFoodGroup:(NSDictionary*)oldDictionary {
    NSMutableDictionary *newDictionary = [[NSMutableDictionary alloc] initWithDictionary:oldDictionary];
    
    newDictionary[@"foodGroup"] = newDictionary[@"group"];
    [newDictionary removeObjectForKey:@"group"];
    [newDictionary removeObjectForKey:@"offset"];
    
    return newDictionary;
}

-(NSString*)getName {
    return self.name;
}

-(NSString*)getNdbno {
    return self.ndbno;
}

-(NSString*)getFoodGroup {
    return self.foodGroup;
}

@end
