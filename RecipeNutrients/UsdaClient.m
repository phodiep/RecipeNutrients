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

#pragma mark - Fetch Food Report
-(Food*)fetchFoodReport:(NSString*)ndbno {
    if (ndbno == nil) {
        return nil;
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
    return [self fetchFoodList:listType maxResults:@"100" offsetResults:offset];
}

-(NSArray*)fetchFoodList:(ListType*)listType maxResults:(NSString*)maxResults {
    return [self fetchFoodList:listType maxResults:maxResults offsetResults:@"0"];
}

-(NSArray*)fetchFoodList:(ListType*)listType {
    return [self fetchFoodList:listType maxResults:@"100" offsetResults:@"0"];
}

@end
