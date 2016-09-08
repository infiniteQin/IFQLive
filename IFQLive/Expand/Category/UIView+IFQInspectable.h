//
//  UIView+XQInspectable.h
//  XiangQu
//
//  Created by taizi on 16/8/12.
//  Copyright © 2016年 Qiuyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (IFQInspectable)

@property (nonatomic, assign) IBInspectable CGFloat   ifq_CornerRadius;
@property (nonatomic, strong) IBInspectable UIColor   *ifq_BorderColor;
@property (nonatomic, assign) IBInspectable CGFloat   ifq_BorderWidth;
@property (nonatomic, assign) IBInspectable BOOL      ifq_masksToBounds;

@end
