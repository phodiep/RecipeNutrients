//
//  RecipeViewController.m
//  RecipeNutrients
//
//  Created by Pho Diep on 6/9/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "RecipeViewController.h"
#import "RecipeView.h"
#import "ServingsCell.h"
#import "IngredientCell.h"
#import "RecipeIngredient.h"
#import "Fraction.h"
#import "UsdaClient.h"
#import "Food.h"

@interface RecipeViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) RecipeView *recipeView;

@property (strong, nonatomic) NSString *name;
@property (nonatomic) NSInteger servings;
@property (strong, nonatomic) NSString *servingUnits;
@property (strong, nonatomic) NSMutableArray *ingredients;


@end

@implementation RecipeViewController

#pragma mark - UIViewController Lifecycle
-(void)loadView {
    self.recipeView = [[NSBundle mainBundle] loadNibNamed:@"RecipeView" owner:self options:nil][0];
    self.recipeView.frame = [UIScreen mainScreen].applicationFrame;
    self.view = self.recipeView;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerNibForTableViewCell];
    [self setupDataSourceAndDelegates];
    [self setupTitleBarItems];
    
    
}

#pragma mark - setup methods
-(void)registerNibForTableViewCell {
    UINib *servingsNib = [UINib nibWithNibName:@"ServingsCell" bundle:nil];
    [self.recipeView.tableView registerNib:servingsNib forCellReuseIdentifier:@"SERVINGS_CELL"];

    UINib *nib = [UINib nibWithNibName:@"IngredientCell" bundle:nil];
    [self.recipeView.tableView registerNib:nib forCellReuseIdentifier:@"INGREDIENT_CELL"];
}

-(void)setupDataSourceAndDelegates {
    self.recipeView.tableView.dataSource = self;
    self.recipeView.tableView.delegate = self;

    self.name = self.recipe.getName;
    self.servings = self.recipe.getServings;
    self.servingUnits = self.recipe.getServingUnits;
    self.ingredients = [[NSMutableArray alloc] initWithArray:self.recipe.getIngredients];

}

-(void)setupTitleBarItems {
    self.recipeView.titleBar.title = self.name;
    self.recipeView.titleBar.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editRecipeNameButtonPressed)];
    self.recipeView.titleBar.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addIngredientButtonPressed)];
}


#pragma mark - UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return [self.ingredients count];
            break;
        case 2:
            return 3;
        default:
            break;
    }
    return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Servings in Recipe";
            break;
        case 1:
            return @"Ingredients";
            break;
        case 2:
            return @"Options";
            break;
        default:
            break;
    }
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return [self servingCell:indexPath];
            break;
        case 1:
            return [self ingredientCell:indexPath];
            break;
        case 2:
            return [self recipeCell:indexPath];
            break;
        default:
            break;
    }
    return nil;
}

-(UITableViewCell*)servingCell:(NSIndexPath*)indexPath {
    ServingsCell *cell = (ServingsCell*)[self.recipeView.tableView dequeueReusableCellWithIdentifier:@"SERVINGS_CELL" forIndexPath:indexPath];
    
    cell.amountLabel.text = [NSString stringWithFormat:@"%ld", (long)self.servings];
    cell.servingSize.text = self.servingUnits;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(UITableViewCell*)ingredientCell:(NSIndexPath*)indexPath {
    IngredientCell *cell = (IngredientCell*)[self.recipeView.tableView dequeueReusableCellWithIdentifier:@"INGREDIENT_CELL" forIndexPath:indexPath];
    
    RecipeIngredient *ingredient = self.ingredients[indexPath.row];
    cell.amountLabel.text = [NSString stringWithFormat:@"%0.2f %@", ingredient.getAmount, ingredient.getUnit];
    cell.ingredientLabel.text = ingredient.getIngredient.getName;
    
    return cell;
}

-(UITableViewCell*)recipeCell:(NSIndexPath*)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Save changes";
            cell.backgroundColor = [UIColor greenColor];
            break;
        case 1:
            cell.textLabel.text = @"Close, do no save changes";
            cell.backgroundColor = [UIColor lightGrayColor];
            break;
        case 2:
            cell.textLabel.text = @"Delete Recipe";
            cell.backgroundColor = [UIColor redColor];
            break;
        default:
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [self editServingSizeButtonPressed];
    }
    
    if (indexPath.section == 2) {
        [self recipeOptionsDidSelectRow:indexPath];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

-(void)recipeOptionsDidSelectRow:(NSIndexPath*)indexPath {
    switch (indexPath.row) {
        case 0:
            [self saveChangesToRecipe];
            break;
        case 1:
            [self closeButDoNotSaveChangesToRecipe];
            break;
        case 2:
            [self deleteRecipe];
            break;
        default:
            break;
    }
}


#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 0) {
        switch (buttonIndex) {
            case 1:
                if ([[alertView textFieldAtIndex:0].text isEqualToString:@""]) {
                    [self showErrorInvalidRecipeNameEntered];
                    break;
                }
                [self.recipe updateName:[alertView textFieldAtIndex:0].text];
                self.recipeView.titleBar.title = self.name;
                break;
            default:
                break;
        }
    }
    
    if (alertView.tag == 1) {
        [self editRecipeNameButtonPressed];
    }
    
    if (alertView.tag == 2) {
        switch (buttonIndex) {
            case 1:
                self.servings = [[alertView textFieldAtIndex:0].text integerValue];
                self.servingUnits = [alertView textFieldAtIndex:1].text;
                [self.recipeView.tableView reloadData];
                break;
                
            default:
                break;
        }
    }
}

-(void)showErrorInvalidRecipeNameEntered {
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Recipes require a name" message:@"Enter a name to continue" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    errorAlert.tag = 1;
    
    [errorAlert show];
}

#pragma mark - Button Actions
-(void)editRecipeNameButtonPressed {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Edit Recipe Details" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save", nil];
    
    alertView.tag = 0;
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView textFieldAtIndex:0].text = self.name;
    
    [alertView show];
}

-(void)addIngredientButtonPressed {
    Food *food = [[UsdaClient sharedService] fetchFoodReport:@"01009"];
    RecipeIngredient *ingredient = [[RecipeIngredient alloc] init:food withAmount:1.0 withUnit:@"cup, shredded"];
    
    if (ingredient != nil) {
        [self.ingredients addObject:ingredient];
        [self.recipeView.tableView reloadData];
    }
}

-(void)editServingSizeButtonPressed {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Edit Servings Per Recipe" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save", nil];
    
    alertView.tag = 2;
    alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [alertView textFieldAtIndex:0].placeholder = @"Number of Servings (ex. 8)";
    [alertView textFieldAtIndex:0].keyboardType = UIKeyboardTypeDecimalPad;
    [alertView textFieldAtIndex:0].text = [NSString stringWithFormat:@"%ld", (long)self.servings];
    [alertView textFieldAtIndex:1].placeholder = @"Servings Units (ex. slices)";
    [alertView textFieldAtIndex:1].secureTextEntry = NO;
    [alertView textFieldAtIndex:1].text = self.servingUnits;
    
    [alertView show];
}

-(void)saveChangesToRecipe {
    [self.recipe updateName:self.name];
    [self.recipe updateServings:self.servings];
    [self.recipe updateServingUnits:self.servingUnits];
    [self.recipe updateIngredients:self.ingredients];
    
    [self dismissViewControllerAnimated:true completion:^{
        //
    }];
}

-(void)closeButDoNotSaveChangesToRecipe {
    [self dismissViewControllerAnimated:true completion:^{
        //
    }];
}

-(void)deleteRecipe {
    [self dismissViewControllerAnimated:true completion:^{
        //
    }];
}


@end
