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

@interface FoodTests : XCTestCase

@end

@implementation FoodTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testFood {
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"foodSample" ofType:@"json"];
    NSString *fileContents = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSData *data = [fileContents dataUsingEncoding:NSUTF8StringEncoding];
    NSObject *results = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
    NSDictionary *result = (NSDictionary*) results;
    
    NSDictionary *report = (NSDictionary*)result[@"report"];
    
    Food *food = [[Food alloc] initWithJson:(NSDictionary*)report[@"food"]];
    
    XCTAssert([food.getName isEqualToString:@"Cheese, cheddar"]);
    XCTAssert([food.getNdbno isEqualToString:@"01009"]);
    XCTAssert([food.getNutrients count] == 33);
    XCTAssert(food.getFoodGroup == nil);

}



@end
