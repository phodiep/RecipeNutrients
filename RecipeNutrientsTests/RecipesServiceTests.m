//
//  RecipesServiceTests.m
//  RecipeNutrients
//
//  Created by Pho Diep on 6/15/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "RecipesService.h"
#import "Recipe.h"

@interface RecipesServiceTests : XCTestCase

@property (strong, nonatomic) RecipesService *recipesService;
@property (strong, nonatomic) Recipe *randomRecipe;
@property (strong, nonatomic) NSArray *recipes;

@end

@implementation RecipesServiceTests

- (void)setUp {
    [super setUp];
    
    self.recipesService = [RecipesService sharedService_initForTesting];
    self.randomRecipe = [[Recipe alloc] initWithName:@"random recipe"];
    
    self.recipes = @[self.randomRecipe];
}

- (void)tearDown {
    self.recipesService = nil;
    [super tearDown];
}

#pragma mark - sharedService
- (void)testSharedService {
    RecipesService *newService = [RecipesService sharedService];
    
    XCTAssert(newService != nil);
    
    RecipesService *otherService = [RecipesService sharedService];
    XCTAssert(newService == otherService);
}

#pragma mark - countOfRecipes
- (void) testCountOfRecipes {
    XCTAssert([self.recipesService countOfRecipes] == 0);
    
    [self.recipesService addNewRecipe:self.randomRecipe];
    XCTAssert([self.recipesService countOfRecipes] == 1);
}

#pragma mark - fetchAllRecipes
- (void) testFetchAllRecipes {
    XCTAssert([self.recipesService countOfRecipes] == 0);
    [self.recipesService addNewRecipe:self.randomRecipe];
    XCTAssert([self.recipesService countOfRecipes] == 1);
    XCTAssert([self.recipesService fetchAllRecipes][0] == self.randomRecipe);
}

#pragma mark - addNewRecipe
- (void)testAddNewRecipe {
    XCTAssert([self.recipesService countOfRecipes] == 0);
    Recipe *newRecipe = [[Recipe alloc] initWithName:@"new recipe"];
    [self.recipesService addNewRecipe:newRecipe];
    XCTAssert([self.recipesService countOfRecipes] == 1);
    [self.recipesService addNewRecipe:self.randomRecipe];
    XCTAssert([self.recipesService countOfRecipes] == 2);
    
    XCTAssert([self.recipesService fetchAllRecipes][0] == newRecipe);
    XCTAssert([self.recipesService fetchAllRecipes][1] == self.randomRecipe);
}

- (void)testAddNewRecipe_nil {
    [self.recipesService addNewRecipe:nil];
    XCTAssert([self.recipesService countOfRecipes] == 0);
}

- (void)testAddNewRecipe_nonRecipe {
    [self.recipesService addNewRecipe:(Recipe*)@"random"];
    XCTAssert([self.recipesService countOfRecipes] == 0);
}

#pragma mark - addNewRecipes
- (void)testAddNewRecipes {
    XCTAssert([self.recipesService countOfRecipes] == 0);
    [self.recipesService addNewRecipes:self.recipes];
    XCTAssert([self.recipesService countOfRecipes] == 1);
}

- (void)testAddNewRecipes_nil {
    [self.recipesService addNewRecipes:nil];
    XCTAssert([self.recipesService countOfRecipes] == 0);
}

- (void)testAddNewRecipes_empty {
    [self.recipesService addNewRecipes:@[]];
    XCTAssert([self.recipesService countOfRecipes] == 0);
}

- (void)testAddNewRecipes_nonRecipe {
    [self.recipesService addNewRecipes:@[(Recipe*)@"random"]];
    XCTAssert([self.recipesService countOfRecipes] == 0);
}

- (void)testAddNewRecipes_mixOfRecipesAndNonRecipes {
    Recipe *newRecipe = [[Recipe alloc] initWithName:@"new recipe"];
    NSArray *recipesToAdd = @[@"",newRecipe];
    [self.recipesService addNewRecipes:recipesToAdd];
    XCTAssert([self.recipesService countOfRecipes] == 1);
    XCTAssert([[(Recipe*)[self.recipesService fetchAllRecipes][0] getName] isEqualToString:@"new recipe"]);

}

#pragma mark - updateRecipe
- (void)testUpdateRecipe {
    [self.recipesService addNewRecipe:self.randomRecipe];
    XCTAssert([[(Recipe*)[self.recipesService fetchAllRecipes][0] getName] isEqualToString:@"random recipe"]);
    
    [self.randomRecipe updateName:@"new random name"];
    [self.recipesService updateRecipe:self.randomRecipe];
    XCTAssert([[(Recipe*)[self.recipesService fetchAllRecipes][0] getName] isEqualToString:@"new random name"]);
}

- (void)testUpdateRecipe_nil {
    XCTAssertNoThrow([self.recipesService updateRecipe:nil]);
}

- (void)testUpdateRecipe_nonexistentRecipe {
    [self.recipesService addNewRecipe:self.randomRecipe];
    XCTAssert([self.recipesService countOfRecipes] == 1);
    XCTAssert([[(Recipe*)[self.recipesService fetchAllRecipes][0] getName] isEqualToString:@"random recipe"]);
    
    Recipe *newRecipe = [[Recipe alloc] initWithName:@"new"];
    [self.recipesService updateRecipe:newRecipe];
    XCTAssert([self.recipesService countOfRecipes] == 1);
    XCTAssert([[(Recipe*)[self.recipesService fetchAllRecipes][0] getName] isEqualToString:@"random recipe"]);
}

@end
