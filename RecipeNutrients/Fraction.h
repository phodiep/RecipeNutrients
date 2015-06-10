//
//  Fraction.h
//  RecipeNutrients
//
//  Created by Pho Diep on 6/9/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fraction : NSObject

-(instancetype)initValue:(float)value withUnicode:(unichar)unicode;

-(float)getValue;
-(unichar)getUnicode;
-(NSString*)getString;

-(BOOL)isEqualTo:(float)otherValue;

+(NSArray*)fetchFullSetOfFractionsEighth;
+(NSArray*)fetchFullSetOfFractionsEighthWithZero;

+(NSArray*)getAllValues:(NSArray*)fractions;
+(NSArray*)getAllStrings:(NSArray*)fractions;

@end
