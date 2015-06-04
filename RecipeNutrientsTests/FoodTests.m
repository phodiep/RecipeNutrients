//
//  FoodTests.m
//  RecipeNutrients
//
//  Created by Pho Diep on 6/1/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Food.h"
#import "Nutrient.h"

@interface FoodTests : XCTestCase

@property (strong, nonatomic) Food *food;

@end

@implementation FoodTests

- (void)setUp {
    [super setUp];
    
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"foodSampleFoodReport" ofType:@"json"];
    NSString *fileContents = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSData *data = [fileContents dataUsingEncoding:NSUTF8StringEncoding];
    NSObject *results = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
    NSDictionary *result = (NSDictionary*) results;
    NSDictionary *report = (NSDictionary*)result[@"report"];
    
    self.food = [[Food alloc] initWithJson:(NSDictionary*)report[@"food"]];

}

- (void)tearDown {
    [super tearDown];
}

#pragma mark - test single init
- (void)testFood {
    XCTAssert([self.food.getName isEqualToString:@"Cheese, cheddar"]);
    XCTAssert([self.food.getNdbno isEqualToString:@"01009"]);
    XCTAssert([self.food.getNutrients count] == 33);
    XCTAssert(self.food.getFoodGroup == nil);
}

- (void)testFoodNutrient {
    NSString *nutrientId = @"204";
    Nutrient *nutrient = self.food.getNutrients[nutrientId];

    XCTAssert([nutrient.getName isEqualToString:@"Total lipid (fat)"]);
    XCTAssert([nutrient.getGroup isEqualToString:@"Proximates"]);
    XCTAssert([nutrient.getUnit isEqualToString:@"g"]);
    XCTAssert([nutrient.getValue isEqualToString:@"33.82"]);
}

- (void)testFood_nilJson {
    Food *food = [[Food alloc] initWithJson:nil];
    
    XCTAssert(food == nil);
}

- (void)testFood_emptyJson {
    NSDictionary *emptyJson = @{};
    Food *food = [[Food alloc] initWithJson:emptyJson];
    
    XCTAssert(food == nil);
}

- (void)testFood_invalidJson {
    NSDictionary *invalidJson = @{@"testingString" : @"is not a valid key"};
    Food *food = [[Food alloc] initWithJson:invalidJson];
    
    XCTAssert(food == nil);
}

- (void)testFood_partialEmptyJson {
    NSDictionary *json = @{@"ndbno":@"bcd567"};
    Food *food = [[Food alloc] initWithJson:json];
    
    XCTAssert([food.getNdbno isEqualToString:@"bcd567"]);
    XCTAssert(food.getName == nil);
    XCTAssert(food.getFoodGroup == nil);
    XCTAssert(food.getNutrients == nil);
}

#pragma mark - test multiple init
- (void)testMultipleFood_nilJson {
    NSArray *json = nil;
    NSArray *results = [[Food alloc] parseMultipleWithJson:json];
    
    XCTAssert(results == nil);
}

- (void)testMultipleFood_emptyJson {
    NSArray *json = @[@{}, @{}];
    NSArray *results = [[Food alloc] parseMultipleWithJson:json];
    
    XCTAssert(results == nil);
}

- (void)testMultipleFood_partialEmptyJson {
    NSArray *json = @[@{}, @{@"ndbno":@"abc"}];
    NSArray *results = [[Food alloc] parseMultipleWithJson:json];
    
    XCTAssert([results count] == 1);
    XCTAssert([[(Food*)results[0] getNdbno] isEqualToString:@"abc"]);
}

- (void)testMultipleFood_invalidJson {
    NSArray *json = @[@{@"testingString" : @"is not a valid key"}];
    NSArray *results = [[Food alloc] parseMultipleWithJson:json];
    
    XCTAssert(results == nil);
}

- (void)testMultipleFood_partialInvalidJson {
    NSArray *json = @[@{@"ndbno":@"a1b2c3"},@{@"testingString" : @"is not a valid key"}];
    NSArray *results = [[Food alloc] parseMultipleWithJson:json];
    
    XCTAssert([results count] == 1);
    XCTAssert([[(Food*)results[0] getNdbno] isEqualToString:@"a1b2c3"]);

}

@end
