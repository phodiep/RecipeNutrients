//
//  PickerComponent.h
//  RecipeNutrients
//
//  Created by Pho Diep on 6/8/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PickerComponent : NSObject

-(instancetype)initWithArray:(NSArray*)input;
-(instancetype)initWithLabelArray:(NSArray*)stringInput andValueArray:(NSArray*)valueInput;

-(NSArray*)allLabels;
-(NSArray*)allValues;

-(float)numberOfRows;
-(NSString*)titleForRow:(NSInteger)row;
-(BOOL)valueIsEqualToZeroForRow:(NSInteger)row;

-(float)floatValueForRow:(NSInteger)row;

@end
