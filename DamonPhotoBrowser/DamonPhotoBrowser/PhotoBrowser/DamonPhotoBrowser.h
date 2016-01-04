//
//  DamonPhotoBrowser.h
//  FamilyWealth-iPhone
//
//  Created by acer_mac on 14/1/3.
//  Copyright © 2014年 Damon. All rights reserved.
//
/*
 
 作者: 崔嵬
 Q Q: 525643907
 邮箱: cuiwei_0408@163.com
 注: 欢迎互相学习与交流.
 
 */
#import <UIKit/UIKit.h>

@protocol DamonPhotoBrowserDelegate;


@interface DamonPhotoBrowser : UIViewController

@property (nonatomic, strong) NSArray *photos;

@property (nonatomic, assign) NSUInteger currentPhotoIndex;

@property (nonatomic, assign) id<DamonPhotoBrowserDelegate> delegate;

- (void)show;

- (void)showWithImageViews:(NSArray*)views selectedView:(UIImageView*)selectedView;

@end

@protocol DamonPhotoBrowserDelegate <NSObject>

- (void)imageViewer:(DamonPhotoBrowser *)imageViewer  didShowImageView:(UIImageView*)selectedView atIndex:(NSInteger)index;
- (void)imageViewer:(DamonPhotoBrowser *)imageViewer  willDismissWithSelectedView:(UIImageView*)selectedView;

@end

