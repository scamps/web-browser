//
//  UIViewBrowser.m
//  web browser
//
//  Created by Alberto Scampini on 29/10/14.
//  Copyright (c) 2014 Alberto Scampini. All rights reserved.
//

#import "UIViewBrowser.h"

@implementation UIViewBrowser

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
        // Initialization code for the UIWebView
        _webBrowserPage=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height)];
        _webBrowserPage.backgroundColor=[UIColor blackColor];
        _webBrowserPage.scalesPageToFit=YES;
        _webBrowserPage.delegate=self;
        [self addSubview:_webBrowserPage];
        self.backgroundColor=[UIColor redColor];
    }
    return self;
}

- (void)loadWebPageFromUrl:(NSString *)Url{
    //navigate to the page url
    NSURL *nsurl=[NSURL URLWithString:Url];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [_webBrowserPage loadRequest:nsrequest];
    _currentUrl=Url;
}

- (void)removeGestureRecognizerFromWebPages:(UIGestureRecognizer *)gestureRecognizer{
    [_webBrowserPage.scrollView.panGestureRecognizer requireGestureRecognizerToFail:gestureRecognizer];
    
}

- (void)updatePageFrameDimension:(CGRect)newFrame{
    //update the dimensions of the uiwebview to the new size
    _webBrowserPage.frame=newFrame;
}

@end
