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

@interface FoodDetailsViewController () <UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) FoodDetailsView *detailView;

@property (strong, nonatomic) NSMutableArray *measurementOptions;
@property (strong, nonatomic) NSString *selectedMeasurement;

@property (strong, nonatomic) NSArray *wholeOptions;
@property (strong, nonatomic) NSArray *fractionOptions;
@property (strong, nonatomic) NSArray *fractionOptionLabels;

@property (nonatomic) float pickerMultiplier;
@property (nonatomic) float pickerMultiplierWhole;
@property (nonatomic) float pickerMultiplierFraction;

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
    
//    [self.detailView.measurementButton setTitle:[NSString stringWithFormat:@"Per 1 %@", self.selectedMeasurement] forState:UIControlStateNormal];
    
    self.detailView.measurementPicker.dataSource = self;
    self.detailView.measurementPicker.delegate = self;
    [self.detailView.measurementPicker selectRow:1 inComponent:0 animated:true];
    
    self.pickerMultiplierWhole = [self.wholeOptions[1] floatValue];
    self.pickerMultiplierFraction = [self.fractionOptions[0] floatValue];
    [self updateMultiplierAndReloadTable];
    
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
    
    self.wholeOptions = @[@0,@1,@2,@3,@4,@5,@6,@7,@8,@9,@10];
    self.fractionOptions = @[@0, @0.125, @0.25, @0.375, @0.5, @0.625, @0.75, @0.875];
    self.fractionOptionLabels = @[@"0", @"1/8", @"1/4", @"3/8", @"1/2", @"5/8", @"3/4", @"7/8"];
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
    float value = measure.getValue * self.pickerMultiplier;
    NSString *units = nutrient.getUnit;
    cell.amountLabel.text = [NSString stringWithFormat:@"%.01f %@", value, units];
    
    return cell;
}

#pragma mark - UITableViewDelegate


#pragma mark - UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return 11; //0-10
            break;
        case 1:
            return 8; //0, 1/8, 1/4, 3/8, 1/2, 5/8, 3/4, 7/8
            break;
            
        case 2:
            return [self.measurementOptions count];
            break;
        default:
            break;
    }
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return [NSString stringWithFormat:@"%@", self.wholeOptions[row]];
            break;
        case 1:
            return self.fractionOptionLabels[row];
            break;
        case 2:
            return self.measurementOptions[row];
            break;
        default:
            break;
    }
    return @"";
}

#pragma mark - UIPickerViewDelegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
            
            if (self.pickerMultiplierFraction == 0 && row == 0) {
                [self.detailView.measurementPicker selectRow:1 inComponent:1 animated:true];
                self.pickerMultiplierFraction = [self.fractionOptions[1] floatValue];
            }
            self.pickerMultiplierWhole = [self.wholeOptions[row] floatValue];
            break;
        case 1:
            if (self.pickerMultiplierWhole == 0 && row == 0) {
                [self.detailView.measurementPicker selectRow:1 inComponent:0 animated:true];
                self.pickerMultiplierWhole = [self.wholeOptions[1] floatValue];
            }

            self.pickerMultiplierFraction = [self.fractionOptions[row] floatValue];
            break;
        case 2:
            self.selectedMeasurement = self.measurementOptions[row];
            break;
        default:
            break;
    }
    [self updateMultiplierAndReloadTable];
}


#pragma mark - Button actions
-(void)backButtonPressed {
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void)measurementButtonPressed {
    NSLog(@"%@", self.measurementOptions);
    
}

-(void)updateMultiplierAndReloadTable {
    self.pickerMultiplier = self.pickerMultiplierWhole + self.pickerMultiplierFraction;
    [self.detailView.tableView reloadData];
}

@end
