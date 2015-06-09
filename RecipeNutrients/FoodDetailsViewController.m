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
#import "PickerComponent.h"

#import "NutritionCell.h"

@interface FoodDetailsViewController () <UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) FoodDetailsView *detailView;

@property (strong, nonatomic) NSMutableDictionary *nutrientsSortedByGroups;
@property (strong, nonatomic) NSMutableArray *nutrientGroups;

@property (strong, nonatomic) NSMutableArray *measurementOptions;
@property (strong, nonatomic) NSString *selectedMeasurement;

@property (strong, nonatomic) NSArray *wholeOptions;
@property (strong, nonatomic) NSArray *fractionOptions;
@property (strong, nonatomic) NSArray *fractionOptionLabels;

@property (nonatomic) float pickerMultiplier;
@property (nonatomic) float pickerMultiplierWhole;
@property (nonatomic) float pickerMultiplierFraction;

@property (strong, nonatomic) NSArray *pickerComponents;

@end

@implementation FoodDetailsViewController

#pragma mark - UIViewController Lifecycle
-(void)loadView {
    
    self.detailView = [[NSBundle mainBundle] loadNibNamed:@"FoodDetailsView" owner:self options:nil][0];
    self.detailView.frame = [UIScreen mainScreen].applicationFrame;
    
    self.view = self.detailView;
    
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    //UI
    [self registerNibForTableViewCell];
    [self setupDataSourceAndDelegates];
    [self setupTitleBarItems];

    //Data
    [self sortNutrientsByGroups];
    [self setupMeasurementOptions];
    
    //Set startup defaults
    [self setMeasurementPickerDefaults];
    [self updateMultiplierAndReloadTable];
    [self updateTitleWithMeasurement];
    
}

#pragma mark - Setup methods
-(void)setupDataSourceAndDelegates {
    self.detailView.measurementPicker.dataSource = self;
    self.detailView.measurementPicker.delegate = self;

    self.detailView.tableView.dataSource = self;
    self.detailView.tableView.delegate = self;
    self.detailView.tableView.allowsSelection = NO;
}

-(void)registerNibForTableViewCell {
    UINib *nib = [UINib nibWithNibName:@"NutritionCell" bundle:nil];
    [self.detailView.tableView registerNib:nib forCellReuseIdentifier:@"NUTRITION_CELL"];
}

-(void)setupTitleBarItems {
    self.detailView.titleBar.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"left216"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed)];
    self.detailView.titleBar.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"measure37"] style:UIBarButtonItemStylePlain target:self action:@selector(measurementButtonPressed)];
}

-(void)setMeasurementPickerDefaults {
    self.detailView.measurementPicker.layer.borderColor = [UIColor blackColor].CGColor;
    self.detailView.measurementPicker.layer.borderWidth = 1;
    
    [self.detailView.measurementPicker selectRow:1 inComponent:0 animated:false];
    
    self.pickerMultiplierWhole = [self.wholeOptions[1] floatValue];
    self.pickerMultiplierFraction = [self.fractionOptions[0] floatValue];

}

-(void)setupMeasurementOptions {
    NSArray *keys = [self.food.getNutrients allKeys];
    self.measurementOptions = [[NSMutableArray alloc] initWithArray:[self.food.getNutrients[keys[0]] getMeasurementOptions]];
    [self.measurementOptions sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    self.selectedMeasurement = self.measurementOptions[0];
    
    self.wholeOptions = @[@0,@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,
                        @11,@12,@13,@14,@15,@16,@17,@18,@19,@20,
                        @21,@22,@23,@24,@25,@26,@27,@28,@29,@30,
                        @31,@32,@33,@34,@35,@36,@37,@38,@39,@40,
                        @41,@42,@43,@44,@45,@46,@47,@48,@49,@50,
                        @51,@52,@53,@54,@55,@56,@57,@58,@59,@60];
    
    self.fractionOptions = @[@0, @0.125, @0.25, @0.375, @0.5, @0.625, @0.75, @0.875];
    self.fractionOptionLabels = @[@"0", @"1/8", @"1/4", @"3/8", @"1/2", @"5/8", @"3/4", @"7/8"];
    
    self.pickerComponents = @[[[PickerComponent alloc] initWithArray:self.wholeOptions],
                              [[PickerComponent alloc] initWithLabelArray:self.fractionOptionLabels andValueArray:self.fractionOptions],
                              [[PickerComponent alloc] initWithArray:self.measurementOptions]];
    
}

#pragma mark - UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *sectionName = self.nutrientGroups[section];
    return [self.nutrientsSortedByGroups[sectionName] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.nutrientGroups count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.nutrientGroups[section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NutritionCell *cell = (NutritionCell*)[self.detailView.tableView dequeueReusableCellWithIdentifier:@"NUTRITION_CELL" forIndexPath:indexPath];
 
    NSString *section = self.nutrientGroups[indexPath.section];
    
    Nutrient *nutrient = self.nutrientsSortedByGroups[section][indexPath.row];
    
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
    return [self.pickerComponents count];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.pickerComponents[component] numberOfRows];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.pickerComponents[component] titleForRow:row];
}

#pragma mark - UIPickerViewDelegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    if ([self.pickerComponents[0] valueIsEqualToZeroForRow: [self selectedRowForComponent:0]] &&
        [self.pickerComponents[1] valueIsEqualToZeroForRow: [self selectedRowForComponent:1]]) {
        
        [self.detailView.measurementPicker selectRow:1 inComponent:component animated:true];
    }

    
    self.pickerMultiplierWhole = [self.pickerComponents[0] floatValueForRow: [self selectedRowForComponent:0]];
    self.pickerMultiplierFraction = [self.pickerComponents[1] floatValueForRow: [self selectedRowForComponent:1]];
    self.selectedMeasurement = [self.pickerComponents[2] titleForRow:[self selectedRowForComponent:2]];
    
    [self updateMultiplierAndReloadTable];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {

    switch (component) {
        case 0:
            return (self.view.frame.size.width * 15 ) / 100;
            break;
        case 1:
            return (self.view.frame.size.width * 15 ) / 100;
            break;
        case 2:
            return (self.view.frame.size.width * 65 ) / 100;
            break;
        default:
            break;
    }
    return (self.view.frame.size.width * 33 ) / 100;
}


#pragma mark - Button actions
-(void)backButtonPressed {
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void)measurementButtonPressed {
    [self.detailView showPickerSubView];
}

-(void)cancelPickerPressed {
    [self.detailView hidePickerSubView];
}


-(void)updateMultiplierAndReloadTable {
    self.pickerMultiplier = self.pickerMultiplierWhole + self.pickerMultiplierFraction;
    [self updateTitleWithMeasurement];
    [self.detailView.tableView reloadData];
}

-(NSInteger)selectedRowForComponent:(NSInteger)component {
    return [self.detailView.measurementPicker selectedRowInComponent:component];
}

#pragma mark - misc
-(void)sortNutrientsByGroups {
    NSDictionary *foodNutrients = self.food.getNutrients;
    NSArray *nutrientKeys = [foodNutrients allKeys];
    
    self.nutrientGroups = [[NSMutableArray alloc] init];
    self.nutrientsSortedByGroups = [[NSMutableDictionary alloc] init];
    
    for (NSString *key in nutrientKeys) {
        Nutrient *nutrient = foodNutrients[key];
        NSString *nutrientGroup = nutrient.getGroup;
        
        if (self.nutrientsSortedByGroups[nutrientGroup] == nil) {
            self.nutrientsSortedByGroups[nutrientGroup] = [[NSMutableArray alloc] initWithArray:@[nutrient]];
            [self.nutrientGroups addObject:nutrient.getGroup];
        } else {
            [self.nutrientsSortedByGroups[nutrientGroup] addObject:nutrient];
        }
    }
    [self.nutrientGroups sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];

}

-(void)updateTitleWithMeasurement {
    NSMutableString *currentMeasurement = [[NSMutableString alloc] init];
    
    NSString *wholeString = [NSString stringWithFormat:@"%@", self.wholeOptions[[self.detailView.measurementPicker selectedRowInComponent:0]]];
    NSString *fractionString = [NSString stringWithFormat:@"%@", self.fractionOptionLabels[[self.detailView.measurementPicker selectedRowInComponent:1]]];
    NSString *unitString = [NSString stringWithFormat:@"%@", self.measurementOptions[[self.detailView.measurementPicker selectedRowInComponent:2]]];
    
    if (![wholeString isEqualToString:@"0"]) {
        [currentMeasurement appendString:[NSString stringWithFormat:@"%@ ", wholeString]];
    }
    if (![fractionString isEqualToString:@"0"]) {
        [currentMeasurement appendString:[NSString stringWithFormat:@"%@ ", fractionString]];
    }
    
    [currentMeasurement appendString:unitString];
    
    self.detailView.titleBar.title = currentMeasurement;
}

@end
