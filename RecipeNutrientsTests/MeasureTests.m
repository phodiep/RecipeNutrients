//
//  MeasureTests.m
//  RecipeNutrients
//
//  Created by Pho Diep on 6/3/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Measure.h"

@interface MeasureTests : XCTestCase

@property (strong, nonatomic) Measure *measure;

@end

@implementation MeasureTests

- (void)setUp {
    [super setUp];

    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"measureSampleFoodReport" ofType:@"json"];
    NSString *fileContents = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSData *data = [fileContents dataUsingEncoding:NSUTF8StringEncoding];
    NSObject *results = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
    NSDictionary *result = (NSDictionary*) results;
    
    self.measure = [[Measure alloc] initWithJson:result];
}

- (void)tearDown {
    [super tearDown];
}

#pragma mark - test single init
- (void)testMeasure {    
    XCTAssert([self.measure.getLabel isEqualToString:@"cup, melted"]);
    XCTAssert([self.measure.getEquivalent isEqual:@244.0]);
    XCTAssert(self.measure.getQuantity == 1.0);
    
    float delta = fabs(self.measure.getValue-58.66);
    XCTAssert(delta < 0.1f);
}

- (void)testMeasure_nilJson {
    NSDictionary *json = nil;
    Measure *measure = [[Measure alloc] initWithJson:json];
    XCTAssert(measure == nil);
}

- (void)testMeasure_emptyJson {
    NSDictionary *json = @{};
    Measure *measure = [[Measure alloc] initWithJson:json];
    XCTAssert(measure == nil);
}

- (void)testMeasure_invalidJson {
    NSDictionary *json = @{@"testingString":@"non-valid object"};
    Measure *measure = [[Measure alloc] initWithJson:json];
    XCTAssert(measure == nil);
}

- (void)testMeasure_partialEmptyJson {
    NSDictionary *json = @{@"label":@"random string"};
    Measure *measure = [[Measure alloc] initWithJson:json];
    XCTAssert(measure != nil);
}

#pragma mark - test multiple init
- (void)testMultipleMeasure_nilJson {
    NSArray *json = nil;
    NSArray *results = [[Measure alloc] parseMultipleWithJson:json];
    XCTAssert(results == nil);
}

- (void)testMultipleMeasure_emptyJson {
    NSArray *json = @[@{}];
    NSArray *results = [[Measure alloc] parseMultipleWithJson:json];
    XCTAssert(results == nil);
}

- (void)testMultipleMeasure_invalidJson {
    NSArray *json = @[@{@"nonvalidKey": @"random object"}, @{}];
    NSArray *results = [[Measure alloc] parseMultipleWithJson:json];
    XCTAssert(results == nil);
}

- (void)testMultipleMeasure_partialEmptyJson {
    NSArray *json = @[@{@"label":@"random string"}, @{}];
    NSArray *results = [[Measure alloc] parseMultipleWithJson:json];
    XCTAssert([results count] == 1);
}

@end
