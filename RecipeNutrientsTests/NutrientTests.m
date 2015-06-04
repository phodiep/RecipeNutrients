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
#import "Measure.h"

@interface NutrientTests : XCTestCase

@property (strong, nonatomic) Nutrient *nutrient;

@end

@implementation NutrientTests

- (void)setUp {
    [super setUp];
    
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"nutrientSampleFoodReport" ofType:@"json"];
    NSString *fileContents = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSData *data = [fileContents dataUsingEncoding:NSUTF8StringEncoding];
    NSObject *results = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
    NSDictionary *result = (NSDictionary*) results;

    self.nutrient = [[Nutrient alloc] initWithJson:result];
}

- (void)tearDown {

    [super tearDown];
}

#pragma mark - test single init
- (void)testNutrient {
    XCTAssert([self.nutrient.getNutrientId isEqualToString:@"208"]);
    XCTAssert([self.nutrient.getName isEqualToString:@"Energy"]);
    XCTAssert([self.nutrient.getGroup isEqualToString:@"Proximates"]);
    XCTAssert([self.nutrient.getUnit isEqualToString:@"kcal"]);
    XCTAssert([self.nutrient.getValue isEqualToString:@"406"]);
    XCTAssert([self.nutrient.getMeasurementOptions count] == 6);
}

- (void)testNutrientMeasurement {
    Measure *measure = (Measure*)self.nutrient.getMeasurements[@"oz"];
    XCTAssert([measure.getEquivalent isEqual: @28.35]);
    XCTAssert([measure.getLabel isEqualToString:@"oz"]);
    XCTAssert(measure.getQuantity == 1.0);
    XCTAssert(measure.getValue == 115);
}

- (void)testNutrient_nilJson {
    NSDictionary *json = nil;
    
    Nutrient *nutrient = [[Nutrient alloc] initWithJson:json];
    
    XCTAssert(nutrient == nil);
}

- (void)testNutrient_emptyJson {
    NSDictionary *json = @{};
    
    Nutrient *nutrient = [[Nutrient alloc] initWithJson:json];
    
    XCTAssert(nutrient == nil);
}

- (void)testNutrient_invalidJson {
    NSDictionary *json = @{@"testingString":@"non-valid object"};
    
    Nutrient *nutrient = [[Nutrient alloc] initWithJson:json];
    
    XCTAssert(nutrient == nil);
}

- (void)testNutrient_partialEmptyJson {
    NSDictionary *json = @{@"nutrient_id":@"asdf"};
    
    Nutrient *nutrient = [[Nutrient alloc] initWithJson:json];
    
    XCTAssert(nutrient != nil);
}

#pragma mark - test multiple init
- (void)testMutlipleNutrient_nilJson {
    NSArray *json = nil;
    
    NSArray *nutrients = [[Nutrient alloc] parseMultipleWithJson:json];
    
    XCTAssert(nutrients == nil);
}

- (void)testMutlipleNutrient_emptyJson {
    NSArray *json = @[];
    
    NSArray *nutrients = [[Nutrient alloc] parseMultipleWithJson:json];
    
    XCTAssert(nutrients == nil);
}

- (void)testMutlipleNutrient_partialEmptyJson {
    NSArray *json = @[@{}, @{@"nutrient_id":@"testing"}, @{}];
    
    NSArray *nutrients = [[Nutrient alloc] parseMultipleWithJson:json];
    
    XCTAssert([nutrients count] == 1);
}

- (void)testMutlipleNutrient_invalidJson {
    NSArray *json = @[@{@"nonvalidKey": @"random object"}];
    
    NSArray *nutrients = [[Nutrient alloc] parseMultipleWithJson:json];
    
    XCTAssert(nutrients == nil);
}

- (void)testMutlipleNutrient_partialInvalidJson {
    NSArray *json = @[@{@"nonvalidKey": @"random object"}, @{@"nutrient_id":@"testing"}, @{}];
    
    NSArray *nutrients = [[Nutrient alloc] parseMultipleWithJson:json];
    
    XCTAssert([nutrients count] == 1);
}
@end
