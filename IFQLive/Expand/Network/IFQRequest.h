//
//  IFQRequest.h
//  IFQLive
//
//  Created by taizi on 16/9/28.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IFQRequest : NSObject


- (void)setTask:(NSURLSessionDataTask *)task;

- (void)cancel;

@end
