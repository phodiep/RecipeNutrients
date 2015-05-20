//
//  ApiKeys.m
//  RecipeNutrients
//
//  Created by Pho Diep on 5/20/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "ApiKeys.h"

@interface ApiKeys()

@property (strong, nonatomic) NSString *publicKey;

@end

@implementation ApiKeys

#pragma mark - singleton
+ (instancetype)instance {
    static ApiKeys *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.publicKey = @"DEMO_KEY";
    }
    return self;
}

#pragma mark - getters
- (NSString *)getPublicKey {
    return self.publicKey;
}

@end
