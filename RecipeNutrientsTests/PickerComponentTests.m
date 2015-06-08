//
//  PickerComponentTests.m
//  RecipeNutrients
//
//  Created by Pho Diep on 6/8/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "PickerComponent.h"

@interface PickerComponentTests : XCTestCase

@property (strong, nonatomic) PickerComponent *stringComponent;
@property (strong, nonatomic) PickerComponent *labelValueComponent;

@property (strong, nonatomic) NSArray *stringSample;
@property (strong, nonatomic) NSArray *valueSample;

@end

@implementation PickerComponentTests

- (void)setUp {
    [super setUp];

    self.stringSample = @[@"a", @"b", @"c"];
    self.valueSample = @[@1,@2,@0];
    
    self.stringComponent = [[PickerComponent alloc] initWithArray:self.stringSample];
    self.labelValueComponent = [[PickerComponent alloc] initWithLabelArray:self.stringSample andValueArray:self.valueSample];
    
}

- (void)tearDown {

    [super tearDown];
}

#pragma mark - init's
- (void)testInitWithArray {

    PickerComponent *pickerComponent = [[PickerComponent alloc] initWithArray:self.stringSample];
    
    XCTAssert(pickerComponent != nil);
}

-(void)testInitWithLabelArrayAndValueArray {
    PickerComponent *pickerComponent = [[PickerComponent alloc] initWithLabelArray:self.stringSample andValueArray:self.valueSample];
    
    XCTAssert(pickerComponent != nil);
}

-(void)testInitWithArray_nilArray {
    NSArray *sampleArray = nil;
    PickerComponent *pickerComponent = [[PickerComponent alloc] initWithArray:sampleArray];
    
    XCTAssert(pickerComponent == nil);
}

-(void)testInitWithArray_emptyArray {
    NSArray *sampleArray = @[];
    PickerComponent *pickerComponent = [[PickerComponent alloc] initWithArray:sampleArray];
    
    XCTAssert(pickerComponent == nil);
}

-(void)testInitWithLabelArrayAndValueArray_nilArray_nilArray {
    NSArray *sampleArray1 = nil;
    NSArray *sampleArray2 = nil;
    PickerComponent *pickerComponent = [[PickerComponent alloc] initWithLabelArray:sampleArray1 andValueArray:sampleArray2];
    
    XCTAssert(pickerComponent == nil);
}

-(void)testInitWithLabelArrayAndValueArray_emptyArray_emptyArray {
    NSArray *sampleArray1 = @[];
    NSArray *sampleArray2 = @[];
    PickerComponent *pickerComponent = [[PickerComponent alloc] initWithLabelArray:sampleArray1 andValueArray:sampleArray2];
    
    XCTAssert(pickerComponent == nil);
}

-(void)testInitWithLabelArrayAndValueArray_nilArray_emptyArray {
    NSArray *sampleArray1 = nil;
    NSArray *sampleArray2 = @[];
    PickerComponent *pickerComponent = [[PickerComponent alloc] initWithLabelArray:sampleArray1 andValueArray:sampleArray2];
    
    XCTAssert(pickerComponent == nil);
}

-(void)testInitWithLabelArrayAndValueArray_emptyArray_nilArray {
    NSArray *sampleArray1 = @[];
    NSArray *sampleArray2 = nil;
    PickerComponent *pickerComponent = [[PickerComponent alloc] initWithLabelArray:sampleArray1 andValueArray:sampleArray2];
    
    XCTAssert(pickerComponent == nil);
}

-(void)testInitWithLabelArrayAndValueArray_unbalancedArrays {
    NSArray *sampleArray1 = @[@"a", @"b"];
    NSArray *sampleArray2 = @[@"c", @"d", @"e"];
    PickerComponent *pickerComponent = [[PickerComponent alloc] initWithLabelArray:sampleArray1 andValueArray:sampleArray2];
    
    XCTAssert(pickerComponent == nil);
}



#pragma mark - allLabels method
-(void)testAllLabels_stringComponent {
    NSArray *labels = self.stringComponent.allLabels;
    XCTAssert([labels count] ==3);
    XCTAssert([labels[0] isEqualToString:@"a"]);
    XCTAssert([labels[1] isEqualToString:@"b"]);
    XCTAssert([labels[2] isEqualToString:@"c"]);
}

-(void)testAllLabels_labelValueComponent {
    NSArray *labels = self.labelValueComponent.allLabels;
    XCTAssert([labels count] ==3);
    XCTAssert([labels[0] isEqualToString:@"a"]);
    XCTAssert([labels[1] isEqualToString:@"b"]);
    XCTAssert([labels[2] isEqualToString:@"c"]);
}

#pragma mark - allValues method
-(void)testAllValues_stringComponent {
    NSArray *values = self.stringComponent.allValues;
    XCTAssert([values count] == 3);
    XCTAssert([values[0] isEqualToString:@"a"]);
    XCTAssert([values[1] isEqualToString:@"b"]);
    XCTAssert([values[2] isEqualToString:@"c"]);
}

-(void)testAllValues_labelValueComponent {
    NSArray *values = self.labelValueComponent.allValues;
    XCTAssert([values count] == 3);
    XCTAssert([values[0] isEqualToValue: @1]);
    XCTAssert([values[1] isEqualToValue: @2]);
    XCTAssert([values[2] isEqualToValue: @0]);
}

#pragma mark - numberOfRows
-(void)testNumberOfRows {
    XCTAssert(self.stringComponent.numberOfRows == 3);
    XCTAssert(self.labelValueComponent.numberOfRows == 3);
}

#pragma mark - titleForRow
-(void)testTitleForRow {
    XCTAssert([[self.stringComponent titleForRow:1] isEqualToString: @"b"]);
    XCTAssert([[self.labelValueComponent titleForRow:2] isEqualToString:@"c"]);
}

#pragma mark - valueIsEqualToZeroForRow
-(void)testValueIsEqualToZeroForRow {
    XCTAssertFalse([self.stringComponent valueIsEqualToZeroForRow:0]);
    XCTAssertFalse([self.labelValueComponent valueIsEqualToZeroForRow:1]);
    
    XCTAssert([self.labelValueComponent valueIsEqualToZeroForRow:2]);
}

#pragma mark - floatValueForRow
-(void)testFloatValueForRow {
    //float value of string = 0
    XCTAssert(fabsf([self.stringComponent floatValueForRow:0]) - fabsf((float)0.0) < 0.00001);
    
    XCTAssert(fabsf([self.labelValueComponent floatValueForRow:2]) - fabsf((float)2.0) < 0.00001);

    
}

@end
