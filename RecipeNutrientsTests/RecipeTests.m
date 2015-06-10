//
//  RecipeTests.m
//  RecipeNutrients
//
//  Created by Pho Diep on 6/9/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Recipe.h"

@interface RecipeTests : XCTestCase

@property (strong, nonatomic) Recipe *recipe;

@end

@implementation RecipeTests

- (void)setUp {
    [super setUp];
    self.recipe = [[Recipe alloc] initWithName:@"Flan" servings:8 servingUnits:@"mini ramekins" ingredients:@[@"a", @"b", @"c"]];
    
}

- (void)tearDown {
    
    [super tearDown];
}

#pragma mark - init
- (void)testInitFull {
    Recipe *recipe = [[Recipe alloc] initWithName:@"Flan" servings:8 servingUnits:@"mini ramekins" ingredients:@[@"a", @"b", @"c"]];
    
    XCTAssert(recipe != nil);
}

- (void)testInit_noIngredients {
    Recipe *recipe = [[Recipe alloc] initWithName:@"Flan" servings:8 servingUnits:@"mini ramekins"];
    
    XCTAssert(recipe != nil);
}

- (void)testInit_nameOnly {
    Recipe *recipe = [[Recipe alloc] initWithName:@"Flan"];
    
    XCTAssert(recipe != nil);
}

#pragma mark - get
- (void)testGetName {
    XCTAssert([self.recipe.getName isEqualToString:@"Flan"]);
}

- (void)testGetServings {
    XCTAssert([self.recipe getServings] == 8);
}

- (void)testGetServingUnits {
    XCTAssert([[self.recipe getServingUnits] isEqualToString:@"mini ramekins"]);
}

- (void)testGetIngredients {
    NSArray *ingredients = [self.recipe getIngredients];
    XCTAssert([ingredients count] == 3);
    XCTAssert([ingredients[0] isEqualToString:@"a"]);
    XCTAssert([ingredients[2] isEqualToString:@"c"]);
}

#pragma mark - update
- (void)testUpdateName {
    [self.recipe updateName:@"new name"];
    XCTAssert([[self.recipe getName] isEqualToString:@"new name"]);
}

- (void)testUpdateName_nilName {
    [self.recipe updateName:nil];
    XCTAssert([[self.recipe getName] isEqualToString:@"Flan"]);
}

- (void)testUpdateName_emptyName {
    [self.recipe updateName:@""];
    XCTAssert([[self.recipe getName] isEqualToString:@"Flan"]);
}


- (void)testUpdateServings {
    [self.recipe updateServings:2];
    XCTAssert([self.recipe getServings] == 2);
}

- (void)testUpdateServingUnits {
    [self.recipe updateServingUnits:@"large"];
    XCTAssert([[self.recipe getServingUnits] isEqualToString:@"large"]);
}

- (void)testUpdateIngredients {
    NSMutableArray *ingredients = [[NSMutableArray alloc] initWithArray:[self.recipe getIngredients]];
    [ingredients removeObject:@"a"];
    [ingredients addObject:@"new"];
    [ingredients addObject:@"newer"];
    [self.recipe updateIngredients:ingredients];
    XCTAssert([[self.recipe getIngredients] count] == 4);
    XCTAssert([[self.recipe getIngredients][0] isEqualToString:@"b"]);
    XCTAssert([[self.recipe getIngredients][2] isEqualToString:@"new"]);
    XCTAssert([[self.recipe getIngredients][3] isEqualToString:@"newer"]);
}



@end
