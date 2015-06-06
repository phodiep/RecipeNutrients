//
//  FoodDetailsView.m
//  RecipeNutrients
//
//  Created by Pho Diep on 6/4/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "FoodDetailsView.h"

@implementation FoodDetailsView

-(void)hidePickerSubView {
    [UIView animateWithDuration:0.3f animations:^{
        [self.pickerSubview setCenter:CGPointMake(self.pickerSubview.center.x,
                                                  self.pickerSubview.center.y + self.pickerSubview.frame.size.height)];
    }];
}

-(void)showPickerSubView {
    [UIView animateWithDuration:0.3f animations:^{
        [self.pickerSubview setCenter:CGPointMake(self.pickerSubview.center.x,
                                                  self.pickerSubview.center.y - self.pickerSubview.frame.size.height)];
    }];
}

@end
