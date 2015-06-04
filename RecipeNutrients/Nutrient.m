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
@property (strong, nonatomic) NSString *gm;
@property (strong, nonatomic) NSDictionary *measurements;
@property (strong, nonatomic) NSArray *measures;

@end

@implementation Nutrient

-(instancetype)initWithJson:(NSDictionary*)json {
    self = [super init];
    if (self) {
        
        if (json == nil) {
            return nil;
        }
        
        if (json[@"nutrient_id"] == nil) {
            return nil;
        }
        
        [self setValuesForKeysWithDictionary:json];
        [self parseMeasures];
    }
    return self;
}

-(NSArray*)parseMultipleWithJson:(NSArray*)json {
    if (json == nil) {
        return nil;
    }
    
    NSMutableArray *parsedItems = [[NSMutableArray alloc] init];
    
    for (NSDictionary *entry in json) {
        Nutrient *nutrient = [[Nutrient alloc] initWithJson:entry];
        
        if (nutrient != nil) {
            [parsedItems addObject:nutrient];
        }
    }
    
    if ([parsedItems count] == 0) {
        return nil;
    }
    
    return parsedItems;
}


-(void)parseMeasures {
    if ([self.measures count] > 0) {
        
        NSArray *parsedMeasurements = [[Measure alloc] parseMultipleWithJson:self.measures];
        self.measurements = [NSDictionary dictionaryWithObjects:parsedMeasurements forKeys:[parsedMeasurements valueForKey:@"getLabel"]];
        
    }
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

-(NSString*)get100GramEquivalentValue {
    return self.gm;
}

-(NSDictionary*)getMeasurements {
    return self.measurements;
}
@end
