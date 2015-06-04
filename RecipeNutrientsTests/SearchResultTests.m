//
//  SearchResultTests.m
//  RecipeNutrients
//
//  Created by Pho Diep on 6/4/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "SearchResult.h"

@interface SearchResultTests : XCTestCase

@property (strong, nonatomic) SearchResult *searchResult;
@end

@implementation SearchResultTests

- (void)setUp {
    [super setUp];

    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"searchResultSample" ofType:@"json"];
    NSString *fileContents = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSData *data = [fileContents dataUsingEncoding:NSUTF8StringEncoding];
    NSObject *results = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
    NSDictionary *result = (NSDictionary*) results;

    self.searchResult = [[SearchResult alloc] initWithJson:result];
}

- (void)tearDown {
    
    [super tearDown];
}

#pragma mark - test single init
- (void)testSearchResult {
    XCTAssert([self.searchResult.getName isEqualToString:@"Butter, whipped, with salt"]);
    XCTAssert([self.searchResult.getNdbno isEqualToString:@"01002"]);
    XCTAssert([self.searchResult.getGroup isEqualToString:@"Dairy and Egg Products"]);
}

- (void)testSearchResult_nilJson {
    NSDictionary *json = nil;
    SearchResult *result = [[SearchResult alloc] initWithJson:json];
    XCTAssert(result == nil);
}

- (void)testSearchResult_emptyJson {
    NSDictionary *json = @{};
    SearchResult *result = [[SearchResult alloc] initWithJson:json];
    XCTAssert(result == nil);
}

- (void)testSearchResult_invalidJson {
    NSDictionary *json = @{@"abc":@"123"};
    SearchResult *result = [[SearchResult alloc] initWithJson:json];
    XCTAssert(result == nil);
}

- (void)testSearchResult_partialEmptyJson {
    NSDictionary *json = @{@"ndbno":@"abc", @"group":@"groupName"};
    SearchResult *result = [[SearchResult alloc] initWithJson:json];
    XCTAssert(result != nil);
}

#pragma mark - test multiple init
- (void)testMultipleSearchResult_nilJson {
    NSArray *json = nil;
    NSArray *result = [[SearchResult alloc] parseMultipleWithJson:json];
    XCTAssert(result == nil);
}

- (void)testMultipleSearchResult_emptyJson {
    NSArray *json = @[];
    NSArray *result = [[SearchResult alloc] parseMultipleWithJson:json];
    XCTAssert(result == nil);
}

- (void)testMultipleSearchResult_invalidJson {
    NSArray *json = @[@{@"abc":@"aaa"}];
    NSArray *result = [[SearchResult alloc] parseMultipleWithJson:json];
    XCTAssert(result == nil);
}

- (void)testMultipleSearchResult_partialEmptyJson {
    NSArray *json = @[@{@"abc":@"aaa"}, @{@"ndbno":@"validObject", @"group":@"groupName"}];
    NSArray *result = [[SearchResult alloc] parseMultipleWithJson:json];
    XCTAssert([result count] == 1);
}
@end
