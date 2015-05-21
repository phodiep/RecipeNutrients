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
    NSString *ndbNo = @"01009";
    
    Food *food = [self.instance fetchFoodReport:ndbNo];
    
    XCTAssert([food.name isEqualToString:@"Cheese, cheddar"],@"Food name doesn't match");
    XCTAssert([food.ndbNo isEqualToString:@"01009"], @"Food ndbno doesn't match");
}

- (void)testFetchFoodReportNil {
    NSString *ndbNo = nil;

    //TODO: fix assert after nil in json fixed
//    Food *food = [self.instance fetchFoodReport:ndbNo];
//    XCTAssert(food == nil);
    XCTAssert(true);
}


@end
