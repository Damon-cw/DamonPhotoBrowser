//
//  DamonZoomImageView.h
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

@interface DamonZoomImageView : UIView

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView;
- (void)resumeImageView;

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)image;

@end
