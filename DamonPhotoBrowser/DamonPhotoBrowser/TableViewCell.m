//
//  TableViewCell.m
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
// 屏幕的宽
#define kDamon_ScreenWidth [UIScreen mainScreen].bounds.size.width
// 屏幕的高
#define  kDamon_ScreenHeight [UIScreen mainScreen].bounds.size.height

#import "TableViewCell.h"
#import "CollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "DamonPhotoBrowser.h"

@interface TableViewCell()<DamonPhotoBrowserDelegate>

@end

@implementation TableViewCell




- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier rowHeight:(CGFloat)rowHeight
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageArr = [NSMutableArray array];
        self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y, self.contentView.frame.size.width, rowHeight);

        [self.contentView addSubview:[self collectionView]];
    }
    return self;
    
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        CGFloat height = (kDamon_ScreenWidth - 30) / 3.0;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kDamon_ScreenWidth, height * 2 + 25) collectionViewLayout:[self collectionViewFlowLayout]];
        [collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewcellReuse"];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
        collectionView.scrollsToTop = NO;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        _collectionView = collectionView;
    }
    return _collectionView;
}


- (UICollectionViewFlowLayout *)collectionViewFlowLayout
{
    
    if (!_collectionViewFlowLayout) {
        CGFloat height = (kDamon_ScreenWidth - 30) / 3.0;
        
        UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        collectionViewFlowLayout.itemSize = CGSizeMake(height, height);
        
        collectionViewFlowLayout.minimumLineSpacing = 5;
        collectionViewFlowLayout.minimumInteritemSpacing = 5;
        _collectionViewFlowLayout = collectionViewFlowLayout;
    }
    return _collectionViewFlowLayout;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArr.count;
    // return self.picImageArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewcellReuse" forIndexPath:indexPath];
    
    NSString *url = [self.imageArr objectAtIndex:indexPath.item];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [cell.iconImageView sd_setImageWithURL: [NSURL URLWithString: url]placeholderImage:nil];
    cell.iconImageView.userInteractionEnabled = YES;

    cell.iconImageView.tag = indexPath.item;
    cell.indexPath = indexPath;
    //cell.contentView.backgroundColor = DTRedColor;
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
        CollectionViewCell *photoCell=(CollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    NSArray *visibleCells = collectionView.visibleCells;

    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"indexPath" ascending:YES];
    visibleCells = [visibleCells sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];


    NSMutableArray* imageViews=[NSMutableArray array];
    [visibleCells enumerateObjectsUsingBlock:^(CollectionViewCell* cell, NSUInteger idx, BOOL *stop) {
        [imageViews addObject:cell.iconImageView];
    }];

    NSLog(@"选中的个数%ld, 选中的下标:%ld", imageViews.count, indexPath.item);
    
    DamonPhotoBrowser *photoBrowser = [[DamonPhotoBrowser alloc] init];
    photoBrowser.delegate = self;
    [photoBrowser showWithImageViews:imageViews selectedView:photoCell.iconImageView];
    
}


- (void)imageViewer:(DamonPhotoBrowser *)imageViewer didShowImageView:(UIImageView *)selectedView atIndex:(NSInteger)index
{
    [selectedView sd_setImageWithURL:[NSURL URLWithString:[_imageArr objectAtIndex:index]] placeholderImage:selectedView.image completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

    }];
    NSLog(@"%ld", index);
}

- (void)imageViewer:(DamonPhotoBrowser *)imageViewer willDismissWithSelectedView:(UIImageView *)selectedView
{
    
    
}

- (void)setImageArr:(NSMutableArray *)imageArr
{
    if (_imageArr != imageArr) {
        _imageArr = imageArr;
    }

    CGFloat height = (kDamon_ScreenWidth - 30) / 3.0;
    
    self.collectionView.frame = CGRectMake(self.collectionView.frame.origin.x, self.collectionView.frame.origin.y, self.collectionView.frame.size.width,  height * ceil(_imageArr.count / 3.0) + 25);
        [self.collectionView reloadData];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
