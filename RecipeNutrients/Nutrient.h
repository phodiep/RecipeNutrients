//
//  Nutrient.h
//  RecipeNutrients
//
//  Created by Pho Diep on 5/20/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Nutrient : NSObject

@property (strong, nonatomic) NSString *group;
@property (strong, nonatomic) NSString *nutrientId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *unit;
@property (strong, nonatomic) NSString *value;

-(instancetype)initWithJson:(NSDictionary*)json;

@end

/*
(
 {
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
 },
 {
     group = Proximates;
     measures =                     (
                                     {
                                         eqv = 148;
                                         label = large;
                                         qty = 1;
                                         value = 49;
                                     },
                                     {
                                         eqv = 15;
                                         label = small;
                                         qty = 1;
                                         value = 5;
                                     },
                                     {
                                         eqv = 86;
                                         label = "cup sliced";
                                         qty = 1;
                                         value = 28;
                                     }
                                     );
     name = Energy;
     "nutrient_id" = 208;
     unit = kcal;
     value = 33;
 },
 {
     group = Proximates;
     measures =                     (
                                     {
                                         eqv = 148;
                                         label = large;
                                         qty = 1;
                                         value = "4.90";
                                     },
                                     {
                                         eqv = 15;
                                         label = small;
                                         qty = 1;
                                         value = "0.50";
                                     },
                                     {
                                         eqv = 86;
                                         label = "cup sliced";
                                         qty = 1;
                                         value = "2.85";
                                     }
                                     );
     name = Protein;
     "nutrient_id" = 203;
     unit = g;
     value = "3.31";
 },
 {
     group = Proximates;
     measures =                     (
                                     {
                                         eqv = 148;
                                         label = large;
                                         qty = 1;
                                         value = "0.61";
                                     },
                                     {
                                         eqv = 15;
                                         label = small;
                                         qty = 1;
                                         value = "0.06";
                                     },
                                     {
                                         eqv = 86;
                                         label = "cup sliced";
                                         qty = 1;
                                         value = "0.35";
                                     }
                                     );
     name = "Total lipid (fat)";
     "nutrient_id" = 204;
     unit = g;
     value = "0.41";
 },
 {
     group = Proximates;
     measures =                     (
                                     {
                                         eqv = 148;
                                         label = large;
                                         qty = 1;
                                         value = "9.01";
                                     },
                                     {
                                         eqv = 15;
                                         label = small;
                                         qty = 1;
                                         value = "0.91";
                                     },
                                     {
                                         eqv = 86;
                                         label = "cup sliced";
                                         qty = 1;
                                         value = "5.24";
                                     }
                                     );
     name = "Carbohydrate, by difference";
     "nutrient_id" = 205;
     unit = g;
     value = "6.09";
 },
 {
     group = Proximates;
     measures =                     (
                                     {
                                         eqv = 148;
                                         label = large;
                                         qty = 1;
                                         value = "3.4";
                                     },
                                     {
                                         eqv = 15;
                                         label = small;
                                         qty = 1;
                                         value = "0.3";
                                     },
                                     {
                                         eqv = 86;
                                         label = "cup sliced";
                                         qty = 1;
                                         value = "2.0";
                                     }
                                     );
     name = "Fiber, total dietary";
     "nutrient_id" = 291;
     unit = g;
     value = "2.3";
 },
 {
     group = Proximates;
     measures =                     (
                                     {
                                         eqv = 148;
                                         label = large;
                                         qty = 1;
                                         value = "1.64";
                                     },
                                     {
                                         eqv = 15;
                                         label = small;
                                         qty = 1;
                                         value = "0.17";
                                     },
                                     {
                                         eqv = 86;
                                         label = "cup sliced";
                                         qty = 1;
                                         value = "0.95";
                                     }
                                     );
     name = "Sugars, total";
     "nutrient_id" = 269;
     unit = g;
     value = "1.11";
 },
 {
     group = Minerals;
     measures =                     (
                                     {
                                         eqv = 148;
                                         label = large;
                                         qty = 1;
                                         value = 4;
                                     },
                                     {
                                         eqv = 15;
                                         label = small;
                                         qty = 1;
                                         value = 0;
                                     },
                                     {
                                         eqv = 86;
                                         label = "cup sliced";
                                         qty = 1;
                                         value = 3;
                                     }
                                     );
     name = "Calcium, Ca";
     "nutrient_id" = 301;
     unit = mg;
     value = 3;
 },
 {
     group = Minerals;
     measures =                     (
                                     {
                                         eqv = 148;
                                         label = large;
                                         qty = 1;
                                         value = "1.97";
                                     },
                                     {
                                         eqv = 15;
                                         label = small;
                                         qty = 1;
                                         value = "0.20";
                                     },
                                     {
                                         eqv = 86;
                                         label = "cup sliced";
                                         qty = 1;
                                         value = "1.14";
                                     }
                                     );
     name = "Iron, Fe";
     "nutrient_id" = 303;
     unit = mg;
     value = "1.33";
 },
 {
     group = Minerals;
     measures =                     (
                                     {
                                         eqv = 148;
                                         label = large;
                                         qty = 1;
                                         value = 27;
                                     },
                                     {
                                         eqv = 15;
                                         label = small;
                                         qty = 1;
                                         value = 3;
                                     },
                                     {
                                         eqv = 86;
                                         label = "cup sliced";
                                         qty = 1;
                                         value = 15;
                                     }
                                     );
     name = "Magnesium, Mg";
     "nutrient_id" = 304;
     unit = mg;
     value = 18;
 },
 {
     group = Minerals;
     measures =                     (
                                     {
                                         eqv = 148;
                                         label = large;
                                         qty = 1;
                                         value = 178;
                                     },
                                     {
                                         eqv = 15;
                                         label = small;
                                         qty = 1;
                                         value = 18;
                                     },
                                     {
                                         eqv = 86;
                                         label = "cup sliced";
                                         qty = 1;
                                         value = 103;
                                     }
                                     );
     name = "Phosphorus, P";
     "nutrient_id" = 305;
     unit = mg;
     value = 120;
 },
 {
     group = Minerals;
     measures =                     (
                                     {
                                         eqv = 148;
                                         label = large;
                                         qty = 1;
                                         value = 622;
                                     },
                                     {
                                         eqv = 15;
                                         label = small;
                                         qty = 1;
                                         value = 63;
                                     },
                                     {
                                         eqv = 86;
                                         label = "cup sliced";
                                         qty = 1;
                                         value = 361;
                                     }
                                     );
     name = "Potassium, K";
     "nutrient_id" = 306;
     unit = mg;
     value = 420;
 },
 {
     group = Minerals;
     measures =                     (
                                     {
                                         eqv = 148;
                                         label = large;
                                         qty = 1;
                                         value = 27;
                                     },
                                     {
                                         eqv = 15;
                                         label = small;
                                         qty = 1;
                                         value = 3;
                                     },
                                     {
                                         eqv = 86;
                                         label = "cup sliced";
                                         qty = 1;
                                         value = 15;
                                     }
                                     );
     name = "Sodium, Na";
     "nutrient_id" = 307;
     unit = mg;
     value = 18;
 },
 {
     group = Minerals;
     measures =                     (
                                     {
                                         eqv = 148;
                                         label = large;
                                         qty = 1;
                                         value = "1.14";
                                     },
                                     {
                                         eqv = 15;
                                         label = small;
                                         qty = 1;
                                         value = "0.12";
                                     },
                                     {
                                         eqv = 86;
                                         label = "cup sliced";
                                         qty = 1;
                                         value = "0.66";
                                     }
                                     );
     name = "Zinc, Zn";
     "nutrient_id" = 309;
     unit = mg;
     value = "0.77";
 },
 {
     group = Vitamins;
     measures =                     (
                                     {
                                         eqv = 148;
                                         label = large;
                                         qty = 1;
                                         value = "0.0";
                                     },
                                     {
                                         eqv = 15;
                                         label = small;
                                         qty = 1;
                                         value = "0.0";
                                     },
                                     {
                                         eqv = 86;
                                         label = "cup sliced";
                                         qty = 1;
                                         value = "0.0";
                                     }
                                     );
     name = "Vitamin C, total ascorbic acid";
     "nutrient_id" = 401;
     unit = mg;
     value = "0.0";
 },
 {
     group = Vitamins;
     measures =                     (
                                     {
                                         eqv = 148;
                                         label = large;
                                         qty = 1;
                                         value = "0.185";
                                     },
                                     {
                                         eqv = 15;
                                         label = small;
                                         qty = 1;
                                         value = "0.019";
                                     },
                                     {
                                         eqv = 86;
                                         label = "cup sliced";
                                         qty = 1;
                                         value = "0.108";
                                     }
                                     );
     name = Thiamin;
     "nutrient_id" = 404;
     unit = mg;
     value = "0.125";
 },
 {
     group = Vitamins;
     measures =                     (
                                     {
                                         eqv = 148;
                                         label = large;
                                         qty = 1;
                                         value = "0.517";
                                     },
                                     {
                                         eqv = 15;
                                         label = small;
                                         qty = 1;
                                         value = "0.052";
                                     },
                                     {
                                         eqv = 86;
                                         label = "cup sliced";
                                         qty = 1;
                                         value = "0.300";
                                     }
                                     );
     name = Riboflavin;
     "nutrient_id" = 405;
     unit = mg;
     value = "0.349";
 },
 {
     group = Vitamins;
     measures =                     (
                                     {
                                         eqv = 148;
                                         label = large;
                                         qty = 1;
                                         value = "7.335";
                                     },
                                     {
                                         eqv = 15;
                                         label = small;
                                         qty = 1;
                                         value = "0.743";
                                     },
                                     {
                                         eqv = 86;
                                         label = "cup sliced";
                                         qty = 1;
                                         value = "4.262";
                                     }
                                     );
     name = Niacin;
     "nutrient_id" = 406;
     unit = mg;
     value = "4.956";
 },
 {
     group = Vitamins;
     measures =                     (
                                     {
                                         eqv = 148;
                                         label = large;
                                         qty = 1;
                                         value = "0.163";
                                     },
                                     {
                                         eqv = 15;
                                         label = small;
                                         qty = 1;
                                         value = "0.016";
                                     },
                                     {
                                         eqv = 86;
                                         label = "cup sliced";
                                         qty = 1;
                                         value = "0.095";
                                     }
                                     );
     name = "Vitamin B-6";
     "nutrient_id" = 415;
     unit = mg;
     value = "0.110";
 },
 {
     group = Vitamins;
     measures =                     (
                                     {
                                         eqv = 148;
                                         label = large;
                                         qty = 1;
                                         value = 56;
                                     },
                                     {
                                         eqv = 15;
                                         label = small;
                                         qty = 1;
                                         value = 6;
                                     },
                                     {
                                         eqv = 86;
                                         label = "cup sliced";
                                         qty = 1;
                                         value = 33;
                                     }
                                     );
     name = "Folate, DFE";
     "nutrient_id" = 435;
     unit = "\U00b5g";
     value = 38;
 },
 {
     group = Vitamins;
     measures =                     (
                                     {
                                         eqv = 148;
                                         label = large;
                                         qty = 1;
                                         value = "0.00";
                                     },
                                     {
                                         eqv = 15;
                                         label = small;
                                         qty = 1;
                                         value = "0.00";
                                     },
                                     {
                                         eqv = 86;
                                         label = "cup sliced";
                                         qty = 1;
                                         value = "0.00";
                                     }
                                     );
     name = "Vitamin B-12";
     "nutrient_id" = 418;
     unit = "\U00b5g";
     value = "0.00";
 },
 {
     group = Vitamins;
     measures =                     (
                                     {
                                         eqv = 148;
                                         label = large;
                                         qty = 1;
                                         value = 3;
                                     },
                                     {
                                         eqv = 15;
                                         label = small;
                                         qty = 1;
                                         value = 0;
                                     },
                                     {
                                         eqv = 86;
                                         label = "cup sliced";
                                         qty = 1;
                                         value = 2;
                                     }
                                     );
     name = "Vitamin A, RAE";
     "nutrient_id" = 320;
     unit = "\U00b5g";
     value = 2;
 },
 {
     group = Vitamins;
     measures =                     (
                                     {
                                         eqv = 148;
                                         label = large;
                                         qty = 1;
                                         value = 71;
                                     },
                                     {
                                         eqv = 15;
                                         label = small;
                                         qty = 1;
                                         value = 7;
                                     },
                                     {
                                         eqv = 86;
                                         label = "cup sliced";
                                         qty = 1;
                                         value = 41;
                                     }
                                     );
     name = "Vitamin A, IU";
     "nutrient_id" = 318;
     unit = IU;
     value = 48;
 },
 {
     group = Vitamins;
     measures =                     (
                                     {
                                         eqv = 148;
                                         label = large;
                                         qty = 1;
                                         value = "0.00";
                                     },
                                     {
                                         eqv = 15;
                                         label = small;
                                         qty = 1;
                                         value = "0.00";
                                     },
                                     {
                                         eqv = 86;
                                         label = "cup sliced";
                                         qty = 1;
                                         value = "0.00";
                                     }
                                     );
     name = "Vitamin E (alpha-tocopherol)";
     "nutrient_id" = 323;
     unit = mg;
     value = "0.00";
 },
 {
     group = Vitamins;
     measures =                     (
                                     {
                                         eqv = 148;
                                         label = large;
                                         qty = 1;
                                         value = "1.0";
                                     },
                                     {
                                         eqv = 15;
                                         label = small;
                                         qty = 1;
                                         value = "0.1";
                                     },
                                     {
                                         eqv = 86;
                                         label = "cup sliced";
                                         qty = 1;
                                         value = "0.6";
                                     }
                                     );
     name = "Vitamin D (D2 + D3)";
     "nutrient_id" = 328;
     unit = "\U00b5g";
     value = "0.7";
 },
 {
     group = Vitamins;
     measures =                     (
                                     {
                                         eqv = 148;
                                         label = large;
                                         qty = 1;
                                         value = 43;
                                     },
                                     {
                                         eqv = 15;
                                         label = small;
                                         qty = 1;
                                         value = 4;
                                     },
                                     {
                                         eqv = 86;
                                         label = "cup sliced";
                                         qty = 1;
                                         value = 25;
                                     }
                                     );
     name = "Vitamin D";
     "nutrient_id" = 324;
     unit = IU;
     value = 29;
 },
 {
     group = Vitamins;
     measures =                     (
                                     {
                                         eqv = 148;
                                         label = large;
                                         qty = 1;
                                         value = "0.0";
                                     },
                                     {
                                         eqv = 15;
                                         label = small;
                                         qty = 1;
                                         value = "0.0";
                                     },
                                     {
                                         eqv = 86;
                                         label = "cup sliced";
                                         qty = 1;
                                         value = "0.0";
                                     }
                                     );
     name = "Vitamin K (phylloquinone)";
     "nutrient_id" = 430;
     unit = "\U00b5g";
     value = "0.0";
 },
 {
     group = Lipids;
     measures =                     (
                                     {
                                         eqv = 148;
                                         label = large;
                                         qty = 1;
                                         value = "0.092";
                                     },
                                     {
                                         eqv = 15;
                                         label = small;
                                         qty = 1;
                                         value = "0.009";
                                     },
                                     {
                                         eqv = 86;
                                         label = "cup sliced";
                                         qty = 1;
                                         value = "0.053";
                                     }
                                     );
     name = "Fatty acids, total saturated";
     "nutrient_id" = 606;
     unit = g;
     value = "0.062";
 },
 {
     group = Lipids;
     measures =                     (
                                     {
                                         eqv = 148;
                                         label = large;
                                         qty = 1;
                                         value = "0.046";
                                     },
                                     {
                                         eqv = 15;
                                         label = small;
                                         qty = 1;
                                         value = "0.005";
                                     },
                                     {
                                         eqv = 86;
                                         label = "cup sliced";
                                         qty = 1;
                                         value = "0.027";
                                     }
                                     );
     name = "Fatty acids, total monounsaturated";
     "nutrient_id" = 645;
     unit = g;
     value = "0.031";
 },
 {
     group = Lipids;
     measures =                     (
                                     {
                                         eqv = 148;
                                         label = large;
                                         qty = 1;
                                         value = "0.182";
                                     },
                                     {
                                         eqv = 15;
                                         label = small;
                                         qty = 1;
                                         value = "0.018";
                                     },
                                     {
                                         eqv = 86;
                                         label = "cup sliced";
                                         qty = 1;
                                         value = "0.106";
                                     }
                                     );
     name = "Fatty acids, total polyunsaturated";
     "nutrient_id" = 646;
     unit = g;
     value = "0.123";
 },
 {
     group = Lipids;
     measures =                     (
                                     {
                                         eqv = 148;
                                         label = large;
                                         qty = 1;
                                         value = 0;
                                     },
                                     {
                                         eqv = 15;
                                         label = small;
                                         qty = 1;
                                         value = 0;
                                     },
                                     {
                                         eqv = 86;
                                         label = "cup sliced";
                                         qty = 1;
                                         value = 0;
                                     }
                                     );
     name = Cholesterol;
     "nutrient_id" = 601;
     unit = mg;
     value = 0;
 },
 {
     group = Other;
     measures =                     (
                                     {
                                         eqv = 148;
                                         label = large;
                                         qty = 1;
                                         value = 0;
                                     },
                                     {
                                         eqv = 15;
                                         label = small;
                                         qty = 1;
                                         value = 0;
                                     },
                                     {
                                         eqv = 86;
                                         label = "cup sliced";
                                         qty = 1;
                                         value = 0;
                                     }
                                     );
     name = Caffeine;
     "nutrient_id" = 262;
     unit = mg;
     value = 0;
 }
 )

*/
