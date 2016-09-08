//
//  UIImageView+IFQWebURL.h
//  IFQLive
//
//  Created by taizi on 16/9/8.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface UIImageView (IFQWebURL)

- (void)ifq_setImageWithURL:(NSString *)url;

- (void)ifq_setImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder;

@end
