//
//  NetworkController.h
//  RecipeNutrients
//
//  Created by Pho Diep on 5/20/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkController : NSObject

+ (instancetype)sharedInstance;

-(void)makeApiGetRequest:(NSString*)endPoint withParameters:(NSDictionary*)inputParams withCompletionHandler:(void (^)(NSObject *results))completionHandler;

@end
