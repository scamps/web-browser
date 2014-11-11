//
//  UIViewBrowser.h
//  web browser
//
//  Created by Alberto Scampini on 29/10/14.
//  Copyright (c) 2014 Alberto Scampini. All rights reserved.
//

@import UIKit;
@import WebKit;

@interface UIViewBrowser : UIView<UIWebViewDelegate>

@property (nonatomic) UIWebView *webBrowserPage;
@property (nonatomic) NSString *currentUrl;

- (void)loadWebPageFromUrl:(NSString *)Url;
- (void)removeGestureRecognizerFromWebPages:(UIGestureRecognizer *)gestureRecognizer;
- (void)updatePageFrameDimension:(CGRect)newFrame;

@end
