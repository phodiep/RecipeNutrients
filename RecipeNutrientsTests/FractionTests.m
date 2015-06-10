//
//  FractionTests.m
//  RecipeNutrients
//
//  Created by Pho Diep on 6/9/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Fraction.h"

@interface FractionTests : XCTestCase

@property (strong, nonatomic) Fraction *fraction;

@end

@implementation FractionTests

- (void)setUp {
    [super setUp];
    self.fraction = [[Fraction alloc] initValue:0.5 withUnicode:0x00bd];
    XCTAssert(self.fraction != nil);

}

- (void)tearDown {
    
    [super tearDown];
}

#pragma mark - init
- (void)testInit {
    Fraction *fraction = [[Fraction alloc] initValue:0.5 withUnicode:0x00bd];
    XCTAssert(fraction != nil);
}

#pragma mark - get
-(void)testGetValue {
    XCTAssert(self.fraction.getValue > 0);
}

-(void)testGetUnicode {
    XCTAssert(self.fraction.getUnicode == 0x00bd);
}

-(void)testGetString {
    XCTAssert([self.fraction.getString isEqualToString:@"½"]);
    XCTAssertFalse([self.fraction.getString isEqualToString:@"aaa"]);
}

#pragma mark - isEqualTo
-(void)testIsEqualTo {
    XCTAssert([self.fraction isEqualTo:0.5]);
    XCTAssertFalse([self.fraction isEqualTo:0.75]);
}

#pragma mark - full set
-(void)testFetchFullSetOfFractionsEight {
    NSArray *fractions = [Fraction fetchFullSetOfFractionsEighth];
    XCTAssert([fractions count] == 7);
    XCTAssert([fractions[0] isEqualTo:0.125]);
    XCTAssert([fractions[6] isEqualTo:0.875]);
}

-(void)testFetchFullSetOfFractionsEightWithZero {
    NSArray *fractions = [Fraction fetchFullSetOfFractionsEighthWithZero];
    XCTAssert([fractions count] == 8);
    XCTAssert([fractions[0] isEqualTo:0.0]);
    XCTAssert([fractions[6] isEqualTo:0.75]);
}


@end
