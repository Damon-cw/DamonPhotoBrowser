//
//  DamonViewState.h
//  DamonPhotoBrowser
//
//  Created by acer_mac on 15/12/31.
//  Copyright © 2015年 Damon. All rights reserved.
//
/*
 
 作者: 崔嵬
 Q Q: 525643907
 邮箱: cuiwei_0408@163.com
 注: 欢迎互相学习与交流.
 
 */
#import <UIKit/UIKit.h>

@interface DamonViewState : UIView

@property (nonatomic, strong) UIView *superview;
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, assign) BOOL userInteratctionEnabled;
@property (nonatomic, assign) CGAffineTransform transform;

+ (DamonViewState *)viewStateForView:(UIView *)view;
- (void)setStateWithView:(UIView *)view;

@end
