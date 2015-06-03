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
@property (strong, nonatomic) NSArray *nutrients;
@property (strong, nonatomic) NSString *fg;
@property (strong, nonatomic) NSDictionary *nutrientsDict;

@end

@implementation Food

-(instancetype)initWithJson:(NSDictionary*)json {
    self = [super init];
    
    if (self) {
        if (json == nil) {
            return nil;
        }
        
        if (json[@"ndbno"] == nil) {
            return nil;
        }

        [self setValuesForKeysWithDictionary:json];
        [self parseNutrients];

    }
    return self;
}

-(NSArray*)parseMultipleWithJson:(NSArray*)json {
    if (json == nil) {
        return nil;
    }
    
    NSMutableArray *parsedItems = [[NSMutableArray alloc] init];
    
    for (NSDictionary *entry in json) {
        Food *food = [[Food alloc] initWithJson:entry];
        
        if (food != nil) {
            [parsedItems addObject:food];
        }
    }
    
    if ([parsedItems count] == 0) {
        return nil;
    }
    
    return parsedItems;
}


-(void)parseNutrients {
    
    if ([self.nutrients count] > 0) {
    
        NSArray *parsedNutrients = [[Nutrient alloc] parseMultipleWithJson: self.nutrients];
        self.nutrientsDict = [NSDictionary dictionaryWithObjects:parsedNutrients forKeys:[parsedNutrients valueForKey:@"getNutrientId"]];
        
    }
}

-(NSString*)getName {
    return self.name;
}

-(NSString*)getNdbno {
    return self.ndbno;
}

-(NSDictionary*)getNutrients {
    return self.nutrientsDict;
}

-(NSString*)getFoodGroup {
    return self.fg;
}

@end

