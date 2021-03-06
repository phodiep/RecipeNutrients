//
//  SearchView.h
//  RecipeNutrients
//
//  Created by Pho Diep on 6/5/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchView : UIView

@property (strong, nonatomic) IBOutlet UINavigationItem *titleBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@end
