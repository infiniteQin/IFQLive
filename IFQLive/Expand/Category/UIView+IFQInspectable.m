//
//  UIView+XQInspectable.m
//  XiangQu
//
//  Created by taizi on 16/8/12.
//  Copyright © 2016年 Qiuyin. All rights reserved.
//

#import "UIView+IFQInspectable.h"

@implementation UIView (IFQInspectable)

- (void)setIfq_CornerRadius:(CGFloat)cornerRadius {
    if (cornerRadius != 0) {
        self.layer.masksToBounds = YES;
    }
    self.layer.cornerRadius = cornerRadius;
}

- (CGFloat)ifq_CornerRadius {
    return self.layer.cornerRadius;
}

- (void)setIfq_BorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

-(UIColor *)ifq_BorderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setIfq_BorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)ifq_BorderWidth {
    return self.layer.borderWidth;
}

- (void)setIfq_masksToBounds:(BOOL)masksToBounds {
    self.layer.masksToBounds = masksToBounds;
}

- (BOOL)ifq_masksToBounds {
    return self.layer.masksToBounds;
}

@end
