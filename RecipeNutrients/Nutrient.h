//
//  Nutrient.h
//  RecipeNutrients
//
//  Created by Pho Diep on 5/20/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Nutrient : NSObject

@property (strong, nonatomic) NSString *group;
@property (strong, nonatomic) NSString *nutrient_id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *unit;
@property (strong, nonatomic) NSString *value;
@property (strong, nonatomic) NSDictionary *measurements;

-(instancetype)initWithJson:(NSDictionary*)json;
-(NSArray*)getMeasurementOptions;

@end