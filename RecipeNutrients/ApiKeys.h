//
//  ApiKeys.h
//  RecipeNutrients
//
//  Created by Pho Diep on 5/20/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiKeys : NSObject

+ (instancetype)instance;
- (NSString *)getPublicKey;

@end
