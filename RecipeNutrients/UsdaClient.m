//
//  UsdaClient.m
//  RecipeNutrients
//
//  Created by Pho Diep on 5/20/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "UsdaClient.h"
#import "NetworkController.h"

@interface UsdaClient ()

@property (strong, nonatomic) NSString *httpEndPointFoodReports;
@property (strong, nonatomic) NSString *httpEndPointLists;
@property (strong, nonatomic) NSString *httpEndPointNutrientReports;
@property (strong, nonatomic) NSString *httpEndPointSearch;

@property (strong, nonatomic) NSString *defaultMaxResult;
@property (strong, nonatomic) NSString *defaultOffset;

@property (strong, nonatomic) NSMutableDictionary *foods;

@end

@implementation UsdaClient
+(id)sharedService {
    static UsdaClient *mySharedService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mySharedService = [[self alloc] init];
    });
    return mySharedService;
}

-(NSString *)httpEndPointFoodReports {
    if (_httpEndPointFoodReports == nil) {
        _httpEndPointFoodReports = @"http://api.nal.usda.gov/usda/ndb/reports/";
    }
    return _httpEndPointFoodReports;
}

-(NSString *)httpEndPointLists {
    if (_httpEndPointLists == nil) {
        _httpEndPointLists = @"http://api.nal.usda.gov/usda/ndb/list";
    }
    return _httpEndPointLists;
}

-(NSString *)httpEndPointNutrientReports {
    if (_httpEndPointNutrientReports == nil) {
        _httpEndPointNutrientReports = @"http://api.nal.usda.gov/usda/ndb/nutrients/";
    }
    return _httpEndPointNutrientReports;
}

-(NSString *)httpEndPointSearch {
    if (_httpEndPointSearch == nil) {
        _httpEndPointSearch = @"http://api.nal.usda.gov/usda/ndb/search/";
    }
    return _httpEndPointSearch;
}

-(NSString *)defaultMaxResult {
    if (_defaultMaxResult == nil) {
        _defaultMaxResult = @"1500";
    }
    return _defaultMaxResult;
}

-(NSString*)defaultOffset {
    if (_defaultOffset == nil) {
        _defaultOffset = @"0";
    }
    return _defaultOffset;
}

-(NSMutableDictionary *)foods {
    if (_foods == nil) {
        _foods = [[NSMutableDictionary alloc] init];
    }
    return _foods;
}

#pragma mark - Fetch Food Report
-(Food*)fetchFoodReport:(NSString*)ndbno {
    if (ndbno == nil) {
        return nil;
    }
    
    if (self.foods[ndbno] != nil) {
        return self.foods[ndbno];
    }
    
    NSString *endpoint = self.httpEndPointFoodReports;
    
    NSDictionary *param = @{@"ndbno" : ndbno,
                            @"type" : @"b",
                            @"format" : @"JSON"
                            };
    __block Food *food = nil;
    
    [[NetworkController sharedInstance] makeApiGetRequest:endpoint
                                           withParameters:param
                                    withCompletionHandler:^(NSObject *results) {
                                        if (results != nil) {
                                            NSDictionary *result = (NSDictionary*)results;
                                            NSDictionary *report = (NSDictionary*)result[@"report"];

                                            food = [[Food alloc] initWithJson:(NSDictionary*)report[@"food"]];
                                        }
                                    }];
    self.foods[ndbno] = food;
    
    return food;
}

#pragma mark - Fetch Food Lists
-(NSArray*)fetchFoodList:(ListType*)listType maxResults:(NSString*)maxResults offsetResults:(NSString*)offset {
    if (listType == nil) {
        return nil;
    }
    NSString *type = [FoodListItem listTypeToString:*listType];
    NSString *endpoint = self.httpEndPointLists;
    
    NSDictionary *param = @{@"lt" : type,
                            @"max" : maxResults,
                            @"offset" : offset,
                            @"sort" : @"n",
                            @"format" : @"JSON"
                            };

    __block NSArray *foodList = nil;
    
    [[NetworkController sharedInstance] makeApiGetRequest:endpoint
                                           withParameters:param
                                    withCompletionHandler:^(NSObject *results) {
                                        if (results != nil) {
                                            NSDictionary *result = (NSDictionary*)results;
                                            NSDictionary *listResult = (NSDictionary*)result[@"list"];
                                            
                                            foodList = [[FoodListItem alloc] parseMultipleWithJson:listResult[@"item"]];
                                        }
                                    }];
    return foodList;
}

-(NSArray*)fetchFoodList:(ListType*)listType offsetResults:(NSString*)offset {
    return [self fetchFoodList:listType maxResults:self.defaultMaxResult offsetResults:offset];
}

-(NSArray*)fetchFoodList:(ListType*)listType maxResults:(NSString*)maxResults {
    return [self fetchFoodList:listType maxResults:maxResults offsetResults:self.defaultOffset];
}

-(NSArray*)fetchFoodList:(ListType*)listType {
    return [self fetchFoodList:listType maxResults:self.defaultMaxResult offsetResults:self.defaultOffset];
}

#pragma mark - Search For Food
-(NSArray*)searchForFood:(NSString*)searchQuery foodGroup:(NSString*)foodGroup maxResults:(NSString*)maxResults offsetResults:(NSString*)offset getAllResults:(BOOL)allResults {
    
    NSString *endpoint = self.httpEndPointSearch;
    
    NSDictionary *param = @{@"q" : searchQuery,
                            @"fg" : foodGroup,
                            @"max" : maxResults,
                            @"offset" : offset,
                            @"format" : @"JSON"
                            };
    
    __block NSMutableArray *searchResults = [[NSMutableArray alloc] init];

    [[NetworkController sharedInstance] makeApiGetRequest:endpoint
                                           withParameters:param
                                    withCompletionHandler:^(NSObject *results) {
                                        if (results != nil) {
                                            NSDictionary *result = (NSDictionary*)results;
                                            NSDictionary *listResults = (NSDictionary*)result[@"list"];
                                            
                                            NSArray *itemJson = (NSArray*)listResults[@"item"];
                                            
                                            if ([itemJson count]>0) {
                                                
                                                [searchResults addObjectsFromArray: [[SearchResult alloc] parseMultipleWithJson:itemJson]];
                                                
                                                NSString *newOffset = [NSString stringWithFormat:@"%d",
                                                                       maxResults.intValue + offset.intValue];
                                                
                                                if (allResults) {
                                                    [searchResults addObjectsFromArray:[self searchForFood:searchQuery foodGroup:foodGroup maxResults:maxResults offsetResults:newOffset getAllResults:allResults]];
                                                }
                                            }
                                        }
                                    }];
    return searchResults;
}

-(NSArray*)searchForFood:(NSString*)searchQuery foodGroup:(NSString*)foodGroup getAllResults:(BOOL)all {
    return [self searchForFood:searchQuery
                     foodGroup:foodGroup
                    maxResults:self.defaultMaxResult
                 offsetResults:self.defaultOffset
                 getAllResults:all];
}

-(NSArray*)searchForFood:(NSString*)searchQuery foodGroup:(NSString*)foodGroup offsetResults:(NSString*)offset getAllResults:(BOOL)all {
    return [self searchForFood:searchQuery
                     foodGroup:foodGroup
                    maxResults:self.defaultMaxResult
                 offsetResults:offset
                 getAllResults:all];
}

-(NSArray*)searchForFood:(NSString*)searchQuery offsetResults:(NSString*)offset getAllResults:(BOOL)all {
    return [self searchForFood:searchQuery
                     foodGroup:@""
                    maxResults:self.defaultMaxResult
                 offsetResults:offset
                 getAllResults:all];
}

-(NSArray*)searchForFood:(NSString*)searchQuery getAllResults:(BOOL)all {
    return [self searchForFood:@""
                     foodGroup:@""
                    maxResults:self.defaultMaxResult
                 offsetResults:self.defaultOffset
                 getAllResults:all];
    
}


@end
