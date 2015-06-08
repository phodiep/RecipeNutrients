//
//  PickerComponent.m
//  RecipeNutrients
//
//  Created by Pho Diep on 6/8/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "PickerComponent.h"

@interface PickerComponent ()

@property (strong, nonatomic) NSArray *labels;
@property (strong, nonatomic) NSArray *values;




@end

@implementation PickerComponent

-(instancetype)initWithArray:(NSArray*)input {
    self = [super init];
    if (self) {
        if (input == nil) {
            return nil;
        }
        if ([input count] == 0) {
            return nil;
        }
        
        self.labels = input;
        self.values = input;
    }
    return self;
}

-(instancetype)initWithLabelArray:(NSArray*)stringInput andValueArray:(NSArray*)valueInput {
    self = [super init];
    
    if (self) {
        if (stringInput == nil) {
            return nil;
        }
        if (valueInput == nil) {
            return nil;
        }
        if ([stringInput count] == 0) {
            return nil;
        }
        if ([valueInput count] == 0) {
            return nil;
        }
        if ([stringInput count] != [valueInput count]) {
            return nil;
        }
        
        self.labels = stringInput;
        self.values = valueInput;
    }
    return self;
}

-(NSArray*)allLabels {
    return self.labels;
}

-(NSArray*)allValues {
    return self.values;
}

-(long)countOfLabels {
    return [self.labels count];
}

-(long)countOfValues {
    return [self.values count];
}

-(float)numberOfRows {
    return [self.labels count];
}

-(NSString*)titleForRow:(NSInteger)row {
    if (row >= [self.labels count]) {
        return nil;
    }
    return [NSString stringWithFormat:@"%@", self.labels[row]];
}

-(BOOL)valueIsEqualToZeroForRow:(NSInteger)row {
    if (row >= [self.values count]) {
        return false;
    }
    NSString *valueAsString = [NSString stringWithFormat:@"%@", self.values[row]];
    NSLog(@"%@", valueAsString);
    if (![valueAsString isEqualToString:@"0"]) {
        return false;
    }
    
    return true;
}

-(float)floatValueForRow:(NSInteger)row {
    return [self.values[row] floatValue];
}

@end
