//
//  PageControl.h
//  MyDreamTown
//
//  Created by Damon on 15/7/19.
//  Copyright (c) 2015年 Damon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PageControlDelegate<NSObject>
@optional
- (void)pageControlDidStopAtIndex:(NSInteger)index;
@end


@interface PageControl : UIView
@property(nonatomic, assign) NSInteger numberOfPages;
@property(nonatomic, strong) UIImage* dotNormalImage;
@property(nonatomic, strong) UIImage* dotHighlightedImage;
@property(nonatomic, assign) id<PageControlDelegate> delegate;
@property BOOL showJude;
- (void)setCurrentPage:(NSInteger)pages;


@end
