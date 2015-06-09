//
//  RecipeIngredient.h
//  RecipeNutrients
//
//  Created by Pho Diep on 6/9/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Food.h"

@interface RecipeIngredient : NSObject

-(instancetype)init:(Food*)ingredient withAmount:(float)amount withUnit:(NSString*)unit;

-(Food*)getIngredient;
-(float)getAmount;
-(NSString*)getUnit;

-(void)updateAmount:(float)amount;
-(void)updateUnit:(NSString*)unit;
-(void)updateAmount:(float)amount andUnit:(NSString*)unit;

@end
