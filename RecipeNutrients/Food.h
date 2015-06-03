//
//  Food.h
//  RecipeNutrients
//
//  Created by Pho Diep on 5/20/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Food : NSObject

-(instancetype)initWithJson:(NSDictionary*)json;
-(NSArray*)parseMultipleWithJson:(NSArray*)json;

-(NSString*)getName;
-(NSString*)getNdbno;
-(NSDictionary*)getNutrients;

-(NSString*)getFoodGroup;

@end


