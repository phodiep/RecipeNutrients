//
//  NetworkController.m
//  RecipeNutrients
//
//  Created by Pho Diep on 5/20/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "NetworkController.h"
#import "ApiKeys.h"

@interface NetworkController()

@property (strong, nonatomic) NSURLSession *urlSession;

@end

@implementation NetworkController

#pragma mark - SharedInstance Singleton
+ (instancetype)sharedInstance {
    static NetworkController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        NSURLSessionConfiguration *ephemeralConfig = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        self.urlSession = [NSURLSession sessionWithConfiguration:ephemeralConfig];
    }
    return self;
}

-(void)makeApiGetRequest:(NSString*)endPoint withParameters:(NSDictionary*)inputParams withCompletionHandler:(void (^)(NSObject *results))completionHandler {
    
    NSString *publicKey = [[ApiKeys instance] getPublicKey];
    
    NSMutableString *searchParameters = [[NSMutableString alloc] init];
    NSArray *keys = (NSMutableArray*)[inputParams allKeys];
    for (id key in keys) {
        [searchParameters appendString:[NSString stringWithFormat:@"%@=%@&", key, [inputParams valueForKey:key]]];
    }
    [searchParameters appendString:[NSString stringWithFormat:@"api_key=%@", publicKey]];
    
    NSString *urlString = [NSString stringWithFormat:@"%@?%@", endPoint, searchParameters];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    
    completionHandler([NetworkController makeSynchronousApiRequest:request]);
    
}

+ (NSObject*)makeSynchronousApiRequest:(NSURLRequest*)request {
    NSURLResponse* response;
    NSError* error = nil;
    
    NSData* result = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error != nil) {
        NSLog(@"\n\nRequest Error: %@", error);
        return nil;
    }
    
//    if ([NetworkController goodResponseCode:response] == false) {
//        //deal w/ bad response
//        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
//        NSLog(@"Bad Response: %ld", (long)httpResponse.statusCode);
//        return nil;
//    }
    
//    Response* finalResponse = [[Response alloc] init:[NSJSONSerialization JSONObjectWithData:result options:0 error:nil]];
//    return [finalResponse getResults];

    return [NSJSONSerialization JSONObjectWithData:result options:0 error:nil];
    
}


@end

