//
//  UIViewHistoryList.m
//  web browser
//
//  Created by Alberto Scampini on 11/11/14.
//  Copyright (c) 2014 Alberto Scampini. All rights reserved.
//

#import "UIViewHistoryList.h"
#import "NSHistoryManager.h"
#import "NSPageHistory.h"
#import "Cell.h"


@implementation UIViewHistoryList
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //Initialization code for the UICollectionView
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
        _historyListCollection=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height) collectionViewLayout:layout];
        [_historyListCollection registerClass:[Cell class] forCellWithReuseIdentifier:@"CellID"];
        _historyListCollection.delegate=self;
        _historyListCollection.dataSource=self;
        [self addSubview:_historyListCollection];
        
        NSHistoryManager * historyManagerSaver=[[NSHistoryManager alloc]init];
        _numberOfPagesInHistory=[historyManagerSaver contPagesHistory];

    }
    return self;
}

#pragma collection view methods


- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    return _numberOfPagesInHistory;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // we're going to use a custom UICollectionViewCell, which will hold an image and its label
    //
    Cell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"CellID" forIndexPath:indexPath];
    
    //load page informations from data model
    NSHistoryManager * historyManagerSaver=[[NSHistoryManager alloc]init];
    NSPageHistory * currentPageInformations=[historyManagerSaver loadPageHistoryFromIndex:(_numberOfPagesInHistory-(int)indexPath.row-1)];
    
    NSLog(@"load-> %@ , %@",currentPageInformations.pagePreviewPictureName,currentPageInformations.pageTitle);
    
    //load picture
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileURL = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",currentPageInformations.pagePreviewPictureName]];
    UIImage* image = [UIImage imageWithContentsOfFile:fileURL];
    
    //display picture preview
    [cell setPicture:image];
    
    //display title
    [cell setTitleLabel:currentPageInformations.pageTitle];
    
    return cell;
}

// the user tapped a collection item, load and set the image on the detail view controller

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //load page informations from data model
    NSHistoryManager * historyManagerSaver=[[NSHistoryManager alloc]init];
    NSPageHistory * currentPageInformations=[historyManagerSaver loadPageHistoryFromIndex:(_numberOfPagesInHistory-(int)indexPath.row-1)];
    [delegate selectedHistoryUrl:currentPageInformations.pageUrl];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.frame.size.width-10, self.frame.size.width/2);
}

@end
