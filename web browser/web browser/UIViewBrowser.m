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
        //allow pinch to zoom
        _webBrowserPage.scalesPageToFit=YES;
        [self addSubview:_webBrowserPage];
        
        //prepare the first page url and request
        NSString *url=@"http://www.google.it";
        NSURL *nsurl=[NSURL URLWithString:url];
        NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
        //navigate to first page url
        [_webBrowserPage loadRequest:nsrequest];
    }
    return self;
}

@end
