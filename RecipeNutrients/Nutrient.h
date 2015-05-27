//
//  Nutrient.h
//  RecipeNutrients
//
//  Created by Pho Diep on 5/20/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Nutrient : NSObject

-(instancetype)initWithJson:(NSDictionary*)json;
-(NSArray*)getMeasurementOptions;

-(NSString*)getGroup;
-(NSString*)getNutrientId;
-(NSString*)getName;
-(NSString*)getUnit;
-(NSString*)getValue;
-(NSDictionary*)getMeasurements;

@end