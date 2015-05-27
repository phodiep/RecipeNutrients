//
//  FoodListItem.h
//  RecipeNutrients
//
//  Created by Pho Diep on 5/26/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodListItem : NSObject

/*
 List Type
    f = food
    n = all nutrients
   ns = speciality nutrients
   nr = standard release nutrients only
    g = food group
 */
typedef enum {
    f, n, ns, nr, g
} ListType;

-(instancetype)initWithJson:(NSDictionary*)json;
-(NSArray*)parseMultipleWithJson:(NSArray*)json;

+(NSString*)listTypeToString:(ListType)listType;

-(NSString*)getId;
-(NSString*)getName;

@end
