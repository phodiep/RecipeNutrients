//
//  Recipe.m
//  RecipeNutrients
//
//  Created by Pho Diep on 6/9/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "Recipe.h"

@interface Recipe ()

@property (strong, nonatomic) NSString *name;
@property (nonatomic) NSInteger servings;
@property (strong, nonatomic) NSString *servingUnits;
@property (strong, nonatomic) NSMutableArray *ingredients;

@end

@implementation Recipe

- (instancetype)initWithName:(NSString*)name servings:(NSInteger)servings servingUnits:(NSString*)units ingredients:(NSArray*)ingredients {
    self = [super init];
    if (self) {
        if ([name isEqualToString: @""]) {
            return nil;
        }
        self.name = name;
        self.servings = servings;
        self.servingUnits = units;
        self.ingredients = [[NSMutableArray alloc] initWithArray:ingredients];
    }
    return self;
}

- (instancetype)initWithName:(NSString*)name servings:(NSInteger)servings servingUnits:(NSString*)units {
    return [self initWithName:name servings:servings servingUnits:units ingredients:nil];
}

-(instancetype)initWithName:(NSString*)name {
    return [self initWithName:name servings:0 servingUnits:@""];
}

-(NSString*)getName {
    return self.name;
}

-(NSInteger)getServings {
    return self.servings;
}

-(NSString*)getServingUnits {
    return self.servingUnits;
}

-(NSArray*)getIngredients {
    return self.ingredients;
}

-(void)updateName:(NSString*)name {
    if (![name isEqualToString:@""] && name != nil){
        self.name = name;
    }
}

-(void)updateServings:(NSInteger)servings {
    self.servings = servings;
}

-(void)updateServingUnits:(NSString*)units {
    self.servingUnits = units;
}

-(void)updateIngredients:(NSArray *)ingredients {
    self.ingredients = [[NSMutableArray alloc] initWithArray:ingredients];
}

@end
