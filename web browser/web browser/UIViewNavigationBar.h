//
//  UIViewNavigationBar.h
//  web browser
//
//  Created by Alberto Scampini on 29/10/14.
//  Copyright (c) 2014 Alberto Scampini. All rights reserved.
//

@import UIKit;
@import QuartzCore;

@protocol UIWiewNavigationBarDelegate <NSObject>
- (void)clickedNavigationBarButtonAtIndex:(int)index;//used to notify the tap of a button in this navigation bar to a parent view
@end

@interface UIViewNavigationBar : UIView

@property(nonatomic)UINavigationBar *navigationBar;
@property(nonatomic)UITextField *websiteUrl;
@property(nonatomic,retain)UIButton *homeButton;
@property(nonatomic,retain)UIButton *historyButton;
@property (nonatomic, unsafe_unretained) id <UIWiewNavigationBarDelegate> delegate;

- (void)setWebsiteUrlForBar:(NSString *)Url;
- (void)hideBarWithAnimation;
- (void)showBarWithAnimation;

@end
