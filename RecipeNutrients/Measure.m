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
        [self setValuesForKeysWithDictionary:json];
    }
    return self;
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
