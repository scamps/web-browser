//
//  ViewController.m
//  web browser
//
//  Created by Alberto Scampini on 29/10/14.
//  Copyright (c) 2014 Alberto Scampini. All rights reserved.
//

#import "ViewController.h"
#import "UIViewMain.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // create and add main view in full screen size
    _webBrowserView=[[UIViewMain alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_webBrowserView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
