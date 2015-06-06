//
//  FoodDetailsView.h
//  RecipeNutrients
//
//  Created by Pho Diep on 6/4/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodDetailsView : UIView

@property (strong, nonatomic) IBOutlet UILabel *TitleLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIButton *measurementButton;
@property (strong, nonatomic) IBOutlet UIPickerView *measurementPicker;
@property (strong, nonatomic) IBOutlet UIView *pickerSubview;
@property (strong, nonatomic) IBOutlet UIButton *pickerSubviewDoneButton;

-(void)hidePickerSubView;
-(void)showPickerSubView;

@end
