//
//  UIViewHistoryList.h
//  web browser
//
//  Created by Alberto Scampini on 11/11/14.
//  Copyright (c) 2014 Alberto Scampini. All rights reserved.
//

@import Foundation;
@import UIKit;

@protocol UIWiewHistoryDelegate <NSObject>
- (void)selectedHistoryUrl:(NSString *)Url;//used to notify the parent that I've selected one item from the history list
@end

@class NSHistoryManager;
@class NSPageHistory;

@interface UIViewHistoryList : UIView <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,retain)UICollectionView *historyListCollection;
@property(nonatomic)int numberOfPagesInHistory;
@property (nonatomic, unsafe_unretained) id <UIWiewHistoryDelegate> delegate;

@end
