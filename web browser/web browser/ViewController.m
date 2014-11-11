//
//  ViewController.m
//  web browser
//
//  Created by Alberto Scampini on 29/10/14.
//  Copyright (c) 2014 Alberto Scampini. All rights reserved.
//

#import "ViewController.h"
#import "UIViewMain.h"
#import "UIViewNavigationBar.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // create and add main view in full screen size
    _mainBrowserView=[[UIViewMain alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_mainBrowserView];
    
    _browserNavigationBar=[[UIViewNavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    [self.view addSubview:_browserNavigationBar];
    
    //add gesture recognizer in this view,
    //to hide and show the navigation bar
    UITapGestureRecognizer *singleTapDoubleTouches = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDoubleTouches:)];
    //[swipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
    singleTapDoubleTouches.numberOfTouchesRequired=2;
    [singleTapDoubleTouches setDelaysTouchesBegan:YES];
    [[self view] addGestureRecognizer:singleTapDoubleTouches];
    //remove gesture from sub viwes
    [_mainBrowserView removeGestureRecognizer:singleTapDoubleTouches];
    //load first Web Page
    [self openFirstWebPage];
    
    //set the flag used to manage the transition from fullscreen to classic view (with statusbar)
    _isfullScreenModeActive=false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)openFirstWebPage{
    NSString *firstPageUrl=@"http://www.google.it";
    [_browserNavigationBar setWebsiteUrlForBar:firstPageUrl];
    [_mainBrowserView setWebsiteUrlForBrowser:firstPageUrl];
}

#pragma gesture for navigation bar
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)tapDoubleTouches:(UITapGestureRecognizer *)recognizer{
    //gestion for switching between fullscreen and normal visualization
    if(_isfullScreenModeActive==false){
        [_browserNavigationBar hideBarWithAnimation];
        [_mainBrowserView switchOnFullScreenMode];
        _isfullScreenModeActive=true;
    }else{
        [_browserNavigationBar showBarWithAnimation];
        [_mainBrowserView switchOffFullScreenMode];
        _isfullScreenModeActive=false;
    }
}


@end