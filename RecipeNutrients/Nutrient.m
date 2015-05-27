//
//  Nutrient.m
//  RecipeNutrients
//
//  Created by Pho Diep on 5/20/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "Nutrient.h"
#import "Measure.h"

@interface Nutrient ()

@property (strong, nonatomic) NSString *measures;

@end

@implementation Nutrient

-(instancetype)initWithJson:(NSDictionary*)json {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:json];
        
        [self parseMeasures];
    }
    return self;
}

-(void)parseMeasures {
    NSArray *rawMeasures = (NSArray*) self.measures;
    NSMutableDictionary *parsedMeasures = [[NSMutableDictionary alloc] init];
        
    for (id item in rawMeasures) {
        Measure *measure = [[Measure alloc] initWithJson:item];
        [parsedMeasures setObject:measure forKey:measure.label];
    }
    
    self.measurements = parsedMeasures;
}

-(NSArray*)getMeasurementOptions {
    return [self.measurements allKeys];
}

@end
