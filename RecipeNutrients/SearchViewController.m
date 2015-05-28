//
//  SearchViewController.m
//  RecipeNutrients
//
//  Created by Pho Diep on 5/28/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@property (strong, nonatomic) UIView *rootView;

@property (strong, nonatomic) NSDictionary *views;

@end

@implementation SearchViewController

-(void)loadView {
    self.rootView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    
    
    
    
    self.view = self.rootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.rootView.backgroundColor = [UIColor orangeColor];
    
}


@end
