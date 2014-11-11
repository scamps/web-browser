//
//  ViewController.h
//  web browser
//
//  Created by Alberto Scampini on 29/10/14.
//  Copyright (c) 2014 Alberto Scampini. All rights reserved.
//

@import UIKit;

@class UIViewMain;
@class UIViewNavigationBar;

@interface ViewController : UIViewController

@property (nonatomic) UIViewMain *mainBrowserView;
@property (nonatomic) UIViewNavigationBar *browserNavigationBar;
@property(nonatomic)BOOL isfullScreenModeActive;

@end