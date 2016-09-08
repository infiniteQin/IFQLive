//
//  UIImageView+IFQIngKeeURL.m
//  IFQLive
//
//  Created by taizi on 16/9/8.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import "UIImageView+IFQIngKeeURL.h"
#import "UIImageView+IFQWebURL.h"

static NSString * const ingKeeImgHost = @"http://img.meelive.cn/";

@implementation UIImageView (IFQIngKeeURL)

- (void)ifqIk_setImageWithURL:(NSString *)url {
    [self ifqIk_setImageWithURL:url placeholderImage:nil];
}

- (void)ifqIk_setImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder {
    if (url.length>0 && (![url hasPrefix:@"http:"] || ![url hasPrefix:@"https:"])) {
        url = [NSString stringWithFormat:@"%@%@",ingKeeImgHost,url];
    }
    [self ifq_setImageWithURL:url placeholderImage:placeholder];
}


@end
