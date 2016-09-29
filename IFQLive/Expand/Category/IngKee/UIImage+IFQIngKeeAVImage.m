//
//  UIImage+IFQIngKeeAVImage.m
//  IFQLive
//
//  Created by taizi on 16/9/28.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import "UIImage+IFQIngKeeAVImage.h"
#import "UIImage+IFQAVImage.h"
#import "NSString+IngKeeURL.h"

@implementation UIImage (IFQIngKeeAVImage)
+(instancetype)ifqIk_imageWithVideoURL:(NSString *)videoURL {
    videoURL = [videoURL ifqIk_url];
    return [self ifq_imageWithVideoURL:videoURL];
}
@end
