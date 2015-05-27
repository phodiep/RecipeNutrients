//
//  Measure.h
//  RecipeNutrients
//
//  Created by Pho Diep on 5/26/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Measure : NSObject

@property (strong, nonatomic) NSString *eqv;
@property (strong, nonatomic) NSString *label;
@property (nonatomic) int qty;
@property (nonatomic) float value;

-(instancetype)initWithJson:(NSDictionary*)json;

@end

/*
 {
 eqv = 148;
 label = large;
 qty = 1;
 value = "131.99";
 },
 */
