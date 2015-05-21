//
//  Nutrient.m
//  RecipeNutrients
//
//  Created by Pho Diep on 5/20/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "Nutrient.h"

@implementation Nutrient

-(instancetype)initWithJson:(NSDictionary*)json {
    self = [super init];
    if (self) {
        self.name = json[@"name"];
        self.nutrientId = json[@"nutrient_id"];
        self.unit = json[@"unit"];
        self.value = json[@"value"];
        self.group = json[@"group"];
    }
    return self;
}

/*{
 group = Proximates;
 measures =                     (
 {
 eqv = 148;
 label = large;
 qty = 1;
 value = "131.99";
 },
 {
 eqv = 15;
 label = small;
 qty = 1;
 value = "13.38";
 },
 {
 eqv = 86;
 label = "cup sliced";
 qty = 1;
 value = "76.69";
 }
 );
 name = Water;
 "nutrient_id" = 255;
 unit = g;
 value = "89.18";
 }
 */
@end
