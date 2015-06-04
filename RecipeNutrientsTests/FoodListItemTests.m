//
//  FoodListItemTests.m
//  RecipeNutrients
//
//  Created by Pho Diep on 6/4/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FoodListItem.h"

@interface FoodListItemTests : XCTestCase

@property (strong, nonatomic) FoodListItem *foodListItem;

@end

@implementation FoodListItemTests

- (void)setUp {
    [super setUp];

    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"foodListSample" ofType:@"json"];
    NSString *fileContents = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSData *data = [fileContents dataUsingEncoding:NSUTF8StringEncoding];
    NSObject *results = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
    NSDictionary *result = (NSDictionary*) results;
    
    self.foodListItem = [[FoodListItem alloc] initWithJson:result];
}

- (void)tearDown {

    [super tearDown];
}

#pragma mark - test single init
- (void)testFoodListItem {
    XCTAssert([self.foodListItem.getId isEqualToString:@"35194"]);
    XCTAssert([self.foodListItem.getName isEqualToString:@"Agave, dried (Southwest)"]);
}

- (void)testFoodListItem_nilJson {
    NSDictionary *json = nil;
    FoodListItem *item = [[FoodListItem alloc] initWithJson:json];
    XCTAssert(item == nil);
}

- (void)testFoodListItem_emptyJson {
    NSDictionary *json = @{};
    FoodListItem *item = [[FoodListItem alloc] initWithJson:json];
    XCTAssert(item == nil);
}

- (void)testFoodListItem_invalidJson {
    NSDictionary *json = @{@"testingKey":@"testObject"};
    FoodListItem *item = [[FoodListItem alloc] initWithJson:json];
    XCTAssert(item == nil);
}

- (void)testFoodListItem_partialEmptyJson {
    NSDictionary *json = @{@"id":@"aaa"};
    FoodListItem *item = [[FoodListItem alloc] initWithJson:json];
    XCTAssert(item != nil);
}

- (void)testFoodListItem_partialEmptyJson_noReplacementId {
    NSDictionary *json = @{@"idno":@"aaa"};
    FoodListItem *item = [[FoodListItem alloc] initWithJson:json];
    XCTAssert(item == nil);
}

#pragma mark - test multiple init
- (void)testMultipleFoodListItem_nilJson {
    NSArray *json = nil;
    NSArray *items = [[FoodListItem alloc] parseMultipleWithJson:json];
    XCTAssert(items == nil);
}

- (void)testMultipleFoodListItem_emptyJson {
    NSArray *json = @[];
    NSArray *items = [[FoodListItem alloc] parseMultipleWithJson:json];
    XCTAssert(items == nil);
}

- (void)testMultipleFoodListItem_invalidJson {
    NSArray *json = @[@{@"invalidKey":@"random Object"}, @{}];
    NSArray *items = [[FoodListItem alloc] parseMultipleWithJson:json];
    XCTAssert(items == nil);
}

- (void)testMultipleFoodListItem_partialEmptyJson {
    NSArray *json = @[@{@"id":@"asdf123"}, @{@"idno":@"lkjh987"}];
    NSArray *items = [[FoodListItem alloc] parseMultipleWithJson:json];
    XCTAssert([items count] == 1);
}



@end
