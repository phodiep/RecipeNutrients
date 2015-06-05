//
//  SearchViewController.m
//  RecipeNutrients
//
//  Created by Pho Diep on 5/28/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "SearchViewController.h"
#import "UsdaClient.h"
#import "SearchResult.h"
#import "FoodDetailsViewController.h"
#import "SearchView.h"

@interface SearchViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (strong, nonatomic) SearchView *searchView;
@property (strong, nonatomic) NSString *searchQuery;
@property (strong, nonatomic) NSArray *searchResults;

@property (strong, nonatomic) NSMutableDictionary *searchResultsSortedByType;
@property (strong, nonatomic) NSMutableArray *searchResultsTypes;

@end

@implementation SearchViewController

-(void)loadView {
    self.searchView = [[NSBundle mainBundle] loadNibNamed:@"SearchView" owner:self options:nil][0];
    self.searchView.frame = [UIScreen mainScreen].applicationFrame;
    self.view = self.searchView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchView.titleLabel.text = @"Search Results";
    self.searchView.tableView.dataSource = self;
    self.searchView.tableView.delegate = self;
    self.searchView.searchBar.delegate = self;
    
}

#pragma mark - UITableView DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *sectionName = self.searchResultsTypes[section];
    
    return [self.searchResultsSortedByType[sectionName] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.searchResultsTypes count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.searchResultsTypes[section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SEARCH_RESULTS_CELL"];
    NSString *section = self.searchResultsTypes[indexPath.section];
    SearchResult *item = (SearchResult*) self.searchResultsSortedByType[section][indexPath.row];
    cell.textLabel.text = item.getName;
    return cell;
}

#pragma mark - UITableView Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchResult *selectedItem = (SearchResult*)self.searchResults[indexPath.row];
    Food *food = [[UsdaClient sharedService] fetchFoodReport:selectedItem.getNdbno];
    
    FoodDetailsViewController *foodVC = [[FoodDetailsViewController alloc] init];
    foodVC.food = food;
    
    [self presentViewController:foodVC animated:true completion:nil];
    
}


#pragma mark - UISearchBarDelegate
-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    //only allows alpha's but does not allow search
//    NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"] invertedSet];
//    return ([text stringByTrimmingCharactersInSet:nonNumberSet].length > 0);
    
    
    //allows search, but invalid character is not removed until next entry
    NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "] invertedSet];
    searchBar.text = [[searchBar.text componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
    return [searchBar.text isEqualToString:searchBar.text];
    
    //freezes after invalid char
//    return [self validateForRegex:searchBar.text];
    
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    self.searchQuery = [self urlEncode:searchBar.text];
    self.searchResults = [self searchForFood:self.searchQuery];
    [self sortSearchResultsByType];
    [self.searchView.tableView reloadData];
}

#pragma mark - misc
-(NSArray*)searchForFood:(NSString*)searchQuery withOffset:(int)offset {
    NSString *strOffset = [NSString stringWithFormat:@"%d", offset];
    return [[UsdaClient sharedService] searchForFood:searchQuery
                                           foodGroup:@""
                                          maxResults:@"100"
                                       offsetResults:strOffset
                                       getAllResults:false];
}

-(NSArray*)searchForFood:(NSString*)searchQuery {
    return [self searchForFood:searchQuery withOffset:0];
}

-(void)sortSearchResultsByType {
    self.searchResultsTypes = [[NSMutableArray alloc] init];
    self.searchResultsSortedByType = [[NSMutableDictionary alloc] init];
    
    for (SearchResult *food in self.searchResults) {
        NSString *foodgroup = food.getFoodGroup;
        if (self.searchResultsSortedByType[foodgroup] == nil) {
            self.searchResultsSortedByType[foodgroup] = [[NSMutableArray alloc] initWithArray:@[food]];
            [self.searchResultsTypes addObject:foodgroup];
        } else {
            [self.searchResultsSortedByType[foodgroup] addObject:food];
        }
    }
    
    [self.searchResultsTypes sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];

}

-(NSString*)urlEncode:(NSString*)victim {
    return [victim stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

-(BOOL)validateForRegex:(NSString*)str {
    
    NSString *pattern = @"[^a-zA-Z\\s\\n]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    
    NSRange range = NSMakeRange(0, str.length);
    
    NSInteger matches = [regex numberOfMatchesInString:str options:0 range:range];
    
    return matches > 0 ? false : true;
    
}

@end
