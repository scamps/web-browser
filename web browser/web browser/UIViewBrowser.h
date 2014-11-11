//
//  UIViewBrowser.h
//  web browser
//
//  Created by Alberto Scampini on 29/10/14.
//  Copyright (c) 2014 Alberto Scampini. All rights reserved.
//

@import UIKit;
@import WebKit;

@class NSHistoryManager;
@class NSPageHistory;

@protocol UIViewBrowserDelegate <NSObject>
    - (void)changedWebUrl:(NSString *)Url;//used to notify the change of the page/url to the parent view (to update the address on the navigation bar)
@end

@interface UIViewBrowser : UIView<UIWebViewDelegate>

@property (nonatomic) UIWebView *webBrowserPage;
@property (nonatomic) NSString *currentUrl;
@property (nonatomic, unsafe_unretained) id <UIViewBrowserDelegate> delegate;
@property (nonatomic) NSTimer *timerSave;

- (void)loadWebPageFromUrl:(NSString *)Url;
- (void)removeGestureRecognizerFromWebPages:(UIGestureRecognizer *)gestureRecognizer;
- (void)updatePageFrameDimension:(CGRect)newFrame;

@end