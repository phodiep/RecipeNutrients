//
//  RecipesViewController.m
//  RecipeNutrients
//
//  Created by Pho Diep on 5/28/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "RecipesViewController.h"

@interface RecipesViewController ()

@property (strong, nonatomic) UIView *rootView;

@property (strong, nonatomic) NSDictionary *views;

@end

@implementation RecipesViewController

-(void)loadView {
    self.rootView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    
    
    
    
    self.view = self.rootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rootView.backgroundColor = [UIColor greenColor];
    
}


@end
