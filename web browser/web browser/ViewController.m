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
#import "UIViewHistoryList.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // create and add main view in full screen size
    
    
    //load from memory the id of the last preview saved (if nil i know that it's the first time the app il launched)
    int lastPictureNumber=0;
    NSString *tempString = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastPictureNumber"];
    if(tempString==nil){
        //save the new data
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[NSString stringWithFormat:@"%d",lastPictureNumber]  forKey:@"first_year"];
        [defaults synchronize];
    }
    
    _mainBrowserView=[[UIViewMain alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _mainBrowserView.delegate=self;
    [self.view addSubview:_mainBrowserView];
    
    _browserNavigationBar=[[UIViewNavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    _browserNavigationBar.delegate=self;
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
    
    //the history list collection view is not open at launch
    _isHistoryViewShown=false;
    
    //set the flag used to manage the transition from fullscreen to classic view (with statusbar)
    _isfullScreenModeActive=false;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)openFirstWebPage
{
    NSString *firstPageUrl=@"http://www.google.it";
    [_browserNavigationBar setWebsiteUrlForBar:firstPageUrl];
    [_mainBrowserView setWebsiteUrlForBrowser:firstPageUrl];
}

#pragma gesture for navigation bar
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)tapDoubleTouches:(UITapGestureRecognizer *)recognizer
{
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

#pragma UIViewMain delegate methods

- (void)changeNavigationBarUrl:(NSString *)Url
{
    [_browserNavigationBar setWebsiteUrlForBar:Url];
}

#pragma UIViewNavigationBar delegate methods

- (void)clickedNavigationBarButtonAtIndex:(int)index
{
    //a button in the UIViewNavigationBar did click
    switch (index) {
        case 0:{//selected history button
            //show hide
            if(_isHistoryViewShown==false){
                //create history list
                _historyList=[[UIViewHistoryList alloc]initWithFrame:CGRectMake(0, 60, 300, self.view.frame.size.height-60)];
                _historyList.delegate=self;
                [self.view addSubview:_historyList];
                _isHistoryViewShown=true;
            }else{
                _isHistoryViewShown=false;
                //remove history list
                [_historyList removeFromSuperview];
            }
            break;}
        case 1:{//selected home button
            NSString *firstPageUrl=@"http://www.google.it";
            [_browserNavigationBar setWebsiteUrlForBar:firstPageUrl];
            [_mainBrowserView setWebsiteUrlForBrowser:firstPageUrl];
            break;}
        default:
            break;
    }
}

#pragma UIViewHistoryList delegate methods

- (void)selectedHistoryUrl:(NSString *)Url
{
    [_mainBrowserView setWebsiteUrlForBrowser:Url];
    _isHistoryViewShown=false;
    [_historyList removeFromSuperview];
}

@end