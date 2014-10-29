//
//  UIViewMain.m
//  web browser
//
//  Created by Alberto Scampini on 29/10/14.
//  Copyright (c) 2014 Alberto Scampini. All rights reserved.
//

#import "UIViewMain.h"
#import "UIViewBrowser.h"

@implementation UIViewMain

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
        // create and add webBrowserView in full screen
        _webBrowserView=[[UIViewBrowser alloc]initWithFrame:self.frame];
        [self addSubview:_webBrowserView];
        //hide statusbar
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    }
    return self;
}
@end
