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
    NSString *endpoint = self.httpEndPointFoodReports;
    
    NSDictionary *param = @{@"ndbno" : ndbno,
                            @"type" : @"b",
                            @"format" : @"JSON"
                            };
    __block Food *food = nil;
    
    [[NetworkController sharedInstance] makeApiGetRequest:endpoint
                                           withParameters:param
                                    withCompletionHandler:^(NSObject *results) {
                                        NSDictionary *result = (NSDictionary*)results;
                                        NSDictionary *report = (NSDictionary*)result[@"report"];

                                            food = [[Food alloc] initWithJson:(NSDictionary*)report[@"food"]];
                                        
                                    }];
    return food;
}

@end
