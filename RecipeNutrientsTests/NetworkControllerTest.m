//
//  NetworkControllerTest.m
//  RecipeNutrients
//
//  Created by Pho Diep on 5/20/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NetworkController.h"
#import "Food.h"

@interface NetworkControllerTest : XCTestCase

@property NetworkController *instance;

@end

@implementation NetworkControllerTest

- (void)setUp {
    [super setUp];

    self.instance = [NetworkController sharedInstance];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testMakeApiGetRequest {
    NSString *endPoint = @"http://api.nal.usda.gov/usda/ndb/reports/";
    NSDictionary *params = @{@"ndbno" : @"01009",
                             @"type" : @"b",
                             @"format" : @"JSON"
                             };
    
    [self.instance makeApiGetRequest:endPoint withParameters:params withCompletionHandler:^(NSObject *results) {
        NSDictionary *result = (NSDictionary*)results;
        NSDictionary *report = (NSDictionary*)result[@"report"];

        Food *food = [[Food alloc] initWithJson:(NSDictionary*)report[@"food"]];
        
        XCTAssert([food.name isEqualToString:@"Cheese, cheddar"],@"Food name doesn't match");
        XCTAssert([food.ndbNo isEqualToString:@"01009"], @"Food ndbno doesn't match");
        
    }];
}


@end
