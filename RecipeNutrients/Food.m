//
//  Food.m
//  RecipeNutrients
//
//  Created by Pho Diep on 5/20/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "Food.h"
#import "Nutrient.h"

@interface Food ()

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *ndbno;
@property (strong, nonatomic) NSArray *nutrientsArray;
@property (strong, nonatomic) NSString *nutrients;

@end

@implementation Food

-(instancetype)initWithJson:(NSDictionary*)json {
    self = [super init];
    
    if (self) {
        [self setValuesForKeysWithDictionary:json];
        [self parseNutrients];
    }
    return self;
}

-(void)parseNutrients {
    NSArray *rawNutrients = (NSArray*) self.nutrients;
    
    NSMutableArray *parsedNutrients = [[NSMutableArray alloc] init];
    for (id item in rawNutrients) {
        [parsedNutrients addObject:[[Nutrient alloc]initWithJson:(NSDictionary*)item]];
    }
    
    self.nutrientsArray = [[NSArray alloc] initWithArray:parsedNutrients];
}

-(NSString*)getName {
    return self.name;
}

-(NSString*)getNdbno {
    return self.ndbno;
}

-(NSArray*)getNutrients {
    return self.nutrientsArray;
}



@end

