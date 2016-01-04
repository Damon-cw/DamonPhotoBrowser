//
//  DamonPhotoBrowser.m
//  FamilyWealth-iPhone
//
//  Created by acer_mac on 14/1/3.
//  Copyright © 2014年 Damon. All rights reserved.
//
// 屏幕的宽
#define kDamon_ScreenWidth [UIScreen mainScreen].bounds.size.width
// 屏幕的高
#define  kDamon_ScreenHeight [UIScreen mainScreen].bounds.size.height
#define kDamonPhotoViewPadding 5
#define kDamonPhotoViewTagOffset 1000
#define kDamonPhotoViewIndex(photoView) ([photoView tag] - kDamonPhotoViewTagOffset)

#import "DamonPhotoBrowser.h"
#import "PageControl.h"
#import "DamonZoomImageView.h"
#import "DamonViewState.h"
@interface DamonPhotoBrowser()<UIScrollViewDelegate>
{
    NSMutableSet *_visiblePhotosViews;
    NSMutableSet *_resusablePhotoViews;
    BOOL _isStatusBarHidden;
    NSArray *_imgViews;
    
}
@property (nonatomic, strong) UIScrollView *photoScrollView;
@property (nonatomic, strong) PageControl *pageControl;
@end

@implementation DamonPhotoBrowser
@synthesize photoScrollView = _photoScrollView;
@synthesize pageControl = _pageControl;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        _isStatusBarHidden = [UIApplication sharedApplication].isStatusBarHidden;
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
        self.view.backgroundColor = [UIColor blackColor];
        self.view.alpha = 0.5;
        [self.view addSubview:[self photoScrollView]];
        [self.view addSubview:[self pageControl]];
        
    }
    return self;
}

- (UIScrollView *)photoScrollView
{
    if (!_photoScrollView) {
        CGRect frame = self.view.bounds;
        frame.origin.x -= kDamonPhotoViewPadding;
        frame.size.width += (2 * kDamonPhotoViewPadding);
        _photoScrollView = [[UIScrollView alloc] initWithFrame:frame];
       // _photoScrollView.clipsToBounds = NO;
        _photoScrollView.pagingEnabled = YES;
        _photoScrollView.delegate = self;
        _photoScrollView.userInteractionEnabled = YES;
        _photoScrollView.showsHorizontalScrollIndicator = NO;
        _photoScrollView.showsVerticalScrollIndicator = NO;
        _photoScrollView.backgroundColor = [UIColor blackColor];
        
    }
    
    return _photoScrollView;
}

- (PageControl*)pageControl
{
    if (!_pageControl)
    {
        CGRect rect = self.view.bounds;
        rect.origin.y = rect.size.height - 15;
        rect.size.height = 10;
        _pageControl = [[PageControl alloc] initWithFrame:rect];
        _pageControl.showJude =YES;
        _pageControl.userInteractionEnabled = NO;
    }
    
    return _pageControl;
}

- (void)setPhotos:(NSArray *)photos
{
    if (_photos != photos) {
        _photos = photos;
        [self loadPhotoViews];
    }
}

- (void)loadPhotoViews
{
    CGFloat viewWidth = kDamon_ScreenWidth;
    CGFloat viewHeight = kDamon_ScreenHeight;
    NSInteger count = [_photos count];
    [_photoScrollView setContentSize:CGSizeMake(count * (viewWidth + kDamonPhotoViewPadding * 2), viewHeight)];
    
    _photoScrollView.backgroundColor  = [UIColor blackColor];
    _pageControl.numberOfPages = count;
    [_pageControl setCurrentPage:self.currentPhotoIndex];
    
    for (int index = 0; index < count; index++) {
        
        DamonZoomImageView *imageView = [[DamonZoomImageView alloc] initWithFrame:CGRectMake(kDamonPhotoViewPadding + index * (viewWidth + 2 * kDamonPhotoViewPadding), 0.f, viewWidth, viewHeight)];

        NSString *url = [_photos objectAtIndex:index];
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        
        [imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
//        [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"img_zhanshi"]];

        imageView.userInteractionEnabled = YES;
        imageView.tag = 1000 + index;
        UITapGestureRecognizer *onceTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleOnceTap:)];
        onceTap.delaysTouchesBegan = YES;
        onceTap.numberOfTapsRequired = 1;
        [imageView addGestureRecognizer:onceTap];

        [_photoScrollView addSubview:imageView];
    }
    
    [self updateToolbarStatus];
}

- (void)setCurrentPhotoIndex:(NSUInteger)currentPhotoIndex
{
    _currentPhotoIndex = currentPhotoIndex;
    
    if ([self isViewLoaded]) {
        _photoScrollView.contentOffset = CGPointMake(_currentPhotoIndex * _photoScrollView.frame.size.width, 0);
    }
}

- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.view];
    
    [window.rootViewController addChildViewController:self];
}


- (void)setImageViewsFromArray:(NSArray*)views {
    NSMutableArray *imgViews = [NSMutableArray array];
    for(id obj in views) {
        if([obj isKindOfClass:[UIImageView class]]) {
            [imgViews addObject:obj];
            
            UIImageView *view = obj;
            
            DamonViewState *state = [DamonViewState viewStateForView:view];
            [state setStateWithView:view];
            
            view.userInteractionEnabled = NO;
        }
    }
    _imgViews = imgViews;
    _pageControl.numberOfPages = _imgViews.count;
    
    [_pageControl setCurrentPage:self.currentPhotoIndex];
}

- (void)showWithImageViews:(NSArray*)views selectedView:(UIImageView*)selectedView {
     const NSInteger currentPage = [_imgViews indexOfObject:selectedView];
    self.currentPhotoIndex = currentPage;
    [self setImageViewsFromArray:views];
    
    if(_imgViews.count > 0) {
        if(![selectedView isKindOfClass:[UIImageView class]] || ![_imgViews containsObject:selectedView]){
            selectedView = _imgViews[0];
        }
        [self showWithSelectedView:selectedView];
    }
}

- (UIImageView *)currentView {
    
//   DamonZoomImageView *imageView = (DamonZoomImageView *)[self.view viewWithTag:self.currentPhotoIndex + 100];
//    return imageView.imageView;
    
    return [_imgViews objectAtIndex:self.currentPhotoIndex];
}

- (void)showWithSelectedView:(UIImageView *)selectedView {
    
    [_photoScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _photoScrollView.delegate = self;
    const NSInteger currentPage = [_imgViews indexOfObject:selectedView];
    [self.pageControl setCurrentPage:currentPage];
//    [self updateToolbarStatus];
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    [window addSubview:self.view];
    [window.rootViewController addChildViewController:self];

    
    const CGFloat fullW = window.frame.size.width;
    const CGFloat fullH = window.frame.size.height;
    
    selectedView.frame = [window convertRect:selectedView.frame fromView:selectedView.superview];
    [window addSubview:selectedView];
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         //_photoScrollView.alpha = 1;
                         self.view.alpha = 1;
                         window.rootViewController.view.transform = CGAffineTransformMakeScale(1, 1);
                         
                         selectedView.transform = CGAffineTransformIdentity;
                         
                         CGSize size = (selectedView.image) ? selectedView.image.size : selectedView.frame.size;
                         CGFloat ratio = MIN(fullW / size.width, fullH / size.height);
                         CGFloat W = ratio * size.width;
                         CGFloat H = ratio * size.height;
                         selectedView.frame = CGRectMake((fullW-W)/2, (fullH-H)/2, W, H);
                     }
                     completion:^(BOOL finished) {
                         
                         _photoScrollView.contentSize = CGSizeMake(_imgViews.count * (fullW + kDamonPhotoViewPadding * 2), 0);
                               //       _photoScrollView.contentSize = CGSizeMake(_imgViews.count *fullW, 0);
                        //_photoScrollView.contentOffset = CGPointMake(currentPage * fullW , 0);
                         [self setCurrentPhotoIndex:currentPage];
                         [self.pageControl setCurrentPage:currentPage];
                         UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedScrollView:)];
                         [_photoScrollView addGestureRecognizer:gesture];
                         int i = 100;
                         for(UIImageView *view in _imgViews){
                             view.transform = CGAffineTransformIdentity;
                             
                             CGSize size = (view.image) ? view.image.size : view.frame.size;
                             CGFloat ratio = MIN(fullW / size.width, fullH / size.height);
                             CGFloat W = ratio * size.width;
                             CGFloat H = ratio * size.height;
                             view.frame = CGRectMake((fullW-W)/2, (fullH-H)/2, W, H);
                            // view.backgroundColor = [UIColor brownColor];
                                 //     DamonZoomImageView *tmp = [[DamonZoomImageView alloc] initWithFrame:CGRectMake([_imgViews indexOfObject:view] * fullW, 0, fullW, fullH)];
                             
                             DamonZoomImageView *tmp = [[DamonZoomImageView alloc] initWithFrame:CGRectMake(kDamonPhotoViewPadding + [_imgViews indexOfObject:view] * (fullW + 2 * kDamonPhotoViewPadding), 0, fullW, fullH)];
//                             tmp.imageView = view;/
                             tmp.imageView.image = view.image;
                             tmp.tag = i;
                             i++;
                             //NSLog(@"%f, %f", tmp.frame.size.width, tmp.frame.origin.x);
                             [_photoScrollView addSubview:tmp];
                         }
                         if ([self.delegate respondsToSelector:@selector(imageViewer:didShowImageView:atIndex:)]) {
                             [self.delegate imageViewer:self didShowImageView:selectedView atIndex:self.currentPhotoIndex];
                         }
                        
                         [selectedView removeFromSuperview];
                     }
     ];
}

- (void)tappedScrollView:(UITapGestureRecognizer *)sender {
    [self prepareToDismiss];
    [self dismissWithAnimate];
}

- (void)prepareToDismiss {
    UIImageView *currentView = [self currentView];
    
    if([self.delegate respondsToSelector:@selector(imageViewer:willDismissWithSelectedView:)]) {
        [self.delegate imageViewer:self willDismissWithSelectedView:currentView];
    }
    
    for(UIImageView *view in _imgViews) {
        if(view != currentView) {
            DamonViewState *state = [DamonViewState viewStateForView:view];
            view.transform = CGAffineTransformIdentity;
            view.frame = state.frame;
            view.transform = state.transform;
            [state.superview addSubview:view];
        }
    }
}

- (void)dismissWithAnimate {
    UIImageView *currentView = [self currentView];
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    NSInteger i = [_imgViews indexOfObject:currentView];
    DamonZoomImageView *tmp = [self.view viewWithTag:i+100];
    NSLog(@"%@", tmp);
    NSLog(@"下标是:%ld", i);
    CGRect tmprct = [window convertRect:tmp.frame fromView:tmp.superview];
    
     NSLog(@"x:%f--y:%f--width:%f--height:%f", tmprct.origin.x, tmprct.origin.y, tmprct.size.width, tmprct.size.height);
    
    currentView.frame = tmprct;
    
    currentView.contentMode = UIViewContentModeScaleAspectFit;
    
    CGRect rct = currentView.frame;
    currentView.transform = CGAffineTransformIdentity;
   // currentView.frame = [window convertRect:rct fromView:currentView.superview];
    [window addSubview:currentView];
    NSLog(@"x:%f--y:%f--width:%f--height:%f", rct.origin.x, rct.origin.y, rct.size.width, rct.size.height);
   // NSLog(@"%@", currentView.superview);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.view.alpha = 0;
                    //     window.rootViewController.view.transform =  CGAffineTransformIdentity;
                         
                         DamonViewState *state = [DamonViewState viewStateForView:currentView];
                         NSLog(@"x:%f--y:%f--width:%f--height:%f", state.frame.origin.x, state.frame.origin.y, state.frame.size.width, state.frame.size.height);
                         currentView.frame = [window convertRect:state.frame fromView:state.superview];
                         NSLog(@"x:%f--y:%f--width:%f--height:%f", currentView.frame.origin.x, currentView.frame.origin.y, currentView.frame.size.width, currentView.frame.size.height);
//                         currentView.contentMode = state.contentMode;
                         currentView.transform = state.transform;
                     }
                     completion:^(BOOL finished) {
                         
                         DamonViewState *state = [DamonViewState viewStateForView:currentView];
                         currentView.contentMode = state.contentMode;
                         currentView.transform = CGAffineTransformIdentity;
                         currentView.frame = state.frame;
                         currentView.transform = state.transform;
                         [state.superview addSubview:currentView];
                         
                         for (UIView *view in _imgViews) {
                             DamonViewState *_state = [DamonViewState viewStateForView:view];
                             view.contentMode = _state.contentMode;
                             view.userInteractionEnabled = _state.userInteratctionEnabled;
                         }
                         
                         [self.view removeFromSuperview];
                     }
     ];
}


- (void)updateToolbarStatus
{
    
    NSInteger tempIndex = _photoScrollView.contentOffset.x / _photoScrollView.frame.size.width;

    if (_currentPhotoIndex != tempIndex) {
        DamonZoomImageView *imageView = [_imgViews objectAtIndex:tempIndex];
//        [imageView resumeImageView];
        _currentPhotoIndex = tempIndex;
        
            if ([self.delegate respondsToSelector:@selector(imageViewer:didShowImageView:atIndex:)]) {
                [self.delegate imageViewer:self didShowImageView:[self currentView] atIndex:self.currentPhotoIndex];
            }
      
        
        [_pageControl setCurrentPage:_currentPhotoIndex];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    [self updateToolbarStatus];
    
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
