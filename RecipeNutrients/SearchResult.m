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
        
        self.name = json[@"name"];
        self.ndbno = json[@"ndbno"];
        self.foodGroup = json[@"group"];
        
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
        [parsedItems addObject:searchResult];
    }
    
    return parsedItems;

}

-(NSString*)getName {
    return self.name;
}

-(NSString*)getNdbno {
    return self.ndbno;
}

-(NSString*)getGroup {
    return self.foodGroup;
}

@end
