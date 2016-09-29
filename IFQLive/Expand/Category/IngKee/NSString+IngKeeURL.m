//
//  NSString+IngKeeURL.m
//  IFQLive
//
//  Created by taizi on 16/9/28.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import "NSString+IngKeeURL.h"

static NSString * const ingKeeImgHost = @"http://img.meelive.cn/";

@implementation NSString (IngKeeURL)
- (NSString*)ifqIk_url {
    NSString *ikURL = nil;
    if (self.length>0 && (![self hasPrefix:@"http:"] && ![self hasPrefix:@"https:"])) {
        ikURL = [NSString stringWithFormat:@"%@%@",ingKeeImgHost,self];
    }
    return ikURL ? ikURL : self;
}
@end
