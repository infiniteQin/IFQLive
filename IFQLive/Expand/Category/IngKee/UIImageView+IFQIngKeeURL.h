//
//  UIImageView+IFQIngKeeURL.h
//  IFQLive
//
//  Created by taizi on 16/9/8.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImageView (IFQIngKeeURL)

- (void)ifqIk_setImageWithURL:(NSString *)url;

- (void)ifqIk_setImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder;

@end
