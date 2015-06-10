//
//  RecipeViewController.m
//  RecipeNutrients
//
//  Created by Pho Diep on 6/9/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "RecipeViewController.h"
#import "RecipeView.h"
#import "IngredientCell.h"
#import "RecipeIngredient.h"
#import "Fraction.h"

@interface RecipeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) RecipeView *recipeView;

@property (strong, nonatomic) NSArray *ingredients;

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
    UINib *nib = [UINib nibWithNibName:@"IngredientCell" bundle:nil];
    [self.recipeView.tableView registerNib:nib forCellReuseIdentifier:@"INGREDIENT_CELL"];
}

-(void)setupDataSourceAndDelegates {
    self.recipeView.tableView.dataSource = self;
    self.recipeView.tableView.delegate = self;
}

-(void)setupTitleBarItems {
    Fraction *fraction = [[Fraction alloc] initValue:0.5 withUnicode:0x215B];
    self.recipeView.titleBar.title = fraction.getString;
    self.recipeView.titleBar.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonPressed)];
    self.recipeView.titleBar.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed)];
}


#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IngredientCell *cell = (IngredientCell*)[self.recipeView.tableView dequeueReusableCellWithIdentifier:@"INGREDIENT_CELL" forIndexPath:indexPath];
    
    RecipeIngredient *ingredient = self.ingredients[indexPath.row];
    cell.amountLabel.text = [NSString stringWithFormat:@"%0.2f %@", ingredient.getAmount, ingredient.getUnit];
    cell.ingredientLabel.text = ingredient.getIngredient.getName;
    
    return cell;
}

#pragma mark - UITableViewDelegate


#pragma mark - Button Actions
-(void)editButtonPressed {

}

-(void)addButtonPressed {
    
}


@end
