//
//  SearchResult.h
//  RecipeNutrients
//
//  Created by Pho Diep on 5/27/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchResult : NSObject

-(instancetype)initWithJson:(NSDictionary*)json;
-(NSArray*)parseMultipleWithJson:(NSArray*)json;

-(NSString*)getName;
-(NSString*)getNdbno;
-(NSString*)getFoodGroup;

@end
