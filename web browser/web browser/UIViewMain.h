//
//  UIViewMain.h
//  web browser
//
//  Created by Alberto Scampini on 29/10/14.
//  Copyright (c) 2014 Alberto Scampini. All rights reserved.
//

@import UIKit;
#import "UIViewBrowser.h"

@class UIViewBrowser;

@protocol UIWiewMainDelegate <NSObject>
- (void)changeNavigationBarUrl:(NSString *)Url;//used to notify to change the address on the navigation bar (i.e. loading new page or switching between tabs)
@end

@interface UIViewMain : UIView<UIViewBrowserDelegate>

@property (nonatomic) UIViewBrowser *webBrowserView;//view that show the pages of the web browser
@property (nonatomic, unsafe_unretained) id <UIWiewMainDelegate> delegate;

- (void)setWebsiteUrlForBrowser:(NSString *)Url;
- (void)removeGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer;
- (void)switchOnFullScreenMode;
- (void)switchOffFullScreenMode;

@end