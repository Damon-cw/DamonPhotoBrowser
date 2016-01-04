//
//  TableViewCell.h
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


@protocol TableViewCellDelegate;

@interface TableViewCell : UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *imageArr;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier rowHeight:(CGFloat)rowHeight;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewFlowLayout;

@end


@protocol TableViewCellDelegate <NSObject>

- (void)deleteBtnClicked:(NSInteger)index;

@end
