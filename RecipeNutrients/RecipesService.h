//
//  RecipesService.h
//  RecipeNutrients
//
//  Created by Pho Diep on 6/15/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Recipe.h"

@interface RecipesService : NSObject

+(id)sharedService;
+(id)sharedService_initForTesting;

-(NSArray*)addNewRecipe:(Recipe*)recipe;
-(NSArray*)addNewRecipes:(NSArray*)newRecipes;
-(NSInteger)countOfRecipes;
-(NSArray*)fetchAllRecipes;
-(void)updateRecipe:(Recipe*)recipe;
-(void)replaceAllRecipes:(NSArray*)newRecipes;


@end
