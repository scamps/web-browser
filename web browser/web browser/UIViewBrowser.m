//
//  UIViewBrowser.m
//  web browser
//
//  Created by Alberto Scampini on 29/10/14.
//  Copyright (c) 2014 Alberto Scampini. All rights reserved.
//

#import "UIViewBrowser.h"
#import "NSHistoryManager.h"
#import "NSPageHistory.h"

@implementation UIViewBrowser
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

#pragma UIWebView navigation methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    _currentUrl= [[request URL] absoluteString];
    //notify the address changing on parent view, to update the addres in the navigation bar
    [delegate changedWebUrl:_currentUrl];
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //update current url
    _currentUrl= webView.request.URL.absoluteString;
    //notify the address changing on parent view, to update the addres in the navigation bar
    [delegate changedWebUrl:_currentUrl];
    
    //I make the timer start, if the page is nor readdressed in less than 1.5 second i save it in the history with screenshot and all the informations required
    [_timerSave invalidate];
    _timerSave=nil;
    _timerSave=[NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(savePageInHistory) userInfo:nil repeats:YES];
}

- (void)savePageInHistory{
    //save the screenshot of the page
    UIImage *image = [[UIImage alloc] init];
    image=[self captureScreen:_webBrowserPage];
    
    //load image number-name
    int lastPictureNumber=(int)[[[NSUserDefaults standardUserDefaults] objectForKey:@"lastPictureNumber"] integerValue];
    
    //find the path where to save the pictures
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileURL = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.jpg",lastPictureNumber]];
    
    // If you go to the folder below, you will find those pictures
    NSData *data2 = [NSData dataWithData:UIImageJPEGRepresentation(image, 0.2f)];//compress the quality
    [data2 writeToFile:fileURL atomically:YES];
    
    //load informations and store that in NSPageHistory object
    NSPageHistory * currentPageInformations=[[NSPageHistory alloc]init];
    currentPageInformations.pageTitle=[_webBrowserPage stringByEvaluatingJavaScriptFromString:@"document.title"];
    currentPageInformations.pageUrl=_currentUrl;
    currentPageInformations.pagePreviewPictureName=[NSString stringWithFormat:@"%d",lastPictureNumber];
    
    //save page informations to data model
    NSHistoryManager * historyManagerSaver=[[NSHistoryManager alloc]init];
    [historyManagerSaver addPageHistory:currentPageInformations];
    
    //update picture number-name for the next picture to save
    //save the new data
    lastPictureNumber=lastPictureNumber+1;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSString stringWithFormat:@"%d",lastPictureNumber]  forKey:@"lastPictureNumber"];
    [defaults synchronize];
    
    [_timerSave invalidate];
    _timerSave=nil;
}

-(UIImage*)captureScreen:(UIView*) viewToCapture
{
    UIGraphicsBeginImageContext(viewToCapture.bounds.size);
    [viewToCapture.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

@end
