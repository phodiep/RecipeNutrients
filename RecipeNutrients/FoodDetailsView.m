//
//  FoodDetailsView.m
//  RecipeNutrients
//
//  Created by Pho Diep on 6/4/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

#import "FoodDetailsView.h"

@interface FoodDetailsView ()

@property (strong, nonatomic) UITapGestureRecognizer *tapViewToCloseSubview;
@property (nonatomic) BOOL subviewVisible;

@end

@implementation FoodDetailsView

-(void)hidePickerSubView {
    if (self.subviewVisible) {
        [UIView animateWithDuration:0.3f animations:^{
            [self.pickerSubview setCenter:CGPointMake(self.pickerSubview.center.x,
                                                      self.pickerSubview.center.y + self.pickerSubview.frame.size.height)];
        } completion:^(BOOL finished) {
            [self removeGestureRecognizer:self.tapViewToCloseSubview];
        }];
        self.subviewVisible = false;
    }
}

-(void)showPickerSubView {
    if (!self.subviewVisible) {
        [UIView animateWithDuration:0.3f animations:^{
            [self.pickerSubview setCenter:CGPointMake(self.pickerSubview.center.x,
                                                      self.pickerSubview.center.y - self.pickerSubview.frame.size.height)];
        } completion:^(BOOL finished) {
            [self addGestureRecognizer:self.tapViewToCloseSubview];
        }];
        self.subviewVisible = true;
    }
}

- (IBAction)pickerDoneButtonPressed:(UIButton *)sender {
    [self hidePickerSubView];
}


-(UITapGestureRecognizer *)tapViewToCloseSubview {
    if (_tapViewToCloseSubview == nil) {
        _tapViewToCloseSubview = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector((hidePickerSubView))];
    }
    return _tapViewToCloseSubview;
}


@end
