//
//  CollectionViewCell.m
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
#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:[self iconImageView]];

    }
    return self;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        UIImageView *iconImageView = [[UIImageView alloc] init];
        iconImageView.frame = self.contentView.bounds;
        iconImageView.center = self.contentView.center;
        iconImageView.userInteractionEnabled = NO;
        
        _iconImageView = iconImageView;
    }
    return _iconImageView;
}

@end
