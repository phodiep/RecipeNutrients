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

@interface RecipesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) RecipesListView *recipesView;
@property (strong, nonatomic) NSMutableArray *recipes;

@property (strong, nonatomic) NSDictionary *views;

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
    [self loadDataSource];
    [self setupTitleBar];

}

#pragma mark - Setup methods
-(void)setupDataSourceAndDelegate {
    self.recipesView.tableView.dataSource = self;
    self.recipesView.tableView.delegate = self;
}

-(void)loadDataSource {
    self.recipes = [[NSMutableArray alloc] initWithArray:@[@"Banana bread", @"Ice cream cake", @"Flan"]];
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



#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.recipes count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    cell.textLabel.text = self.recipes[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
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
        [self.recipesView.tableView reloadData];
    }
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
    //TODO: prompt user for details with new view
    
//    [self.recipes insertObject:@"new recipe! :)" atIndex:0];
//    
//    [self.recipesView.tableView reloadData];
    RecipeViewController *recipeVC = [[RecipeViewController alloc] init];
    [self presentViewController:recipeVC animated:true completion:nil];
    
}

@end
