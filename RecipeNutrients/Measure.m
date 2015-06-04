//
//  Measure.m
//  RecipeNutrients
//
//  Created by Pho Diep on 5/26/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "Measure.h"

@interface Measure ()

@property (strong, nonatomic) NSString *eqv;
@property (strong, nonatomic) NSString *label;
@property (nonatomic) int qty;
@property (nonatomic) float value;

@end

@implementation Measure

-(instancetype)initWithJson:(NSDictionary*)json {
    self = [super init];
    if (self) {
        
        if (json == nil) {
            return nil;
        }
        
        if (json[@"label"] == nil) {
            return nil;
        }
        
        [self setValuesForKeysWithDictionary:json];
    }
    return self;
}

-(NSArray*)parseMultipleWithJson:(NSArray*)json {
    if (json == nil) {
        return nil;
    }
    
    NSMutableArray *parsedItems = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in json) {
        Measure *measure = [[Measure alloc] initWithJson:item];
        
        if (measure != nil) {
            [parsedItems addObject:measure];
        }
    }
    
    if ([parsedItems count] == 0) {
        return nil;
    }
    
    return parsedItems;
}

-(NSString*)getEquivalent {
    return self.eqv;
}

-(NSString*)getLabel {
    return self.label;
}

-(int)getQuantity {
    return self.qty;
}

-(float)getValue {
    return self.value;
}

@end
