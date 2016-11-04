//
//  UIScrollView+IFQRefresh.m
//  IFQLive
//
//  Created by taizi on 16/9/12.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import "UIScrollView+IFQRefresh.h"
#import "SDRefresh.h"
#import <objc/runtime.h>

static char const kRefreshHeaderViewAssKey;
static char const kRefreshBlockAssKey;

@implementation UIScrollView (IFQRefresh)

- (void)addPullToRefreshView:(IFQStartFreshBlock)freshBlock {
    SDRefreshHeaderView *refreshView = [[SDRefreshHeaderView alloc] init];
    objc_setAssociatedObject(self, &kRefreshHeaderViewAssKey, refreshView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(refreshView, &kRefreshBlockAssKey, freshBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [refreshView addToScrollView:self isEffectedByNavigationController:YES];
    [refreshView addTarget:self refreshAction:@selector(actionRefresh)];
}

- (void)endPullAnimator {
    SDRefreshHeaderView *refreshView = objc_getAssociatedObject(self, &kRefreshHeaderViewAssKey);
    if (refreshView) {
        [refreshView endRefreshing];
    }
}

- (void)actionRefresh {
    SDRefreshHeaderView *refreshView = objc_getAssociatedObject(self, &kRefreshHeaderViewAssKey);
    IFQStartFreshBlock freshBlock = objc_getAssociatedObject(refreshView, &kRefreshBlockAssKey);
    if (freshBlock) {
        freshBlock();
    }
}

@end
