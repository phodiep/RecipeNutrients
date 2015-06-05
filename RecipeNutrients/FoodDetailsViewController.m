//
//  FoodDetailsViewController.m
//  RecipeNutrients
//
//  Created by Pho Diep on 6/4/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "FoodDetailsViewController.h"
#import "FoodDetailsView.h"
#import "Nutrient.h"

@interface FoodDetailsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) FoodDetailsView *detailView;

@end

@implementation FoodDetailsViewController

-(void)loadView {
    
    self.detailView = [[NSBundle mainBundle] loadNibNamed:@"FoodDetailsView" owner:self options:nil][0];
    self.detailView.frame = [UIScreen mainScreen].applicationFrame;

    [self.detailView.backButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    self.view = self.detailView;
    
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailView.TitleLabel.text = self.food.getName;
    
    self.detailView.tableView.dataSource = self;
    self.detailView.tableView.delegate = self;

}


#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.food.getNutrients count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    
    NSString *name = [self.food.getNutrients allKeys][indexPath.row];
    Nutrient *nutrient = self.food.getNutrients[name];
    
    cell.textLabel.text = nutrient.getName;
    
    return cell;
}

#pragma mark - UITableViewDelegate


#pragma mark - Button actions
-(void)backButtonPressed {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
