//
//  NSHistory.h
//  web browser
//
//  Created by Alberto Scampini on 11/11/14.
//  Copyright (c) 2014 Alberto Scampini. All rights reserved.
//

@import Foundation;

@interface NSPageHistory : NSObject{
    NSString *pagePreviewPictureName;
    NSString *pageTitle;
    NSString *pageUrl;
}

@property (strong, nonatomic) NSString *pagePreviewPictureName;
@property (strong, nonatomic) NSString *pageTitle;
@property (strong, nonatomic) NSString *pageUrl;

@end