//
//  NutritionCell.h
//  RecipeNutrients
//
//  Created by Pho Diep on 6/5/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NutritionCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nutrientLabel;
@property (strong, nonatomic) IBOutlet UILabel *amountLabel;

@end
