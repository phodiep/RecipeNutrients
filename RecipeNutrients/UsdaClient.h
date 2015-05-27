//
//  UsdaClient.h
//  RecipeNutrients
//
//  Created by Pho Diep on 5/20/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Food.h"
#import "FoodListItem.h"

@interface UsdaClient : NSObject

+(id)sharedService;

-(Food*)fetchFoodReport:(NSString*)ndbno;

-(NSArray*)fetchFoodList:(ListType*)listType maxResults:(NSString*)maxResults offsetResults:(NSString*)offset;
-(NSArray*)fetchFoodList:(ListType*)listType maxResults:(NSString*)maxResults;
-(NSArray*)fetchFoodList:(ListType*)listType offsetResults:(NSString*)offset;
-(NSArray*)fetchFoodList:(ListType*)listType;

@end
