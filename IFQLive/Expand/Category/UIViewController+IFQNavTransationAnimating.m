//
//  UIViewController+IFQNavTransationAnimating.m
//  IFQLive
//
//  Created by taizi on 16/9/29.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import "UIViewController+IFQNavTransationAnimating.h"
#import "IFQMethodSwizzle.h"

@implementation UIViewController (IFQNavTransationAnimating)

+ (void)load {
    IFQSwizzleMethod(self,@selector(viewDidLoad),@selector(ifq_viewDidLoad));
    IFQSwizzleMethod(self,@selector(viewDidAppear:),@selector(ifqNavTransAni_viewDidAppear:));
    IFQSwizzleMethod(self,@selector(viewDidDisappear:),@selector(ifqNavTransAni_viewDidDisappear:));
}

- (void)ifq_viewDidLoad {
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    [self ifq_viewDidLoad];
}


- (void)ifqNavTransAni_viewDidAppear:(BOOL)animated {
    self.ifq_navTransationAnimating = NO;
    [self ifqNavTransAni_viewDidAppear:animated];
}

- (void)ifqNavTransAni_viewDidDisappear:(BOOL)animated {
    self.ifq_navTransationAnimating = NO;
    [self ifqNavTransAni_viewDidDisappear:animated];
}


- (void)setIfq_navTransationAnimating:(BOOL)animating {
    objc_setAssociatedObject(self, @selector(ifq_navTransationAnimating), @(animating), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)ifq_navTransationAnimating {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

@end
