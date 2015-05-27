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

- (void)testFetchFoodReport {
    NSString *ndbno = @"01009";
    
    Food *food = [self.instance fetchFoodReport:ndbno];
    
    XCTAssert([food.name isEqualToString:@"Cheese, cheddar"],@"Food name doesn't match");
    XCTAssert([food.ndbno isEqualToString:@"01009"], @"Food ndbno doesn't match");
}


- (void)testFetchFoodReport_nilParam {
    Food *food = [self.instance fetchFoodReport:nil];
    XCTAssert(food == nil);
}

- (void)testFetchFoodReport_badParam {
    NSString *ndbno = @"some random string";
    Food *food = [self.instance fetchFoodReport:ndbno];
    XCTAssert(food == nil);
}

- (void)testFetchFoodList_food {
    NSString *foodType = @"f";
    NSString *offset = @"0";
    
    NSArray *foodList = [self.instance fetchFoodList:foodType offsetResults:offset];
    
    FoodListItem *firstItem = (FoodListItem*)foodList[0];
    
    XCTAssert([firstItem.name isEqualToString:@"Abiyuch, raw"]);
}

- (void)testFetchFoodList_nutrient {
    NSString *foodType = @"n";
    NSString *offset = @"0";
    
    NSArray *foodList = [self.instance fetchFoodList:foodType offsetResults:offset];
    
    FoodListItem *firstItem = (FoodListItem*)foodList[0];
    
    XCTAssert([firstItem.name isEqualToString:@"(+)-Catechin"]);
}


@end
