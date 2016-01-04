//
//  PageControl.m
//  MyDreamTown
//
//  Created by Damon on 15/7/19.
//  Copyright (c) 2015年 Damon. All rights reserved.
//

#import "PageControl.h"
// 屏幕的宽
#define kDamon_ScreenWidth [UIScreen mainScreen].bounds.size.width
// 屏幕的高
#define  kDamon_ScreenHeight [UIScreen mainScreen].bounds.size.height
#define kDamon_IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define kDamonPageControlDotGap  (kDamon_IS_IPAD ? 8.0 : 6.0)
#define kDamonPageControlDotSize (kDamon_IS_IPAD ? 8.0 : 6.0)

@interface PageControl ()
@property (nonatomic, strong) UIImageView* dotHighlightedImageView;
- (void)dotDidTouched:(UIView*)sender;
@end


@implementation PageControl

@synthesize delegate = _delegate;
@synthesize dotNormalImage = _dotNormalImage;
@synthesize dotHighlightedImage = _dotHighlightedImage;
@synthesize dotHighlightedImageView = _dotHighlightedImageView;
@synthesize numberOfPages = _numberOfPages;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    if (_numberOfPages != numberOfPages) {
        _numberOfPages = numberOfPages;
        
        [self removeAllSubviews];
        
        if (!_dotNormalImage) {
            _dotNormalImage = [UIImage imageNamed:@"page_state_normal1"];
        }
        
        if (!_dotHighlightedImage) {
            _dotHighlightedImage = [UIImage imageNamed:@"page_state_highlight1"];
        }
        
        
        [self dotHighlightedImageView];
        
        float originX=[self getDotOriginX];
        for (int index = 0; index < _numberOfPages; index++) {
            UIImageView* dotNormalImageView = [[UIImageView alloc] init];
            dotNormalImageView.userInteractionEnabled = YES;
            dotNormalImageView.frame = CGRectMake(originX + (kDamonPageControlDotSize + kDamonPageControlDotGap) * index, 0.f, kDamonPageControlDotSize, kDamonPageControlDotSize);
            dotNormalImageView.tag = index;
            if (index == 0) {
                self.dotHighlightedImageView.frame = CGRectMake(originX + (kDamonPageControlDotSize + kDamonPageControlDotGap) * index, 0.f, kDamonPageControlDotSize, kDamonPageControlDotSize);
            }
            
            dotNormalImageView.image = _dotNormalImage;
            [dotNormalImageView.layer setMasksToBounds:NO];
            
            UITapGestureRecognizer* gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                                action:@selector(dotDidTouched:)];
            [dotNormalImageView addGestureRecognizer:gestureRecognizer];
            
            [self addSubview:dotNormalImageView];
        }
        [self addSubview:[self dotHighlightedImageView]];
    }
}

- (UIImageView*)dotHighlightedImageView
{
    if (!_dotHighlightedImageView) {
        _dotHighlightedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, kDamonPageControlDotSize, kDamonPageControlDotSize)];
        [_dotHighlightedImageView.layer setMasksToBounds:NO];
        [_dotHighlightedImageView setImage:_dotHighlightedImage];
    }
    
    return _dotHighlightedImageView;
}

- (void)dotDidTouched:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(pageControlDidStopAtIndex:)]) {
        [_delegate pageControlDidStopAtIndex:[sender view].tag];
    }
}
- (void)setCurrentPage:(NSInteger)pages
{
    if (_dotNormalImage || _dotHighlightedImage) {
        float originX=[self getDotOriginX];
        
        CGRect newRect;
        if (kDamon_IS_IPAD) {
            newRect = CGRectMake((kDamonPageControlDotSize + kDamonPageControlDotGap) * pages + originX, 0.f, kDamonPageControlDotSize, kDamonPageControlDotSize);
        }else{
            newRect = CGRectMake((kDamonPageControlDotSize + kDamonPageControlDotGap) * pages + originX, 0.f, kDamonPageControlDotSize, kDamonPageControlDotSize);
            
        }
        self.dotHighlightedImageView.frame = newRect;
        
    }
}

- (float)getDotOriginX
{
    float originX=0.0;
    if (_showJude == NO) {
        
        originX = (kDamon_ScreenWidth - (kDamonPageControlDotGap * (_numberOfPages - 1) + kDamonPageControlDotSize * _numberOfPages)) / 2.f;
    }else{
        originX = (kDamon_ScreenWidth - (kDamonPageControlDotGap * (_numberOfPages - 1) + kDamonPageControlDotSize * _numberOfPages)) / 2.f;
    }
    
    return originX;
}


- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

@end
