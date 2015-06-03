//
//  UsdaClientTest.m
//  RecipeNutrients
//
//  Created by Pho Diep on 5/21/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "UsdaClient.h"
#import "Food.h"
#import "FoodListItem.h"

@interface UsdaClientTest : XCTestCase

@property (strong, nonatomic) UsdaClient *instance;

@end

@implementation UsdaClientTest

- (void)setUp {
    [super setUp];

    self.instance = [UsdaClient sharedService];
}

- (void)tearDown {
    [super tearDown];
}

#pragma mark - testFetchFoodReport
- (void)testFetchFoodReport {
    NSString *ndbno = @"01009";
    Food *food = [self.instance fetchFoodReport:ndbno];
    
    XCTAssert([food.getName isEqualToString:@"Cheese, cheddar"],@"Food name doesn't match");
    XCTAssert([food.getNdbno isEqualToString:@"01009"], @"Food ndbno doesn't match");
}

- (void)testFetchFoodReport_nilParam {
    Food *food = [self.instance fetchFoodReport:nil];
    XCTAssert(food == nil, @"Food ndbno is required");
}

- (void)testFetchFoodReport_badParam {
    NSString *ndbno = @"some random string";
    Food *food = [self.instance fetchFoodReport:ndbno];
    XCTAssert(food == nil, @"'some random string' should not be a valid ndbno");
}


#pragma mark - testFetchFoodList
- (void)testFetchFoodList_food {
    ListType foodType = f;
    NSString *offset = @"0";
    NSString *maxResults = @"50";
    
    NSArray *foodList = [self.instance fetchFoodList:&foodType
                                          maxResults:maxResults
                                       offsetResults:offset];
    FoodListItem *firstItem = (FoodListItem*)foodList[0];
    
    XCTAssert([foodList count] == maxResults.intValue);
    XCTAssert([firstItem.getName isEqualToString:@"Abiyuch, raw"]);
}

- (void)testFetchFoodList_food_noMaxNoOffset {
    ListType foodType = f;
    
    NSArray *foodList = [self.instance fetchFoodList:&foodType];
    FoodListItem *firstItem = (FoodListItem*)foodList[0];

    XCTAssert([foodList count] > 10);
    XCTAssert([firstItem.getName isEqualToString:@"Abiyuch, raw"]);
}

- (void)testFetchFoodList_food_offset {
    ListType foodType = f;
    NSString *offset = @"2";
    
    NSArray *foodList = [self.instance fetchFoodList:&foodType
                                       offsetResults:offset];
    FoodListItem *firstItem = (FoodListItem*)foodList[0];
    
    XCTAssert([foodList count] > 10);
    XCTAssert([firstItem.getName isEqualToString:@"Acerola, (west indian cherry), raw"]);
}


- (void)testFetchFoodList_food_max {
    ListType foodType = f;
    NSString *maxResults = @"25";
    
    NSArray *foodList = [self.instance fetchFoodList:&foodType
                                          maxResults:maxResults];
    FoodListItem *firstItem = (FoodListItem*)foodList[0];
    
    XCTAssert([foodList count] == maxResults.intValue);
    XCTAssert([firstItem.getName isEqualToString:@"Abiyuch, raw"]);
}

- (void)testFetchFoodList_nutrient {
    ListType foodType = n;
    NSString *offset = @"0";
    
    NSArray *foodList = [self.instance fetchFoodList:&foodType
                                       offsetResults:offset];
    FoodListItem *firstItem = (FoodListItem*)foodList[0];
    
    XCTAssert([firstItem.getName isEqualToString:@"(+)-Catechin"]);
}

- (void)testFetchFoodList_nil {
    NSString *offset = @"0";
    NSArray *foodList = [self.instance fetchFoodList:nil
                                       offsetResults:offset];
    XCTAssert(foodList == nil);
}

#pragma mark - testSearchForFood
- (void)testSearch {
    NSString *searchQuery = @"carrots";
    NSString *foodGroup = @"0300";
    NSString *maxResults = @"100";
    NSString *offset = @"1";
    NSArray *searchResults = [self.instance searchForFood:searchQuery
                                                foodGroup:foodGroup
                                               maxResults:maxResults
                                            offsetResults:offset
                                            getAllResults:true];
    XCTAssert([searchResults count] > 0);
}

- (void)testSearch_noFoodGroup {
    NSString *searchQuery = @"carrots";
    NSString *foodGroup = @"";
    NSArray *searchResults = [self.instance searchForFood:searchQuery
                                                foodGroup:foodGroup
                                            getAllResults:true];
    XCTAssert([searchResults count] > 0);
}

- (void)testSearch_noQueryString {
    NSString *searchQuery = @"";
    NSArray *searchResults = [self.instance searchForFood:searchQuery
                                            getAllResults:true];

    XCTAssert([searchResults count] > 4000);
}

- (void)testSearch_noQueryString_notAll {
    NSString *searchQuery = @"";
    NSArray *searchResults = [self.instance searchForFood:searchQuery
                                            getAllResults:false];
    
    XCTAssert([searchResults count] == 1500);
}

- (void)testSearch_invalidFoodGroup {
    NSString *searchQuery = @"carrots";
    NSString *foodGroup = @"asdf";
    NSArray *searchResults = [self.instance searchForFood:searchQuery
                                                foodGroup:foodGroup
                                            getAllResults:true];
    XCTAssert([searchResults count] == 0);
}

- (void)testSearch_invalidMaxResults {
    NSString *searchQuery = @"carrots";
    NSString *foodGroup = @"0300";
    NSString *maxResults = @"asdf";
    NSString *offset = @"1";
    NSArray *searchResults = [self.instance searchForFood:searchQuery
                                                foodGroup:foodGroup
                                               maxResults:maxResults
                                            offsetResults:offset
                                            getAllResults:true];
    XCTAssert([searchResults count] == 0);
}

- (void)testSearch_invalidOffset {
    NSString *searchQuery = @"carrots";
    NSString *foodGroup = @"0300";
    NSString *maxResults = @"100";
    NSString *offset = @"asdf";
    NSArray *searchResults = [self.instance searchForFood:searchQuery
                                                foodGroup:foodGroup
                                               maxResults:maxResults
                                            offsetResults:offset
                                            getAllResults:true];
    XCTAssert([searchResults count] == 0);
}

@end
