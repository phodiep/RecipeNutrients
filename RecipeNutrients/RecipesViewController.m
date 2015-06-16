//
//  RecipesViewController.m
//  RecipeNutrients
//
//  Created by Pho Diep on 5/28/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "RecipesViewController.h"

#import "RecipesListView.h"
#import "RecipeViewController.h"
#import "Recipe.h"
#import "RecipesService.h"

@interface RecipesViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) RecipesListView *recipesView;
@property (strong, nonatomic) NSMutableArray *recipes;

@property (strong, nonatomic) UIAlertView *recipeAlertView;

@end

@implementation RecipesViewController

#pragma mark - UIViewController Lifecycle
-(void)loadView {
    self.recipesView = [[NSBundle mainBundle] loadNibNamed:@"RecipesListView" owner:self options:nil][0];
    self.recipesView.frame = [UIScreen mainScreen].applicationFrame;
    self.view = self.recipesView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDataSourceAndDelegate];
    [self setupTitleBar];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadDataSourceAndReloadTableView];

}

#pragma mark - Setup methods
-(void)setupDataSourceAndDelegate {
    self.recipesView.tableView.dataSource = self;
    self.recipesView.tableView.delegate = self;
}

-(void)loadDataSourceAndReloadTableView {
    self.recipes = [[NSMutableArray alloc] initWithArray:[[RecipesService sharedService] fetchAllRecipes]];
    [self.recipesView.tableView reloadData];
}

-(void)setupTitleBar {
    self.recipesView.titleBar.title = @"Recipe Box";
    [self setupTitleBarItemsForNormalMode];
}

-(void)setupTitleBarItemsForNormalMode {
    self.recipesView.titleBar.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonPressed)];
    self.recipesView.titleBar.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addRecipeButtonPressed)];
}

-(void)setupTitleBarItemsForTableViewEditMode {
    self.recipesView.titleBar.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(editDoneButtonPressed)];
    self.recipesView.titleBar.rightBarButtonItem = nil;
}

-(void)updateRecipesService {
    [[RecipesService sharedService] replaceAllRecipes:self.recipes];
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.recipes count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    Recipe *recipe = (Recipe*)self.recipes[indexPath.row];
    cell.textLabel.text = recipe.getName;
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Recipe *recipe = (Recipe*)self.recipes[indexPath.row];
    [self openRecipe:recipe];
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [self.recipes insertObject: [self.recipes objectAtIndex:sourceIndexPath.row] atIndex:destinationIndexPath.row];
    [self.recipes removeObjectAtIndex:(sourceIndexPath.row + 1)];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.recipesView.tableView.editing) {
        return UITableViewCellEditingStyleDelete;
    }
    
    return UITableViewCellEditingStyleNone;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.recipes removeObjectAtIndex:indexPath.row];
        [self updateRecipesService];
        [self loadDataSourceAndReloadTableView];
    }
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 0) {
        switch (buttonIndex) {
            case 0:  // cancel
                break;
            case 1: // continue
                if ([[alertView textFieldAtIndex:0].text isEqualToString:@""]) {
                    [self showErrorInvalidRecipeNameEntered];
                    break;
                }
                [self createNewRecipeAndOpen:[alertView textFieldAtIndex:0].text];
                break;
            default:
                break;
        }
    }
    
    if (alertView.tag == 1) {
        if (buttonIndex == 0) {
            [self.recipeAlertView show];
        }
    }
}

-(void)showErrorInvalidRecipeNameEntered {
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Recipes require a name" message:@"Enter a name to continue" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    errorAlert.tag = 1;
    
    [errorAlert show];
}

#pragma mark - Button Actions
-(void)editButtonPressed {
    self.recipesView.tableView.editing = true;
    [self setupTitleBarItemsForTableViewEditMode];
}

-(void)editDoneButtonPressed {
    self.recipesView.tableView.editing = false;
    [self setupTitleBarItemsForNormalMode];
}

-(void)addRecipeButtonPressed {
    self.recipeAlertView = [[UIAlertView alloc] initWithTitle:@"Create New Recipe" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", nil];
    self.recipeAlertView.tag = 0;
    self.recipeAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [self.recipeAlertView textFieldAtIndex:0].placeholder = @"Recipe Name (ex. Mom's Famous Banana Bread)";
    
    [self.recipeAlertView show];
    
    
}

-(void)createNewRecipeAndOpen:(NSString*)name {
    Recipe *recipe = [[Recipe alloc] initWithName:name];
    [self.recipes insertObject:recipe atIndex:0];
    
    [self updateRecipesService];
    
    [self openRecipe:recipe];
    
}

-(void)openRecipe:(Recipe*)recipe {
    RecipeViewController *recipeVC = [[RecipeViewController alloc] init];
    recipeVC.recipe = recipe;
    
    [self presentViewController:recipeVC animated:true completion:nil];
}
@end
