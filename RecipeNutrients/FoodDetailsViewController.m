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
#import "Measure.h"

#import "NutritionCell.h"

@interface FoodDetailsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) FoodDetailsView *detailView;

@property (strong, nonatomic) NSMutableArray *measurementOptions;
@property (strong, nonatomic) NSString *selectedMeasurement;

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
    
    [self getMeasurements];
    
    [self.detailView.measurementButton setTitle:[NSString stringWithFormat:@"Per 1 %@", self.selectedMeasurement] forState:UIControlStateNormal];
    
    self.detailView.tableView.dataSource = self;
    self.detailView.tableView.delegate = self;

    UINib *nib = [UINib nibWithNibName:@"NutritionCell" bundle:nil];
    [self.detailView.tableView registerNib:nib forCellReuseIdentifier:@"NUTRITION_CELL"];
    
    [self.detailView.measurementButton addTarget:self action:@selector(measurementButtonPressed) forControlEvents:UIControlEventTouchUpInside];
}

-(void)getMeasurements {
    NSArray *keys = [self.food.getNutrients allKeys];
    self.measurementOptions = [[NSMutableArray alloc] initWithArray:[self.food.getNutrients[keys[0]] getMeasurementOptions]];
    [self.measurementOptions sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    self.selectedMeasurement = self.measurementOptions[0];
}

#pragma mark - UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.food.getNutrients count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NutritionCell *cell = (NutritionCell*)[self.detailView.tableView dequeueReusableCellWithIdentifier:@"NUTRITION_CELL" forIndexPath:indexPath];
    
    NSString *name = [self.food.getNutrients allKeys][indexPath.row];
    Nutrient *nutrient = self.food.getNutrients[name];
    
    cell.nutrientLabel.text = nutrient.getName;

    Measure *measure = (Measure*)nutrient.getMeasurements[self.selectedMeasurement];
    float value = measure.getValue;
    NSString *units = nutrient.getUnit;
    cell.amountLabel.text = [NSString stringWithFormat:@"%.01f %@", value, units];
    
    return cell;
}

#pragma mark - UITableViewDelegate


#pragma mark - Button actions
-(void)backButtonPressed {
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void)measurementButtonPressed {
    NSLog(@"%@", self.measurementOptions);
    
}

@end
