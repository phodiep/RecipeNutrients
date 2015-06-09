//
//  RecipeIngredientTests.m
//  RecipeNutrients
//
//  Created by Pho Diep on 6/9/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "RecipeIngredient.h"
#import "Food.h"
#import "Nutrient.h"
#import "UsdaClient.h"

@interface RecipeIngredientTests : XCTestCase

@property (strong, nonatomic) Food *food;
@property (strong, nonatomic) RecipeIngredient *ingredient;


@end

@implementation RecipeIngredientTests

- (void)setUp {
    [super setUp];
    NSString *foodId = @"01009";
    self.food = [[UsdaClient sharedService] fetchFoodReport:foodId];
    
    self.ingredient = [[RecipeIngredient alloc] init:self.food withAmount:(float)1.0 withUnit:@"cup, shredded"];
}

- (void)tearDown {

    [super tearDown];
}

#pragma mark - init
- (void)testInit {
    NSString *foodId = @"01009";
    Food *food = [[UsdaClient sharedService] fetchFoodReport:foodId];

    RecipeIngredient *ingredient = [[RecipeIngredient alloc] init:food withAmount:(float)1.0 withUnit:@"oz"];
    
    XCTAssert(ingredient != nil);
}

- (void)testInit_nilFood {
    RecipeIngredient *ingredient = [[RecipeIngredient alloc] init:nil withAmount:(float)1.0 withUnit:@"oz"];
    
    XCTAssert(ingredient == nil);
}

- (void)testInit_nilAmount {
    NSString *foodId = @"01009";
    Food *food = [[UsdaClient sharedService] fetchFoodReport:foodId];
    
    RecipeIngredient *ingredient = [[RecipeIngredient alloc] init:food withAmount:0 withUnit:@"oz"];
    
    XCTAssert(ingredient != nil);
}

- (void)testInit_nilUnit {
    NSString *foodId = @"01009";
    Food *food = [[UsdaClient sharedService] fetchFoodReport:foodId];
    
    RecipeIngredient *ingredient = [[RecipeIngredient alloc] init:food withAmount:(float)1.0 withUnit:nil];
    
    XCTAssert(ingredient == nil);
}

- (void)testInit_emptyUnit {
    NSString *foodId = @"01009";
    Food *food = [[UsdaClient sharedService] fetchFoodReport:foodId];
    
    RecipeIngredient *ingredient = [[RecipeIngredient alloc] init:food withAmount:(float)1.0 withUnit:@""];
    
    XCTAssert(ingredient == nil);
}

#pragma mark - get properties
- (void)testGetIngredient {
    XCTAssert([self.ingredient.getIngredient isEqual:self.food]);
}

- (void)testGetAmount {
    XCTAssert((self.ingredient.getAmount - 1.0) < 0.0001);
}

- (void)testGetUnit {
    XCTAssert([self.ingredient.getUnit isEqualToString:@"cup, shredded"]);
}

#pragma mark - update
- (void)testUpdateAmount {
    [self.ingredient updateAmount:2.0];
    XCTAssert((self.ingredient.getAmount - 2.0) < 0.0001);
}

- (void)testUpdateUnit {
    [self.ingredient updateUnit:@"oz"];
    XCTAssert([self.ingredient.getUnit isEqualToString:@"oz"]);
}

- (void)testUpdateUnit_invalidUnit {
    [self.ingredient updateUnit:@"fake unit"];
    XCTAssert([self.ingredient.getUnit isEqualToString:@"cup, shredded"]);
}

-(void)testUpdateAmountAndUnit {
    [self.ingredient updateAmount:2.0 andUnit:@"oz"];
    XCTAssert((self.ingredient.getAmount - 2.0) < 0.0001);
    XCTAssert([self.ingredient.getUnit isEqualToString:@"oz"]);
}

-(void)testUpdateAmountAndUnit_invalidUnit {
    [self.ingredient updateAmount:2.0 andUnit:@"fake unit"];
    XCTAssert((self.ingredient.getAmount - 1.0) < 0.0001);
    XCTAssert([self.ingredient.getUnit isEqualToString:@"cup, shredded"]);
}

@end
