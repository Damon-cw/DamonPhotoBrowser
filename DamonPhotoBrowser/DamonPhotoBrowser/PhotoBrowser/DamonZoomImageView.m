//
//  DamonZoomImageView.m
//  FamilyWealth-iPhone
//
//  Created by acer_mac on 14/1/3.
//  Copyright © 2014年 Damon. All rights reserved.
//

#import "DamonZoomImageView.h"
#import "UIImageView+WebCache.h"
@interface DamonZoomImageView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;

@end

@implementation DamonZoomImageView
@synthesize imageView = _imageView;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:[self scrollView]];
        
    }
    
    return self;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.frame = self.bounds;
        scrollView.backgroundColor = [UIColor blackColor];
        scrollView.delegate = self;
        scrollView.scrollEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.bounces = NO;
        scrollView.bouncesZoom = NO;
        scrollView.minimumZoomScale = 1;
        scrollView.maximumZoomScale = 2;
        scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        
         self.contentView = [[UIView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:[self imageView]];
        [scrollView addSubview:self.contentView];
//        scrollView.zoomScale = 2;
//        scrollView.contentOffset = CGPointZero;
        self.contentView.bounds = self.imageView.bounds;
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = self.bounds;
        imageView.backgroundColor = [UIColor blackColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageNamed:@"9910dd826d5be993972906e9baf59308.png"];
        _imageView = imageView;
    }
    return _imageView;
}

- (void)setImageView:(UIImageView *)imageView
{
    if (_imageView != imageView) {
        _imageView = imageView;
    }
    [self setNeedsDisplay];
}

- (void)setImage:(UIImage *)image
{
    if (_image != image) {
        _image = image;
    }
    
    _imageView.image = image;
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.contentView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale
{
    
    //[self centerScrollViewContents];
    
    // 图片的高 和高
    
//    CGFloat imageHeight = _imageView.image.size.height *  SCREENWIDTH / _imageView.image.size.width;
//    
//    
//    DJLog(@"放大缩小的倍数:%f", scale);
//    DJLog(@"imageViewHeight:%f---imageViewWidth:%f", view.height, view.width);
//    _imageView.height = imageHeight * scale;
//    _imageView.center = CGPointMake(scrollView.width * scale / 2.0, SCREENHEIGHT / 2.0);
//    scrollView.contentSize = CGSizeMake(scrollView.width * scale, SCREENHEIGHT);
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{


}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat Ws = _scrollView.frame.size.width - _scrollView.contentInset.left - _scrollView.contentInset.right;
    CGFloat Hs = _scrollView.frame.size.height - _scrollView.contentInset.top - _scrollView.contentInset.bottom;
    CGFloat W = _contentView.frame.size.width;
    CGFloat H = _contentView.frame.size.height;
    
    CGRect rct = _contentView.frame;
    rct.origin.x = MAX((Ws-W)/2, 0);
    rct.origin.y = MAX((Hs-H)/2, 0);
    _contentView.frame = rct;

   // [self centerScrollViewContents];
  //  DJLog(@"宽度;%f---高度:%f", scrollView.contentSize.width, scrollView.contentSize.height);
//    float scale = scrollView.contentSize.width / scrollView.width;
//     _imageView.center = CGPointMake(scrollView.width * scale / 2.0, scrollView.contentSize.height / 2.0);
    
}

- (void)centerScrollViewContents {
    
    CGSize boundsSize = self.scrollView.bounds.size;
    
    CGRect contentsFrame = self.imageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.imageView.frame = contentsFrame;
    self.scrollView.contentSize =  CGSizeMake(self.imageView.frame.size.width, self.imageView.frame.size.height);
}

- (void)resumeImageView
{
    
    [self.scrollView zoomToRect:self.scrollView.frame animated:YES];
    
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)image
{
//    [self.imageView sd_setImageWithURL:url placeholderImage:image];
    [self.imageView sd_setImageWithURL:url placeholderImage:image completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        _imageView.image = image;
        
    }];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
