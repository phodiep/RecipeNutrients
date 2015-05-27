//
//  Measure.m
//  RecipeNutrients
//
//  Created by Pho Diep on 5/26/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "Measure.h"

@implementation Measure

-(instancetype)initWithJson:(NSDictionary*)json {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:json];
    }
    return self;
}

@end
