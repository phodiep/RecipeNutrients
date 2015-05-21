//
//  Food.m
//  RecipeNutrients
//
//  Created by Pho Diep on 5/20/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "Food.h"
#import "Nutrient.h"

@implementation Food

-(instancetype)initWithJson:(NSDictionary*)json {
    self = [super init];
    
    if (self) {
    
        self.name = json[@"name"];
        self.ndbNo = json[@"ndbno"];

        NSArray *rawNutrients = (NSArray*)json[@"nutrients"];

        NSMutableArray *parsedNutrients = [[NSMutableArray alloc] init];
        for (id item in rawNutrients) {
            [parsedNutrients addObject:[[Nutrient alloc]initWithJson:(NSDictionary*)item]];
        }

        self.nutrients = [[NSArray alloc] initWithArray:parsedNutrients];
    }
    
    return self;
}

@end

