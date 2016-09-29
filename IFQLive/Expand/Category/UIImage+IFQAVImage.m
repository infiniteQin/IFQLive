//
//  UIImage+IFQAVImage.m
//  IFQLive
//
//  Created by taizi on 16/9/28.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import "UIImage+IFQAVImage.h"
#import <AVFoundation/AVFoundation.h>
#import <IJKMediaFramework/IJKMediaFramework.h>

@implementation UIImage (IFQAVImage)

+(instancetype)ifq_imageWithVideoURL:(NSString *)videoURL {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:videoURL] options:nil];
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    
    CGImageRelease(image);
//    NSString *videoURL = @"http://www.51ios.net/archives/784";
    
    return thumb;
}

@end
