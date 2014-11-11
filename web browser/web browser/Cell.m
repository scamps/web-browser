//
//  Cell.m
//  web browser
//
//  Created by Alberto Scampini on 11/11/14.
//  Copyright (c) 2014 Alberto Scampini. All rights reserved.
//


#import "Cell.h"

@implementation Cell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor=[UIColor whiteColor];
        
        _image=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:_image];
                
        _label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
        _label.textColor=[UIColor whiteColor];
        _label.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self addSubview:_label];
        
        
    }
    return self;
}

- (void) setTitleLabel:(NSString *)title{
    _label.text=title;
}

- (void) setPicture:(UIImage *)picture{
    _image.image=picture;
}
@end
