//
//  DamonZoomImageView.h
//  FamilyWealth-iPhone
//
//  Created by acer_mac on 14/1/3.
//  Copyright © 2014年 Damon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DamonZoomImageView : UIView

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView;
- (void)resumeImageView;

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)image;

@end
