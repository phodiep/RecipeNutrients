//
//  Food.h
//  RecipeNutrients
//
//  Created by Pho Diep on 5/20/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Food : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *ndbno;
@property (strong, nonatomic) NSArray *nutrientsArray;

-(instancetype)initWithJson:(NSDictionary*)json;

@end


