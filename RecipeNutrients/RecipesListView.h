//
//  RecipesListView.h
//  RecipeNutrients
//
//  Created by Pho Diep on 6/7/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipesListView : UIView

@property (strong, nonatomic) IBOutlet UINavigationItem *titleBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
