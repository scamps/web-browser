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
@synthesize delegate;

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
        _webBrowserView=[[UIViewBrowser alloc]initWithFrame:CGRectMake(0, 60, self.frame.size.width,self.frame.size.height-60)];
        _webBrowserView.delegate=self;
        [self addSubview:_webBrowserView];
        
        //hide statusbar
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
        
    }
    return self;
}

- (void)setWebsiteUrlForBrowser:(NSString *)Url{
    [_webBrowserView loadWebPageFromUrl:Url];
}

- (void)removeGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer{
    //remove gesture recogniser from UIViewBrowser
    [_webBrowserView removeGestureRecognizerFromWebPages:gestureRecognizer];
}

- (void)switchOnFullScreenMode{
    //resize web browser view
    UIViewAnimationOptions option = UIViewAnimationOptionOverrideInheritedDuration;
    [UIView transitionWithView:_webBrowserView
                      duration:0.3
                       options:option
                    animations:^{_webBrowserView.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);}
                    completion:nil];
    //resize web browser
    [_webBrowserView updatePageFrameDimension:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    
}

- (void)switchOffFullScreenMode{
    //resize web browser view
    UIViewAnimationOptions option = UIViewAnimationOptionOverrideInheritedDuration;
    [UIView transitionWithView:_webBrowserView
                      duration:0.3
                       options:option
                    animations:^{_webBrowserView.frame=CGRectMake(0, 60, self.frame.size.width, self.frame.size.height-60);}
                    completion:^(BOOL finished){
                        //resize web browser
                        [_webBrowserView updatePageFrameDimension:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-60)];
                    }];
}

#pragma UIViewBrowser delegate methods
- (void)changedWebUrl:(NSString *)Url{
    [delegate changeNavigationBarUrl:Url];
}

@end
