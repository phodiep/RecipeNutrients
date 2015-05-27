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

@property (strong, nonatomic) NSString *group;
@property (strong, nonatomic) NSString *nutrient_id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *unit;
@property (strong, nonatomic) NSString *value;
@property (strong, nonatomic) NSDictionary *measurements;
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
        [parsedMeasures setObject:measure forKey:measure.getLabel];
    }
    
    self.measurements = parsedMeasures;
}

-(NSArray*)getMeasurementOptions {
    return [self.measurements allKeys];
}

-(NSString*)getGroup {
    return self.group;
}

-(NSString*)getNutrientId {
    return self.nutrient_id;
}

-(NSString*)getName {
    return self.name;
}

-(NSString*)getUnit {
    return self.unit;
}

-(NSString*)getValue {
    return self.value;
}

-(NSDictionary*)getMeasurements {
    return self.measurements;
}
@end
