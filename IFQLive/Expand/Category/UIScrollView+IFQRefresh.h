//
//  UIScrollView+IFQRefresh.h
//  IFQLive
//
//  Created by taizi on 16/9/12.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^IFQStartFreshBlock)();

@interface UIScrollView (IFQRefresh)

- (void)addPullToRefreshView:(IFQStartFreshBlock)freshBlock;

- (void)endPullAnimator;

@end
