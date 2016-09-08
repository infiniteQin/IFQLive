//
//  UIImageView+IFQWebURL.m
//  IFQLive
//
//  Created by taizi on 16/9/8.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import "UIImageView+IFQWebURL.h"

@implementation UIImageView (IFQWebURL)

- (void)ifq_setImageWithURL:(NSString *)url {
    [self ifq_setImageWithURL:url placeholderImage:nil];
}

- (void)ifq_setImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder {
    if (url.length == 0) {
        [self sd_setImageWithURL:nil placeholderImage:placeholder];
        return;
    }
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder];
}

@end
