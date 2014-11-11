//
//  Cell.h
//  web browser
//
//  Created by Alberto Scampini on 11/11/14.
//  Copyright (c) 2014 Alberto Scampini. All rights reserved.
//


@import UIKit;

@interface Cell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *image;
@property (strong, nonatomic) UILabel *label;

- (void) setTitleLabel:(NSString *)title;
- (void) setPicture:(UIImage *)picture;

@end
