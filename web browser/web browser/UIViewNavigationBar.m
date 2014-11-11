//
//  UIViewNavigationBar.m
//  web browser
//
//  Created by Alberto Scampini on 29/10/14.
//  Copyright (c) 2014 Alberto Scampini. All rights reserved.
//

#import "UIViewNavigationBar.h"


@implementation UIViewNavigationBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //create the navigation bar
        _navigationBar=[[UINavigationBar alloc] initWithFrame:self.frame];
        _navigationBar.barTintColor=[UIColor blackColor];
        [self addSubview:_navigationBar];
        
        //create texfield containing url of current website
        _websiteUrl=[[UITextField alloc] initWithFrame:CGRectMake(5 + 50 + 5 + 50 + 5 + 50 + 5, 20, self.frame.size.width-170 - 10, self.frame.size.height-30)];//this is temp of course
        //personalize border and color of url textfild
        _websiteUrl.BorderStyle=UITextBorderStyleRoundedRect;
        _websiteUrl.layer.cornerRadius=8.0f;
        _websiteUrl.layer.masksToBounds=YES;
        _websiteUrl.layer.borderColor=[[UIColor whiteColor]CGColor];
        _websiteUrl.backgroundColor=[UIColor clearColor];
        _websiteUrl.layer.borderWidth= 1.0f;
        _websiteUrl.textColor=[UIColor whiteColor];
        [self addSubview:_websiteUrl];
    }
    return self;
}

- (void)setWebsiteUrlForBar:(NSString *)Url{
    _websiteUrl.text=Url;
}

- (void)hideBarWithAnimation{
    //moving up the center of the navigation to -30 (so exiting from the screen) with animation
    UIViewAnimationOptions option = UIViewAnimationOptionOverrideInheritedDuration;
    [UIView transitionWithView:self
                      duration:0.3
                       options:option
                    animations:^{self.center=CGPointMake(self.center.x, -30);}
                    completion:nil];
}

- (void)showBarWithAnimation{
    //moving down the center of the navigation to 30 (so exiting from the screen) with animation
    UIViewAnimationOptions option = UIViewAnimationOptionOverrideInheritedDuration;
    [UIView transitionWithView:self
                      duration:0.3
                       options:option
                    animations:^{self.center=CGPointMake(self.center.x, 30);}
                    completion:nil];
}

@end
