//
//  Fraction.m
//  RecipeNutrients
//
//  Created by Pho Diep on 6/9/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "Fraction.h"

@interface Fraction ()

@property (nonatomic) float value;
@property (nonatomic) unichar unicode;

@end

@implementation Fraction

-(instancetype)initValue:(float)value withUnicode:(unichar)unicode {
    self = [super init];
    
    self.value = value;
    self.unicode = unicode;
    
    return self;
}


-(float)getValue {
    return self.value;
}

-(unichar)getUnicode {
    return self.unicode;
}

-(NSString*)getString {
    return [NSString stringWithFormat:@"%C",self.unicode];
}

-(BOOL)isEqualTo:(float)otherValue {
    if (fabsf(self.value - otherValue) < 0.0001) {
        return true;
    }
    return false;
}

+(NSArray*)fetchFullSetOfFractionsEighth {
    NSMutableArray *fullSet = [[NSMutableArray alloc] init];
    // 1/8
    [fullSet addObject:[[Fraction alloc] initValue:0.125 withUnicode:0x215B]];
    // 1/4
    [fullSet addObject:[[Fraction alloc] initValue:0.25 withUnicode:0x00bc]];
    // 3/8
    [fullSet addObject:[[Fraction alloc] initValue:0.375 withUnicode:0x215C]];
    // 1/2
    [fullSet addObject:[[Fraction alloc] initValue:0.5 withUnicode:0x00bd]];
    // 5/8
    [fullSet addObject:[[Fraction alloc] initValue:0.625 withUnicode:0x215D]];
    // 3/4
    [fullSet addObject:[[Fraction alloc] initValue:0.75 withUnicode:0x00be]];
    // 7/8
    [fullSet addObject:[[Fraction alloc] initValue:0.875 withUnicode:0x215E]];
    
    return fullSet;
}

+(NSArray*)fetchFullSetOfFractionsEighthWithZero {
    NSMutableArray *fullSet = [[NSMutableArray alloc] init];
    // 0
    [fullSet addObject:[[Fraction alloc] initValue:0 withUnicode:0x0030]];

    [fullSet addObjectsFromArray:[self fetchFullSetOfFractionsEighth]];
    
    return fullSet;
}

+(NSArray*)getAllValues:(NSArray*)fractions {
    NSMutableArray *values = [[NSMutableArray alloc] init];
    for (Fraction *fraction in fractions) {
        if (fraction == nil) {
            [values addObject:nil];
        } else {
            [values addObject: [NSNumber numberWithFloat:fraction.getValue]];
        }
    }
    
    return values;
}

+(NSArray*)getAllStrings:(NSArray*)fractions {
    NSMutableArray *strings = [[NSMutableArray alloc] init];
    for (Fraction *fraction in fractions) {
        if (fraction == nil) {
            [strings addObject:nil];
        } else {
            [strings addObject: fraction.getString];
        }
    }
    
    return strings;
}

@end
