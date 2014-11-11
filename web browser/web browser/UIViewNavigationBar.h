//
//  UIViewNavigationBar.h
//  web browser
//
//  Created by Alberto Scampini on 29/10/14.
//  Copyright (c) 2014 Alberto Scampini. All rights reserved.
//

@import UIKit;
@import QuartzCore;

@interface UIViewNavigationBar : UIView

@property(nonatomic)UINavigationBar *navigationBar;
@property(nonatomic)UITextField *websiteUrl;

- (void)setWebsiteUrlForBar:(NSString *)Url;
- (void)hideBarWithAnimation;
- (void)showBarWithAnimation;

@end
