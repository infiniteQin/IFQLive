//
//  UINavigationController+IFQTransation.m
//  IFQLive
//
//  Created by taizi on 16/9/27.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import "UINavigationController+IFQTransation.h"
#import "IFQMethodSwizzle.h"
#import "UIViewController+IFQNavTransationAnimating.h"


@implementation UINavigationController (IFQTransation)

+ (void)load {
//    [super load];
    // 通过class_getInstanceMethod()函数从当前对象中的method list获取method结构体，如果是类方法就使用class_getClassMethod()函数获取。
//    Method fromMethod = class_getInstanceMethod([self class], @selector(viewDidLoad));
//    Method toMethod = class_getInstanceMethod([self class], @selector(swizzlingViewDidLoad));
    
    IFQSwizzleMethod(self, @selector(viewDidLoad), @selector(ifq_viewDidLoad));
    IFQSwizzleMethod(self, @selector(pushViewController:animated:), @selector(ifq_swizzle_pushViewController:animated:));
    IFQSwizzleMethod(self, @selector(popViewControllerAnimated:), @selector(ifq_swizzle_popViewControllerAnimated:));
}

- (void)ifq_viewDidLoad {
    
    [self ifq_viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
}

#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count<=1) {
        return NO;
    }
    return YES;
}

- (void)ifq_swizzle_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.topViewController.ifq_navTransationAnimating) {
        return;
    }
    self.topViewController.ifq_navTransationAnimating = YES;
    viewController.ifq_navTransationAnimating = YES;
    [self ifq_swizzle_pushViewController:viewController animated:animated];
}

- (UIViewController *)ifq_swizzle_popViewControllerAnimated:(BOOL)animated {
    if (self.topViewController.ifq_navTransationAnimating) {
        return nil;
    }
    self.topViewController.ifq_navTransationAnimating = YES;
    return [self ifq_swizzle_popViewControllerAnimated:animated];
    
}


@end
