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

@interface SearchViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (strong, nonatomic) UIView *rootView;
@property (strong, nonatomic) NSMutableDictionary *views;

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) NSString *searchQuery;

@property (strong, nonatomic) NSArray *searchResults;

@end

@implementation SearchViewController

-(void)loadView {
    self.rootView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.views = [[NSMutableDictionary alloc] init];

    self.tableView = [[UITableView alloc] init];
    [self setupForAutoLayout:self.tableView addToView:self.rootView viewsString:@"tableView"];
    
    self.searchBar = [[UISearchBar alloc] init];
    [self setupForAutoLayout:self.searchBar addToView:self.rootView viewsString:@"searchBar"];
    
    [self applyAutolayout];
    
    self.view = self.rootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.rootView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.searchBar.delegate = self;
    
    self.searchResults = [[UsdaClient sharedService] searchForFood:@"coconut%20water" foodGroup:@"" maxResults:@"5" offsetResults:@"0" getAllResults:true];
}

-(void)applyAutolayout {
    [self.rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:self.views]];
    [self.rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[searchBar]|" options:0 metrics:nil views:self.views]];
    [self.rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[searchBar(44)][tableView]|" options:0 metrics:nil views:self.views]];
}

- (void)setupForAutoLayout:(UIView*)object addToView:(UIView*)rootView viewsString:(NSString*)viewsString {
    [object setTranslatesAutoresizingMaskIntoConstraints:false];
    [rootView addSubview:object];
    [self.views setObject:object forKey:viewsString];
}

#pragma mark - UITableView DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.searchResults count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SEARCH_RESULTS_CELL"];
    SearchResult *item = (SearchResult*) self.searchResults[indexPath.row];
    cell.textLabel.text = item.getName;
    
    return cell;
}

#pragma mark - UITableView Delegate

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
    [self.tableView reloadData];
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
