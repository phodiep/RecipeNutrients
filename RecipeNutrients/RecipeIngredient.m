//
//  RecipeIngredient.m
//  RecipeNutrients
//
//  Created by Pho Diep on 6/9/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "RecipeIngredient.h"
#import "Nutrient.h"

@interface RecipeIngredient ()

@property (strong, nonatomic) Food *ingredient;
@property (strong, nonatomic) NSArray *unitOptions;

@property (strong, nonatomic) NSString *unit;
@property (nonatomic) float amount;

@end

@implementation RecipeIngredient

-(instancetype)init:(Food*)ingredient withAmount:(float)amount withUnit:(NSString*)unit {
    self = [super init];
    if (self) {
        if (ingredient == nil) {
            return nil;
        }
        if ([unit isEqualToString:@""]) {
            return nil;
        }
        self.ingredient = ingredient;
        NSArray *keys = [ingredient.getNutrients allKeys];
        self.unitOptions = [ingredient.getNutrients[keys[0]] getMeasurementOptions];
        
        if (![self isValidUnit:unit]) {
            return nil;
        }
        self.amount = amount;
        self.unit = unit;
    }
    return self;
}


-(Food*)getIngredient {
    return self.ingredient;
}

-(float)getAmount {
    return self.amount;
}

-(NSString*)getUnit {
    return self.unit;
}

-(void)updateAmount:(float)amount {
    self.amount = amount;
}

-(void)updateUnit:(NSString*)unit {
    if (![unit isEqualToString:@""] && [self isValidUnit:unit]) {
        self.unit = unit;
    }
}

-(void)updateAmount:(float)amount andUnit:(NSString*)unit {
    if (![unit isEqualToString:@""] && [self isValidUnit:unit]) {
        [self updateUnit:unit];
        [self updateAmount:amount];
    }
}

-(BOOL)isValidUnit:(NSString*)unit {
    for (NSString *item in self.unitOptions) {
        if ([item isEqualToString:unit]) {
            return true;
        }
    }
    return false;
}

@end
