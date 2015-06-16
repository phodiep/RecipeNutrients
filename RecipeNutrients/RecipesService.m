//
//  RecipesService.m
//  RecipeNutrients
//
//  Created by Pho Diep on 6/15/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "RecipesService.h"

@interface RecipesService ()

@property (strong, nonatomic) NSMutableArray *recipes;

@end

@implementation RecipesService

+(id)sharedService {
    static RecipesService *mySharedService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mySharedService = [[self alloc] init];
    });
    return mySharedService;
}

+(id)sharedService_initForTesting {
    return [[self alloc] init];
}

-(NSArray*)addNewRecipe:(Recipe*)recipe {
    if (recipe == nil) {
        return self.recipes;
    }
    
    if (![self isTypeRecipe:recipe]) {
        return self.recipes;
    }
    
    [self.recipes addObject:recipe];
    return self.recipes;
}

-(NSArray*)addNewRecipes:(NSArray*)newRecipes {
    if (newRecipes == nil) {
        return self.recipes;
    }
    
    for (NSObject *item in newRecipes) {
        if ([self isTypeRecipe:item]) {
            [self addNewRecipe:(Recipe*)item];
        }
    }
    return self.recipes;
}

-(NSArray*)fetchAllRecipes {
    if ([self.recipes count] == 0) {
        return nil;
    }
    return self.recipes;
}

-(NSInteger)countOfRecipes {
    if (self.recipes == nil) {
        return 0;
    }
    return [self.recipes count];
}

-(void)updateRecipe:(Recipe*)recipe {
    if (recipe != nil) {
        for (int i = 0; i < [self.recipes count]; i++) {
            if ((Recipe*) self.recipes[i] == recipe) {
                self.recipes[i] = recipe;
            }
        }
    }
}

-(void)replaceAllRecipes:(NSArray*)newRecipes {
    if ([newRecipes count] > 0) {
        self.recipes = [[NSMutableArray alloc] initWithArray:newRecipes];
    }
}

-(BOOL)isTypeRecipe:(NSObject*)recipe {
    return [recipe isKindOfClass:[Recipe class]];
}

-(NSMutableArray *)recipes {
    if (_recipes == nil) {
        _recipes = [[NSMutableArray alloc] init];
    }
    return _recipes;
}


@end
