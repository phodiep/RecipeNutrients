//
//  Measure.h
//  RecipeNutrients
//
//  Created by Pho Diep on 5/26/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Measure : NSObject

-(instancetype)initWithJson:(NSDictionary*)json;
-(NSArray*)parseMultipleWithJson:(NSArray*)json;

-(NSString*)getEquivalent;
-(NSString*)getLabel;
-(int)getQuantity;
-(float)getValue;

@end

