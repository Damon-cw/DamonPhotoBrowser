//
//  DamonViewState.m
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
#import "DamonViewState.h"

@implementation DamonViewState


+ (DamonViewState *)viewStateForView:(UIView *)view {
    static NSMutableDictionary *dict = nil;
    if(dict == nil) {
        dict = [NSMutableDictionary dictionary];
    }
    
    DamonViewState *state = dict[@(view.hash)];
    if(state == nil) {
        state = [[self alloc] init];
        dict[@(view.hash)] = state;
    }
    return state;
}

- (void)setStateWithView:(UIView *)view {
    CGAffineTransform trans = view.transform;
    view.transform = CGAffineTransformIdentity;
    
    self.superview = view.superview;
    self.frame     = view.frame;
    self.transform = trans;
    self.userInteratctionEnabled = view.userInteractionEnabled;
    
    view.transform = trans;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
