//
//  NSHistory.m
//  web browser
//
//  Created by Alberto Scampini on 11/11/14.
//  Copyright (c) 2014 Alberto Scampini. All rights reserved.
//

#import "NSPageHistory.h"

@implementation NSPageHistory

@synthesize pagePreviewPictureName,pageTitle,pageUrl;

- (id)init {
    if ((self = [super init])) {
        pagePreviewPictureName=nil;
        pageTitle=nil;
        pageUrl=nil;
    }
    return self;
}

@end