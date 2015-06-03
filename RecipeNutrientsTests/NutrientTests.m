//
//  NutrientTests.m
//  RecipeNutrients
//
//  Created by Pho Diep on 6/3/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Nutrient.h"

@interface NutrientTests : XCTestCase

@property (strong, nonatomic) Nutrient *nutrient;

@end

@implementation NutrientTests

- (void)setUp {
    [super setUp];
    
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"nutrientSample" ofType:@"json"];
    NSString *fileContents = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSData *data = [fileContents dataUsingEncoding:NSUTF8StringEncoding];
    NSObject *results = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
    NSDictionary *result = (NSDictionary*) results;

    self.nutrient = [[Nutrient alloc] initWithJson:result];
}

- (void)tearDown {

    [super tearDown];
}

- (void)testNutrient {
    NSString *nutrient_id = @"269";
    NSString *name = @"Sugars, total";
    NSString *unit = @"g";
    NSString *value = @"0.37";
    NSString *gm = @"0.28";

    XCTAssert([self.nutrient.getNutrientId isEqualToString:nutrient_id]);
    XCTAssert([self.nutrient.getName isEqualToString:name]);
    XCTAssert([self.nutrient.getUnit isEqualToString:unit]);
    XCTAssert([self.nutrient.getValue isEqualToString:value]);
    XCTAssert([self.nutrient.get100GramEquivalentValue isEqualToString:gm]);
}


@end
