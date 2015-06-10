//
//  Recipe.h
//  RecipeNutrients
//
//  Created by Pho Diep on 6/9/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipe : NSObject

- (instancetype)initWithName:(NSString*)name servings:(NSInteger)servings servingUnits:(NSString*)units;
- (instancetype)initWithName:(NSString*)name servings:(NSInteger)servings servingUnits:(NSString*)units ingredients:(NSArray*)ingredients;
-(instancetype)initWithName:(NSString*)name;

-(NSString*)getName;
-(NSInteger)getServings;
-(NSString*)getServingUnits;
-(NSArray*)getIngredients;

-(void)updateName:(NSString*)name;
-(void)updateServings:(NSInteger)servings;
-(void)updateServingUnits:(NSString*)units;
-(void)updateIngredients:(NSArray *)ingredients;

@end
