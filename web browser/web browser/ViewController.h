//
//  ViewController.h
//  web browser
//
//  Created by Alberto Scampini on 29/10/14.
//  Copyright (c) 2014 Alberto Scampini. All rights reserved.
//

@import UIKit;
#import "UIViewMain.h"
#import "UIViewNavigationBar.h"
#import "UIViewHistoryList.h"

@class UIViewMain;
@class UIViewNavigationBar;
@class UIViewHistoryList;

@interface ViewController : UIViewController<UIWiewMainDelegate,UIWiewNavigationBarDelegate,UIWiewHistoryDelegate>

@property (nonatomic) UIViewMain *mainBrowserView;
@property (nonatomic) UIViewNavigationBar *browserNavigationBar;
@property (nonatomic) UIViewHistoryList *historyList;
@property (nonatomic)BOOL isHistoryViewShown;
@property (nonatomic)BOOL isfullScreenModeActive;

@end